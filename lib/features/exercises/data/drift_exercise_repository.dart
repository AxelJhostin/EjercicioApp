import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../domain/exercise.dart';
import '../domain/exercise_repository.dart';

class DriftExerciseRepository implements ExerciseRepository {
  DriftExerciseRepository(this._database, {AssetBundle? assetBundle})
    : _assetBundle = assetBundle ?? rootBundle;

  final AppDatabase _database;
  final AssetBundle _assetBundle;
  Future<void>? _seedFuture;

  Future<void> _ensureSeeded() async {
    final existing = _seedFuture;
    if (existing != null) return existing;
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
    final source = await _assetBundle.loadString(
      'assets/data/exercises_v1.json',
    );
    final catalog = jsonDecode(source) as Map<String, dynamic>;
    final version = catalog['version'] as int;
    final entries = (catalog['exercises'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    if (entries.length != 60 ||
        entries.map((entry) => entry['id']).toSet().length != 60) {
      throw const FormatException(
        'El catálogo local de ejercicios está incompleto.',
      );
    }

    await _database.transaction(() async {
      final metadata = await (_database.select(
        _database.appMetadata,
      )..where((row) => row.name.equals('catalogVersion'))).getSingleOrNull();
      final count = await _database
          .customSelect('SELECT COUNT(*) AS total FROM exercises')
          .getSingle();
      if (metadata?.value == '$version' &&
          count.read<int>('total') == entries.length) {
        return;
      }

      for (final entry in entries) {
        String field(String name) => entry[name] as String;
        await _database
            .into(_database.exercises)
            .insertOnConflictUpdate(
              ExercisesCompanion(
                id: Value(field('id')),
                name: Value(field('name')),
                category: Value(field('category')),
                type: Value(field('type')),
                muscleGroup: Value(field('muscleGroup')),
                difficulty: Value(field('difficulty')),
                prescription: Value(field('prescription')),
                easyVariant: Value(field('easyVariant')),
                hardVariant: Value(field('hardVariant')),
                impact: Value(field('impact')),
                intensity: Value(field('intensity')),
                imageFilename: Value(field('imageFilename')),
                movement: Value(field('movement')),
                breathing: Value(field('breathing')),
                safety: Value(field('safety')),
                catalogVersion: Value(version),
              ),
            );
      }
      await _database
          .into(_database.appMetadata)
          .insertOnConflictUpdate(
            AppMetadataCompanion(
              name: const Value('catalogVersion'),
              value: Value('$version'),
            ),
          );
    });
  }

  @override
  Future<List<Exercise>> listAll() async {
    await _ensureSeeded();
    final rows = await (_database.select(
      _database.exercises,
    )..orderBy([(row) => OrderingTerm.asc(row.id)])).get();
    return rows.map(_toDomain).toList(growable: false);
  }

  @override
  Future<Exercise?> findById(String id) async {
    await _ensureSeeded();
    final row = await (_database.select(
      _database.exercises,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Exercise _toDomain(ExerciseRow row) => Exercise(
    id: row.id,
    name: row.name,
    category: ExerciseCategory.values.byName(row.category),
    type: ExerciseType.values.byName(row.type),
    muscleGroup: row.muscleGroup,
    difficulty: ExerciseDifficulty.values.byName(row.difficulty),
    prescription: row.prescription,
    easyVariant: row.easyVariant,
    hardVariant: row.hardVariant,
    impact: ExerciseImpact.values.byName(row.impact),
    intensity: ExerciseIntensity.values.byName(row.intensity),
    imageFilename: row.imageFilename,
    movement: row.movement,
    breathing: row.breathing,
    safety: row.safety,
  );
}

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return DriftExerciseRepository(ref.watch(databaseProvider));
});
