import 'package:drift/drift.dart';

import 'user_profiles.dart';

class ProfileAvailableDays extends Table {
  IntColumn get profileId =>
      integer().references(UserProfiles, #id, onDelete: KeyAction.cascade)();
  IntColumn get weekday => integer().check(
    const CustomExpression<bool>('weekday BETWEEN 1 AND 7'),
  )();

  @override
  Set<Column> get primaryKey => {profileId, weekday};
}
