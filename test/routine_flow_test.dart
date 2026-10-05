import 'package:casafit/app.dart';
import 'package:casafit/core/database/app_database.dart';
import 'package:casafit/features/exercises/data/drift_exercise_repository.dart';
import 'package:casafit/features/exercises/domain/exercise.dart';
import 'package:casafit/features/exercises/domain/exercise_repository.dart';
import 'package:casafit/features/profile/domain/user_profile.dart';
import 'package:casafit/features/routines/data/drift_routine_repository.dart';
import 'package:casafit/features/routines/domain/routine.dart';
import 'package:casafit/features/routines/domain/routine_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('filtra rutinas y consulta sus ejercicios', (tester) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith((ref) => database),
          exerciseRepositoryProvider.overrideWith(
            (ref) => _FakeExerciseRepository(),
          ),
          routineRepositoryProvider.overrideWith(
            (ref) => _FakeRoutineRepository(),
          ),
        ],
        child: const CasaFitApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NavigationDestination, 'Rutinas'));
    await tester.pumpAndSettle();
    expect(find.text('2 rutinas'), findsOneWidget);

    await tester.tap(find.text('Todos los objetivos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ganar fuerza').last);
    await tester.pumpAndSettle();
    expect(find.text('1 rutina'), findsOneWidget);
    expect(find.text('Fuerza esencial'), findsOneWidget);
    expect(find.text('Movimiento para empezar'), findsNothing);

    await tester.tap(find.text('Fuerza esencial'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle de la rutina'), findsOneWidget);
    expect(
      find.text('Plantilla oficial · solo lectura · sin equipamiento'),
      findsOneWidget,
    );
    expect(find.text('Calentamiento'), findsOneWidget);
    expect(find.text('Bloque principal'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Sentadilla con peso corporal'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Sentadilla con peso corporal'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle del ejercicio'), findsOneWidget);
  });
}

const _warmup = Exercise(
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
);

const _squat = Exercise(
  id: 'EX-007',
  name: 'Sentadilla con peso corporal',
  category: ExerciseCategory.legsGlutes,
  type: ExerciseType.strength,
  muscleGroup: 'legsGlutes',
  difficulty: ExerciseDifficulty.beginner,
  prescription: '10 repeticiones',
  easyVariant: 'Sentadilla parcial',
  hardVariant: 'Sentadilla con pausa',
  impact: ExerciseImpact.low,
  intensity: ExerciseIntensity.low,
  imageFilename: 'ex-007.webp',
  movement: 'Flexiona rodillas y caderas.',
  breathing: 'Exhala al subir.',
  safety: 'Controla la postura.',
);

class _FakeExerciseRepository implements ExerciseRepository {
  @override
  Future<List<Exercise>> listAll() async => [_warmup, _squat];

  @override
  Future<Exercise?> findById(String id) async => switch (id) {
    'EX-001' => _warmup,
    'EX-007' => _squat,
    _ => null,
  };
}

class _FakeRoutineRepository implements RoutineRepository {
  static final routines = [
    Routine(
      id: 'OFF-LOSE-BEGINNER',
      name: 'Movimiento para empezar',
      description: 'Cardio suave y fuerza básica.',
      goal: FitnessGoal.loseWeight,
      level: FitnessLevel.beginner,
      estimatedMinutes: 20,
      kind: RoutineKind.official,
      originRoutineId: null,
      editable: false,
      archived: false,
      safetyNote: 'Ajusta el ritmo a tu capacidad.',
      contentVersion: 1,
      steps: const [],
    ),
    Routine(
      id: 'OFF-STRENGTH-BEGINNER',
      name: 'Fuerza esencial',
      description: 'Fuerza con movimientos controlados.',
      goal: FitnessGoal.gainStrength,
      level: FitnessLevel.beginner,
      estimatedMinutes: 20,
      kind: RoutineKind.official,
      originRoutineId: null,
      editable: false,
      archived: false,
      safetyNote: 'Ajusta el ritmo a tu capacidad.',
      contentVersion: 1,
      steps: const [
        RoutineStep(
          position: 1,
          exercise: _warmup,
          sets: 1,
          prescriptionType: PrescriptionType.seconds,
          targetReps: null,
          targetSeconds: 45,
          restSeconds: 0,
          notes: null,
        ),
        RoutineStep(
          position: 2,
          exercise: _squat,
          sets: 2,
          prescriptionType: PrescriptionType.repetitions,
          targetReps: 10,
          targetSeconds: null,
          restSeconds: 45,
          notes: null,
        ),
      ],
    ),
  ];

  @override
  Future<List<Routine>> listOfficial() async => routines;

  @override
  Future<Routine?> findOfficialById(String id) async {
    for (final routine in routines) {
      if (routine.id == id) return routine;
    }
    return null;
  }
}
