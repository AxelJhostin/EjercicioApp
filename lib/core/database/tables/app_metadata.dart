import 'package:drift/drift.dart';

/// Versioned application metadata, separate from future user data tables.
class AppMetadata extends Table {
  TextColumn get name => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {name};
}
