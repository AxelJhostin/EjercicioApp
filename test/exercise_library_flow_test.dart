import 'package:casafit/app.dart';
import 'package:casafit/core/database/app_database.dart';
import 'package:casafit/features/exercises/data/drift_exercise_repository.dart';
import 'package:casafit/features/exercises/domain/exercise.dart';
import 'package:casafit/features/exercises/domain/exercise_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('biblioteca filtra y abre instrucciones del ejercicio', (
    tester,
  ) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => database),
          exerciseRepositoryProvider.overrideWith(
            (ref) => _FakeExerciseRepository(),
          ),
        ],
        child: const CasaFitApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(NavigationDestination, 'Ejercicios'));
    await tester.pumpAndSettle();
    expect(find.text('3 ejercicios'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'sentadilla con salto');
    await tester.pumpAndSettle();
    expect(find.text('1 ejercicio'), findsOneWidget);
    await tester.tap(find.text('Sentadilla con salto'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle del ejercicio'), findsOneWidget);
    expect(find.text('Imagen local pendiente'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('Alternativa de menor impacto'),
      150,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('Alternativa de menor impacto'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Seguridad'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    expect(find.text('Seguridad'), findsOneWidget);
  });

  testWidgets('aplica y restablece filtros desde la hoja inferior', (
    tester,
  ) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => database),
          exerciseRepositoryProvider.overrideWith(
            (ref) => _FakeExerciseRepository(),
          ),
        ],
        child: const CasaFitApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NavigationDestination, 'Ejercicios'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Filtros'));
    await tester.pumpAndSettle();
    expect(find.text('Filtrar ejercicios'), findsOneWidget);
    await tester.tap(find.text('Todas las categorías'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cardio').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Aplicar filtros'));
    await tester.pumpAndSettle();
    expect(find.text('Filtros activos'), findsOneWidget);
    expect(find.text('Marcha en el sitio'), findsNothing);

    await tester.tap(find.text('Filtros activos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restablecer filtros'));
    await tester.pumpAndSettle();
    expect(find.text('3 ejercicios'), findsOneWidget);
    expect(find.text('Marcha en el sitio'), findsOneWidget);
  });
}

class _FakeExerciseRepository implements ExerciseRepository {
  static const exercises = [
    Exercise(
      id: 'EX-001',
      name: 'Marcha en el sitio',
      category: ExerciseCategory.warmup,
      type: ExerciseType.warmup,
      muscleGroup: 'fullBody',
      difficulty: ExerciseDifficulty.beginner,
      prescription: '45 s',
      easyVariant: 'Marcha lenta',
      hardVariant: 'Rodillas altas',
      impact: ExerciseImpact.low,
      intensity: ExerciseIntensity.low,
      imageFilename: 'ex-001.webp',
      movement: 'Marcha sin desplazarte.',
      breathing: 'Respira con normalidad.',
      safety: 'Mantén pasos estables.',
    ),
    Exercise(
      id: 'EX-018',
      name: 'Sentadilla con salto',
      category: ExerciseCategory.legsGlutes,
      type: ExerciseType.strength,
      muscleGroup: 'legsGlutes',
      difficulty: ExerciseDifficulty.advanced,
      prescription: '8 repeticiones',
      easyVariant: 'Sentadilla rápida sin salto',
      hardVariant: 'Salto más alto',
      impact: ExerciseImpact.high,
      intensity: ExerciseIntensity.high,
      imageFilename: 'ex-018.webp',
      movement: 'Flexiona las rodillas y salta.',
      breathing: 'Exhala al subir.',
      safety: 'Aterriza suavemente.',
    ),
    Exercise(
      id: 'EX-049',
      name: 'Skater lateral',
      category: ExerciseCategory.cardio,
      type: ExerciseType.cardio,
      muscleGroup: 'fullBody',
      difficulty: ExerciseDifficulty.intermediate,
      prescription: '30 s',
      easyVariant: 'Paso lateral',
      hardVariant: 'Salto amplio',
      impact: ExerciseImpact.high,
      intensity: ExerciseIntensity.high,
      imageFilename: 'ex-049.webp',
      movement: 'Desplázate a los lados.',
      breathing: 'Respira de forma continua.',
      safety: 'Cuida el apoyo de rodillas.',
    ),
  ];

  @override
  Future<List<Exercise>> listAll() async => exercises;

  @override
  Future<Exercise?> findById(String id) async {
    for (final exercise in exercises) {
      if (exercise.id == id) return exercise;
    }
    return null;
  }
}
