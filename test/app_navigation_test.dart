import 'package:casafit/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Inicio navega a Rutinas y Progreso', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CasaFitApp()));
    await tester.pumpAndSettle();

    expect(find.text('Entrena a tu ritmo'), findsOneWidget);
    await tester.tap(find.text('Explorar rutinas'));
    await tester.pumpAndSettle();
    expect(
      find.text('Aquí aparecerán tus rutinas para entrenar en casa.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(NavigationDestination, 'Progreso'));
    await tester.pumpAndSettle();
    expect(find.text('Aquí podrás consultar tu evolución.'), findsOneWidget);
  });
}
