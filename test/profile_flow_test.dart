import 'package:casafit/app.dart';
import 'package:casafit/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('configuración inicial valida y guarda el perfil', (
    tester,
  ) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWith((ref) => database)],
        child: const CasaFitApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Configurar perfil'));
    await tester.pumpAndSettle();
    final saveButton = find.byKey(const ValueKey('save-profile'));
    await tester.scrollUntilVisible(
      saveButton,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Selecciona un objetivo.'), findsOneWidget);
    expect(find.text('Selecciona al menos un día.'), findsOneWidget);

    final goalField = find.byKey(const ValueKey('goal-field'));
    await tester.scrollUntilVisible(
      goalField,
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(goalField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Crear hábito').last);
    await tester.pumpAndSettle();

    final levelField = find.byKey(const ValueKey('level-field'));
    await tester.scrollUntilVisible(
      levelField,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(levelField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Principiante').last);
    await tester.pumpAndSettle();

    final monday = find.byKey(const ValueKey('day-1'));
    await tester.scrollUntilVisible(
      monday,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(monday);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      saveButton,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Entrena a tu ritmo'), findsOneWidget);
    expect(find.text('Ver mi perfil'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('Crear hábito'), findsOneWidget);
    expect(find.text('Lun'), findsOneWidget);

    await tester.tap(find.text('Editar perfil'));
    await tester.pumpAndSettle();
    final pounds = find.text('lb');
    await tester.scrollUntilVisible(
      pounds,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(pounds);
    await tester.pumpAndSettle();
    final weightField = find.byKey(const ValueKey('weight-field'));
    await tester.scrollUntilVisible(
      weightField,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(weightField, '0');
    await tester.scrollUntilVisible(
      saveButton,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Introduce un número mayor que cero.'), findsOneWidget);
    await tester.ensureVisible(weightField);
    await tester.enterText(weightField, '');
    await tester.scrollUntilVisible(
      saveButton,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('lb'), findsOneWidget);
  });
}
