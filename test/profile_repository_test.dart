import 'dart:io';

import 'package:casafit/core/database/app_database.dart';
import 'package:casafit/core/units/weight_converter.dart';
import 'package:casafit/features/profile/data/drift_profile_repository.dart';
import 'package:casafit/features/profile/domain/user_profile.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('perfil y unidad persisten tras reabrir SQLite', () async {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}casafit_profile_${DateTime.now().microsecondsSinceEpoch}.sqlite',
    );
    addTearDown(() async {
      if (await file.exists()) await file.delete();
    });

    final firstDatabase = AppDatabase(executor: NativeDatabase(file));
    final repository = DriftProfileRepository(firstDatabase);
    final weightKg = WeightConverter.toKilograms(150, WeightUnit.lb);
    await repository.save(
      UserProfile(
        goal: FitnessGoal.gainStrength,
        level: FitnessLevel.beginner,
        availableDays: {DateTime.monday, DateTime.wednesday},
        preferredDurationMinutes: 30,
        weightUnit: WeightUnit.lb,
        displayName: 'Ana',
        initialWeightKg: weightKg,
      ),
    );
    await firstDatabase.close();

    final reopened = AppDatabase(executor: NativeDatabase(file));
    addTearDown(reopened.close);
    final saved = await DriftProfileRepository(reopened).load();
    expect(saved, isNotNull);
    expect(saved!.goal, FitnessGoal.gainStrength);
    expect(saved.availableDays, {DateTime.monday, DateTime.wednesday});
    expect(saved.weightUnit, WeightUnit.lb);
    expect(saved.initialWeightKg, closeTo(weightKg, 0.000001));

    await DriftProfileRepository(reopened).save(
      UserProfile(
        goal: FitnessGoal.buildHabit,
        level: FitnessLevel.intermediate,
        availableDays: {DateTime.friday},
        preferredDurationMinutes: 20,
        weightUnit: WeightUnit.kg,
      ),
    );
    final edited = await DriftProfileRepository(reopened).load();
    expect(edited!.goal, FitnessGoal.buildHabit);
    expect(edited.availableDays, {DateTime.friday});
    expect(edited.initialWeightKg, isNull);
    final count = await reopened
        .customSelect('SELECT COUNT(*) AS total FROM user_profiles')
        .getSingle();
    expect(count.read<int>('total'), 1);
  });

  test('valores inválidos no se guardan', () async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftProfileRepository(database);

    await expectLater(
      repository.save(
        UserProfile(
          goal: FitnessGoal.buildHabit,
          level: FitnessLevel.beginner,
          availableDays: {},
          preferredDurationMinutes: 10,
          weightUnit: WeightUnit.kg,
        ),
      ),
      throwsFormatException,
    );
    expect(await repository.load(), isNull);
  });

  test('migración 1→3 conserva metadatos y crea tablas nuevas', () async {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}casafit_migration_${DateTime.now().microsecondsSinceEpoch}.sqlite',
    );
    addTearDown(() async {
      if (await file.exists()) await file.delete();
    });

    final oldDatabase = AppDatabase(executor: NativeDatabase(file));
    await oldDatabase.customStatement(
      'INSERT INTO app_metadata (name, value) VALUES (?, ?)',
      ['catalogVersion', '1'],
    );
    await oldDatabase.customStatement('DROP TABLE profile_available_days');
    await oldDatabase.customStatement('DROP TABLE user_preferences');
    await oldDatabase.customStatement('DROP TABLE user_profiles');
    await oldDatabase.customStatement('DROP TABLE exercises');
    await oldDatabase.customStatement('PRAGMA user_version = 1');
    await oldDatabase.close();

    final upgraded = AppDatabase(executor: NativeDatabase(file));
    addTearDown(upgraded.close);
    final metadata = await upgraded
        .customSelect('SELECT value FROM app_metadata')
        .getSingle();
    expect(metadata.read<String>('value'), '1');
    expect(await DriftProfileRepository(upgraded).load(), isNull);
    final version = await upgraded
        .customSelect('PRAGMA user_version')
        .getSingle();
    expect(version.read<int>('user_version'), 3);
    final exerciseCount = await upgraded
        .customSelect('SELECT COUNT(*) AS total FROM exercises')
        .getSingle();
    expect(exerciseCount.read<int>('total'), 0);
  });
}
