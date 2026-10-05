import 'dart:io';

import 'package:casafit/core/database/app_database.dart';
import 'package:casafit/features/exercises/data/drift_exercise_repository.dart';
import 'package:casafit/features/exercises/domain/exercise.dart';
import 'package:casafit/features/profile/data/drift_profile_repository.dart';
import 'package:casafit/features/profile/domain/user_profile.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'carga los 60 ejercicios una sola vez y permite consultar el detalle',
    () async {
      final database = AppDatabase(executor: NativeDatabase.memory());
      addTearDown(database.close);
      final repository = DriftExerciseRepository(database);

      final exercises = await repository.listAll();
      expect(exercises, hasLength(60));
      expect(exercises.map((exercise) => exercise.id).toSet(), hasLength(60));
      expect(exercises.first.id, 'EX-001');
      expect(exercises.last.id, 'EX-060');

      final jumpSquat = await repository.findById('EX-018');
      expect(jumpSquat?.name, 'Sentadilla con salto');
      expect(jumpSquat?.impact, ExerciseImpact.high);
      expect(jumpSquat?.safety, contains('sin salto'));
      expect(jumpSquat?.movement, isNotEmpty);
      expect(await repository.findById('EX-999'), isNull);

      final secondRepository = DriftExerciseRepository(database);
      expect(await secondRepository.listAll(), hasLength(60));
      final storedCount = await database
          .customSelect('SELECT COUNT(*) AS total FROM exercises')
          .getSingle();
      expect(storedCount.read<int>('total'), 60);
      final version = await database
          .customSelect(
            "SELECT value FROM app_metadata WHERE name = 'catalogVersion'",
          )
          .getSingle();
      expect(version.read<String>('value'), '1');
    },
  );

  test('filtra por categoría, dificultad y búsqueda sin tildes', () async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    final exercises = await DriftExerciseRepository(database).listAll();

    final results = filterExercises(
      exercises,
      query: 'sentadilla con salto',
      category: ExerciseCategory.legsGlutes,
      difficulty: ExerciseDifficulty.advanced,
    );
    expect(results.map((exercise) => exercise.id), contains('EX-018'));
    expect(
      filterExercises(exercises, query: 'circulos de brazos').single.id,
      'EX-002',
    );
    expect(
      filterExercises(
        exercises,
        category: ExerciseCategory.cardio,
      ).every((exercise) => exercise.category == ExerciseCategory.cardio),
      isTrue,
    );
  });

  test('migración 2→3 conserva el perfil y crea el catálogo', () async {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}casafit_exercises_${DateTime.now().microsecondsSinceEpoch}.sqlite',
    );
    addTearDown(() async {
      if (await file.exists()) await file.delete();
    });

    final oldDatabase = AppDatabase(executor: NativeDatabase(file));
    await DriftProfileRepository(oldDatabase).save(
      UserProfile(
        goal: FitnessGoal.buildHabit,
        level: FitnessLevel.beginner,
        availableDays: {DateTime.monday},
        preferredDurationMinutes: 30,
        weightUnit: WeightUnit.kg,
        displayName: 'Ana',
      ),
    );
    await oldDatabase.customStatement(
      'INSERT INTO app_metadata (name, value) VALUES (?, ?)',
      ['catalogVersion', '1'],
    );
    await oldDatabase.customStatement('DROP TABLE exercises');
    await oldDatabase.customStatement('PRAGMA user_version = 2');
    await oldDatabase.close();

    final upgraded = AppDatabase(executor: NativeDatabase(file));
    addTearDown(upgraded.close);
    expect((await DriftProfileRepository(upgraded).load())?.displayName, 'Ana');
    expect(await DriftExerciseRepository(upgraded).listAll(), hasLength(60));
    final version = await upgraded
        .customSelect('PRAGMA user_version')
        .getSingle();
    expect(version.read<int>('user_version'), 3);
  });
}
