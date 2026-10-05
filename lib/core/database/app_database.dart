import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tables/app_metadata.dart';
import 'tables/exercises.dart';
import 'tables/profile_available_days.dart';
import 'tables/user_preferences.dart';
import 'tables/user_profiles.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AppMetadata,
    UserProfiles,
    UserPreferences,
    ProfileAvailableDays,
    Exercises,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor})
    : super(executor ?? driftDatabase(name: 'casafit'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(userProfiles);
        await migrator.createTable(userPreferences);
        await migrator.createTable(profileAvailableDays);
      }
      if (from < 3) {
        await migrator.createTable(exercises);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
