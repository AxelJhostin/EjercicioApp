import 'package:drift/drift.dart';

import 'exercises.dart';
import 'routines.dart';

@DataClassName('RoutineExerciseRow')
class RoutineExercises extends Table {
  TextColumn get routineId =>
      text().references(Routines, #id, onDelete: KeyAction.cascade)();
  IntColumn get position =>
      integer().check(const CustomExpression<bool>('position > 0'))();
  TextColumn get exerciseId => text().references(Exercises, #id)();
  IntColumn get sets =>
      integer().check(const CustomExpression<bool>('sets > 0'))();
  TextColumn get prescriptionType => text()();
  IntColumn get targetReps => integer().nullable()();
  IntColumn get targetSeconds => integer().nullable()();
  IntColumn get restSeconds =>
      integer().check(const CustomExpression<bool>('rest_seconds >= 0'))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {routineId, position};
}
