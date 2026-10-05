import 'package:drift/drift.dart';

import 'user_profiles.dart';

@DataClassName('UserPreferencesRow')
class UserPreferences extends Table {
  IntColumn get profileId =>
      integer().references(UserProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get weightUnit => text()();
  TextColumn get lengthUnit => text().withDefault(const Constant('cm'))();

  @override
  Set<Column> get primaryKey => {profileId};
}
