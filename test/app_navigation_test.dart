import 'package:casafit/app.dart';
import 'package:casafit/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Inicio navega a Progreso', (tester) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWith((ref) => database)],
        child: const CasaFitApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entrena a tu ritmo'), findsOneWidget);
    await tester.tap(find.widgetWithText(NavigationDestination, 'Progreso'));
    await tester.pumpAndSettle();
    expect(find.text('Aquí podrás consultar tu evolución.'), findsOneWidget);
  });
}
