import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../exercises/data/drift_exercise_repository.dart';
import '../../exercises/domain/exercise_repository.dart';
import '../../profile/domain/user_profile.dart';
import '../domain/routine.dart';
import '../domain/routine_repository.dart';

class DriftRoutineRepository implements RoutineRepository {
  DriftRoutineRepository(
    this._database,
    this._exerciseRepository, {
    AssetBundle? assetBundle,
  }) : _assetBundle = assetBundle ?? rootBundle;

  final AppDatabase _database;
  final ExerciseRepository _exerciseRepository;
  final AssetBundle _assetBundle;
  Future<void>? _seedFuture;

  Future<void> _ensureSeeded() async {
    final existing = _seedFuture;
    if (existing != null) {
      await existing;
      return;
    }
    final future = _seed();
    _seedFuture = future;
    try {
      await future;
    } catch (_) {
      _seedFuture = null;
      rethrow;
    }
  }

  Future<void> _seed() async {
    final exercises = await _exerciseRepository.listAll();
    final exerciseIds = exercises.map((exercise) => exercise.id).toSet();
    final source = await _assetBundle.loadString(
      'assets/data/routines_v1.json',
    );
    final catalog = jsonDecode(source) as Map<String, dynamic>;
    final version = catalog['version'] as int;
    final entries = (catalog['routines'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final ids = entries.map((routine) => routine['id']).toSet();
    final combinations = entries
        .map((routine) => '${routine['goal']}:${routine['level']}')
        .toSet();
    if (version < 1 ||
        entries.length != 12 ||
        ids.length != 12 ||
        combinations.length != 12) {
      throw const FormatException(
        'El catálogo local de rutinas está incompleto.',
      );
    }
    var expectedSteps = 0;
    for (final routine in entries) {
      final steps = (routine['exercises'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      expectedSteps += steps.length;
      if (routine['kind'] != 'official' ||
          routine['editable'] != false ||
          routine['originRoutineId'] != null ||
          steps.length < 6) {
        throw FormatException('Rutina oficial inválida: ${routine['id']}');
      }
      for (var index = 0; index < steps.length; index++) {
        final step = steps[index];
        final reps = step['targetReps'] as int?;
        final seconds = step['targetSeconds'] as int?;
        if (!exerciseIds.contains(step['exerciseId']) ||
            step['position'] != index + 1 ||
            (step['sets'] as int) < 1 ||
            (step['restSeconds'] as int) < 0 ||
            (reps == null) == (seconds == null) ||
            (reps != null && reps < 1) ||
            (seconds != null && seconds < 1)) {
          throw FormatException('Prescripción inválida en ${routine['id']}');
        }
      }
    }

    await _database.transaction(() async {
      final metadata =
          await (_database.select(_database.appMetadata)
                ..where((row) => row.name.equals('routineCatalogVersion')))
              .getSingleOrNull();
      final counts = await _database.customSelect('''
        SELECT COUNT(DISTINCT r.id) AS routines, COUNT(re.position) AS steps
        FROM routines r
        LEFT JOIN routine_exercises re ON re.routine_id = r.id
        WHERE r.kind = 'official'
      ''').getSingle();
      if (metadata?.value == '$version' &&
          counts.read<int>('routines') == entries.length &&
          counts.read<int>('steps') == expectedSteps) {
        return;
      }

      for (final entry in entries) {
        String field(String name) => entry[name] as String;
        final routineId = field('id');
        await _database
            .into(_database.routines)
            .insertOnConflictUpdate(
              RoutinesCompanion(
                id: Value(routineId),
                name: Value(field('name')),
                description: Value(field('description')),
                goal: Value(field('goal')),
                level: Value(field('level')),
                estimatedMinutes: Value(entry['estimatedMinutes'] as int),
                kind: const Value('official'),
                originRoutineId: const Value(null),
                editable: const Value(false),
                archived: const Value(false),
                safetyNote: Value(field('safetyNote')),
                contentVersion: Value(version),
              ),
            );
        await (_database.delete(
          _database.routineExercises,
        )..where((row) => row.routineId.equals(routineId))).go();
        for (final step
            in (entry['exercises'] as List<dynamic>)
                .cast<Map<String, dynamic>>()) {
          await _database
              .into(_database.routineExercises)
              .insert(
                RoutineExercisesCompanion(
                  routineId: Value(routineId),
                  position: Value(step['position'] as int),
                  exerciseId: Value(step['exerciseId'] as String),
                  sets: Value(step['sets'] as int),
                  prescriptionType: Value(step['prescriptionType'] as String),
                  targetReps: Value(step['targetReps'] as int?),
                  targetSeconds: Value(step['targetSeconds'] as int?),
                  restSeconds: Value(step['restSeconds'] as int),
                  notes: Value(step['notes'] as String?),
                ),
              );
        }
      }
      await _database
          .into(_database.appMetadata)
          .insertOnConflictUpdate(
            AppMetadataCompanion(
              name: const Value('routineCatalogVersion'),
              value: Value('$version'),
            ),
          );
    });
  }

  @override
  Future<List<Routine>> listOfficial() async {
    await _ensureSeeded();
    final routineRows =
        await (_database.select(_database.routines)..where(
              (row) => row.kind.equals('official') & row.archived.equals(false),
            ))
            .get();
    if (routineRows.isEmpty) return const [];
    final ids = routineRows.map((row) => row.id).toList(growable: false);
    final stepRows =
        await (_database.select(_database.routineExercises)
              ..where((row) => row.routineId.isIn(ids))
              ..orderBy([(row) => OrderingTerm.asc(row.position)]))
            .get();
    final exerciseById = {
      for (final exercise in await _exerciseRepository.listAll())
        exercise.id: exercise,
    };
    final stepsByRoutine = <String, List<RoutineStep>>{};
    for (final row in stepRows) {
      final exercise = exerciseById[row.exerciseId];
      if (exercise == null) {
        throw StateError('Falta el ejercicio ${row.exerciseId} de una rutina.');
      }
      stepsByRoutine
          .putIfAbsent(row.routineId, () => [])
          .add(
            RoutineStep(
              position: row.position,
              exercise: exercise,
              sets: row.sets,
              prescriptionType: PrescriptionType.values.byName(
                row.prescriptionType,
              ),
              targetReps: row.targetReps,
              targetSeconds: row.targetSeconds,
              restSeconds: row.restSeconds,
              notes: row.notes,
            ),
          );
    }
    final routines = routineRows
        .map(
          (row) => Routine(
            id: row.id,
            name: row.name,
            description: row.description,
            goal: FitnessGoal.values.byName(row.goal),
            level: FitnessLevel.values.byName(row.level),
            estimatedMinutes: row.estimatedMinutes,
            kind: RoutineKind.values.byName(row.kind),
            originRoutineId: row.originRoutineId,
            editable: row.editable,
            archived: row.archived,
            safetyNote: row.safetyNote,
            contentVersion: row.contentVersion,
            steps: stepsByRoutine[row.id] ?? const [],
          ),
        )
        .toList(growable: false);
    routines.sort((first, second) {
      final byGoal = FitnessGoal.values
          .indexOf(first.goal)
          .compareTo(FitnessGoal.values.indexOf(second.goal));
      return byGoal != 0
          ? byGoal
          : FitnessLevel.values
                .indexOf(first.level)
                .compareTo(FitnessLevel.values.indexOf(second.level));
    });
    return routines;
  }

  @override
  Future<Routine?> findOfficialById(String id) async {
    final routines = await listOfficial();
    for (final routine in routines) {
      if (routine.id == id) return routine;
    }
    return null;
  }
}

final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  return DriftRoutineRepository(
    ref.watch(databaseProvider),
    ref.watch(exerciseRepositoryProvider),
  );
});
