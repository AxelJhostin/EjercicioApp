import 'dart:io';

import 'package:casafit/core/database/app_database.dart';
import 'package:casafit/features/exercises/data/drift_exercise_repository.dart';
import 'package:casafit/features/exercises/domain/exercise.dart';
import 'package:casafit/features/profile/data/drift_profile_repository.dart';
import 'package:casafit/features/profile/domain/user_profile.dart';
import 'package:casafit/features/routines/data/drift_routine_repository.dart';
import 'package:casafit/features/routines/domain/routine.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('carga 12 plantillas oficiales completas e idempotentes', () async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    final exerciseRepository = DriftExerciseRepository(database);
    final repository = DriftRoutineRepository(database, exerciseRepository);

    final routines = await repository.listOfficial();
    expect(routines, hasLength(12));
    expect(
      routines.map((routine) => '${routine.goal}:${routine.level}').toSet(),
      hasLength(12),
    );
    expect(
      routines.every(
        (routine) =>
            routine.kind == RoutineKind.official &&
            !routine.editable &&
            !routine.archived &&
            routine.estimatedMinutes >= 15 &&
            routine.estimatedMinutes <= 45,
      ),
      isTrue,
    );
    for (final routine in routines) {
      expect(routine.steps.length, greaterThanOrEqualTo(6));
      expect(routine.steps.first.exercise.category, ExerciseCategory.warmup);
      expect(
        routine.steps.last.exercise.category,
        ExerciseCategory.mobilityCooldown,
      );
      expect(
        routine.steps.map((step) => step.position).toList(),
        List.generate(routine.steps.length, (index) => index + 1),
      );
      expect(
        routine.steps.every(
          (step) =>
              step.sets > 0 &&
              step.restSeconds >= 0 &&
              ((step.targetReps == null) != (step.targetSeconds == null)),
        ),
        isTrue,
      );
    }
    final advanced = await repository.findOfficialById('OFF-LOSE-ADVANCED');
    expect(advanced?.safetyNote, contains('alto impacto'));
    expect(await repository.findOfficialById('OFF-MISSING'), isNull);

    final secondRepository = DriftRoutineRepository(
      database,
      exerciseRepository,
    );
    expect(await secondRepository.listOfficial(), hasLength(12));
    final row = await database.customSelect('''
      SELECT COUNT(*) AS total FROM routine_exercises
    ''').getSingle();
    expect(
      row.read<int>('total'),
      routines.fold<int>(0, (total, routine) => total + routine.steps.length),
    );
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_key_check')
        .get();
    expect(foreignKeys, isEmpty);
    final metadata = await database
        .customSelect(
          "SELECT value FROM app_metadata WHERE name = 'routineCatalogVersion'",
        )
        .getSingle();
    expect(metadata.read<String>('value'), '1');
  });

  test('filtro por objetivo y nivel conserva la plantilla esperada', () async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    final routines = await DriftRoutineRepository(
      database,
      DriftExerciseRepository(database),
    ).listOfficial();
    final selected = filterRoutines(
      routines,
      goal: FitnessGoal.buildHabit,
      level: FitnessLevel.beginner,
    );
    expect(selected.single.id, 'OFF-HABIT-BEGINNER');
  });

  test('migración 3→4 conserva perfil y ejercicios', () async {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}casafit_routines_${DateTime.now().microsecondsSinceEpoch}.sqlite',
    );
    addTearDown(() async {
      if (await file.exists()) await file.delete();
    });
    final oldDatabase = AppDatabase(executor: NativeDatabase(file));
    await DriftProfileRepository(oldDatabase).save(
      UserProfile(
        goal: FitnessGoal.improveCondition,
        level: FitnessLevel.intermediate,
        availableDays: {DateTime.monday, DateTime.thursday},
        preferredDurationMinutes: 30,
        weightUnit: WeightUnit.kg,
        displayName: 'Ana',
      ),
    );
    await DriftExerciseRepository(oldDatabase).listAll();
    await oldDatabase.customStatement('DROP TABLE routine_exercises');
    await oldDatabase.customStatement('DROP TABLE routines');
    await oldDatabase.customStatement('PRAGMA user_version = 3');
    await oldDatabase.close();

    final upgraded = AppDatabase(executor: NativeDatabase(file));
    addTearDown(upgraded.close);
    expect((await DriftProfileRepository(upgraded).load())?.displayName, 'Ana');
    expect(await DriftExerciseRepository(upgraded).listAll(), hasLength(60));
    expect(
      await DriftRoutineRepository(
        upgraded,
        DriftExerciseRepository(upgraded),
      ).listOfficial(),
      hasLength(12),
    );
    final version = await upgraded
        .customSelect('PRAGMA user_version')
        .getSingle();
    expect(version.read<int>('user_version'), 4);
  });
}
