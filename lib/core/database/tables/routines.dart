import 'package:drift/drift.dart';

@DataClassName('RoutineRow')
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get goal => text()();
  TextColumn get level => text()();
  IntColumn get estimatedMinutes => integer().check(
    const CustomExpression<bool>('estimated_minutes BETWEEN 15 AND 45'),
  )();
  TextColumn get kind => text()();
  TextColumn get originRoutineId => text().nullable()();
  BoolColumn get editable => boolean()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  TextColumn get safetyNote => text()();
  IntColumn get contentVersion => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
