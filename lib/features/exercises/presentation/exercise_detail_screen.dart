import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/exercise_catalog_provider.dart';
import '../domain/exercise.dart';
import 'exercise_labels.dart';

class ExerciseDetailScreen extends ConsumerWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseState = ref.watch(exerciseByIdProvider(exerciseId));
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del ejercicio')),
      body: SafeArea(
        child: exerciseState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo cargar el ejercicio local.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () =>
                        ref.invalidate(exerciseByIdProvider(exerciseId)),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
          data: (exercise) => exercise == null
              ? const Center(child: Text('Ejercicio no encontrado.'))
              : _ExerciseDetails(exercise: exercise),
        ),
      ),
    );
  }
}

class _ExerciseDetails extends StatelessWidget {
  const _ExerciseDetails({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(24),
    children: [
      Semantics(
        label: 'Imagen de ${exercise.name} pendiente',
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported_outlined, size: 44),
              SizedBox(height: 8),
              Text('Imagen local pendiente'),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      Text(exercise.name, style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 8),
      Text('${exercise.category.label} · ${exercise.difficulty.label}'),
      const SizedBox(height: 20),
      _Detail(label: 'Tipo', value: exercise.type.label),
      _Detail(label: 'Grupo', value: muscleGroupLabel(exercise.muscleGroup)),
      _Detail(label: 'Prescripción inicial', value: exercise.prescription),
      _Detail(label: 'Impacto articular', value: exercise.impact.label),
      _Detail(label: 'Intensidad', value: exercise.intensity.label),
      if (exercise.impact == ExerciseImpact.high) ...[
        const SizedBox(height: 12),
        Text(
          'Alto impacto. Alternativa de menor impacto: ${exercise.easyVariant}.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
      const SizedBox(height: 20),
      _Section(title: 'Ejecución', body: exercise.movement),
      _Section(title: 'Respiración y control', body: exercise.breathing),
      _Section(title: 'Seguridad', body: exercise.safety),
      _Section(title: 'Variante fácil', body: exercise.easyVariant),
      _Section(title: 'Variante difícil', body: exercise.hardVariant),
      const SizedBox(height: 12),
      const Text('Si aparece dolor o malestar importante, detén el ejercicio.'),
    ],
  );
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text('$label: $value'),
  );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(body),
      ],
    ),
  );
}
