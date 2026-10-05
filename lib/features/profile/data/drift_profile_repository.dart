import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';

class DriftProfileRepository implements ProfileRepository {
  DriftProfileRepository(this._database);

  final AppDatabase _database;

  @override
  Future<UserProfile?> load() async {
    final stored = await (_database.select(
      _database.userProfiles,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    if (stored == null) return null;

    final preferences = await (_database.select(
      _database.userPreferences,
    )..where((row) => row.profileId.equals(1))).getSingleOrNull();
    if (preferences == null) {
      throw StateError('No se encontraron las preferencias del perfil.');
    }

    final days = await (_database.select(
      _database.profileAvailableDays,
    )..where((row) => row.profileId.equals(1))).get();

    return UserProfile(
      goal: FitnessGoal.values.byName(stored.goal),
      level: FitnessLevel.values.byName(stored.level),
      availableDays: days.map((day) => day.weekday).toSet(),
      preferredDurationMinutes: stored.preferredDurationMinutes,
      weightUnit: WeightUnit.values.byName(preferences.weightUnit),
      displayName: stored.displayName,
      age: stored.age,
      heightCm: stored.heightCm,
      initialWeightKg: stored.initialWeightKg,
    );
  }

  @override
  Future<void> save(UserProfile profile) async {
    profile.validate();
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.userProfiles,
      )..where((row) => row.id.equals(1))).getSingleOrNull();
      final now = DateTime.now().toUtc();

      await _database
          .into(_database.userProfiles)
          .insertOnConflictUpdate(
            UserProfilesCompanion(
              id: const Value(1),
              displayName: Value(profile.displayName?.trim()),
              age: Value(profile.age),
              heightCm: Value(profile.heightCm),
              initialWeightKg: Value(profile.initialWeightKg),
              goal: Value(profile.goal.name),
              level: Value(profile.level.name),
              preferredDurationMinutes: Value(profile.preferredDurationMinutes),
              onboardingCompleted: const Value(true),
              createdAtUtc: Value(existing?.createdAtUtc ?? now),
              updatedAtUtc: Value(now),
            ),
          );
      await _database
          .into(_database.userPreferences)
          .insertOnConflictUpdate(
            UserPreferencesCompanion(
              profileId: const Value(1),
              weightUnit: Value(profile.weightUnit.name),
              lengthUnit: const Value('cm'),
            ),
          );
      await (_database.delete(
        _database.profileAvailableDays,
      )..where((row) => row.profileId.equals(1))).go();
      for (final weekday in profile.availableDays) {
        await _database
            .into(_database.profileAvailableDays)
            .insert(
              ProfileAvailableDaysCompanion(
                profileId: const Value(1),
                weekday: Value(weekday),
              ),
            );
      }
    });
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return DriftProfileRepository(ref.watch(databaseProvider));
});
