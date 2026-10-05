import 'package:casafit/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Drift crea la base local y conserva metadatos', () async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);

    await database.customStatement(
      'INSERT INTO app_metadata (name, value) VALUES (?, ?)',
      ['catalogVersion', '1'],
    );
    final rows = await database
        .customSelect('SELECT value FROM app_metadata')
        .get();

    expect(rows.single.read<String>('value'), '1');
    expect(database.schemaVersion, 4);
  });
}
