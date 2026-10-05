import 'package:drift/drift.dart';

@DataClassName('UserProfileRow')
class UserProfiles extends Table {
  IntColumn get id => integer().check(const CustomExpression<bool>('id = 1'))();
  TextColumn get displayName => text().nullable()();
  IntColumn get age => integer().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get initialWeightKg => real().nullable()();
  TextColumn get goal => text()();
  TextColumn get level => text()();
  IntColumn get preferredDurationMinutes => integer()();
  BoolColumn get onboardingCompleted => boolean()();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
