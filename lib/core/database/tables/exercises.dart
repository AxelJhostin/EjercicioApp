import 'package:drift/drift.dart';

@DataClassName('ExerciseRow')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get type => text()();
  TextColumn get muscleGroup => text()();
  TextColumn get difficulty => text()();
  TextColumn get prescription => text()();
  TextColumn get easyVariant => text()();
  TextColumn get hardVariant => text()();
  TextColumn get impact => text()();
  TextColumn get intensity => text()();
  TextColumn get imageFilename => text()();
  TextColumn get movement => text()();
  TextColumn get breathing => text()();
  TextColumn get safety => text()();
  IntColumn get catalogVersion => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
