import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../exercises/domain/exercise.dart';
import '../../profile/presentation/profile_labels.dart';
import '../application/routine_catalog_provider.dart';
import '../domain/routine.dart';

class RoutineDetailScreen extends ConsumerWidget {
  const RoutineDetailScreen({super.key, required this.routineId});

  final String routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineState = ref.watch(officialRoutineByIdProvider(routineId));
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de la rutina')),
      body: SafeArea(
        child: routineState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo cargar la rutina local.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () =>
                        ref.invalidate(officialRoutineByIdProvider(routineId)),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
          data: (routine) => routine == null
              ? const Center(child: Text('Rutina no encontrada.'))
              : _RoutineDetails(routine: routine),
        ),
      ),
    );
  }
}

class _RoutineDetails extends StatelessWidget {
  const _RoutineDetails({required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(24),
    children: [
      Text(routine.name, style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 8),
      Text(routine.description),
      const SizedBox(height: 16),
      Text(
        '${routine.goal.label} · ${routine.level.label} · ${routine.estimatedMinutes} min',
      ),
      const SizedBox(height: 4),
      const Text('Plantilla oficial · solo lectura · sin equipamiento'),
      const SizedBox(height: 20),
      Text('Antes de empezar', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 6),
      Text(routine.safetyNote),
      const SizedBox(height: 20),
      Text(
        'Ejercicios en orden',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 8),
      for (final step in routine.steps) ...[
        if (step.position == 1 ||
            (step.position > 1 &&
                _phase(step) != _phase(routine.steps[step.position - 2])))
          _PhaseHeading(label: _phase(step)),
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(child: Text('${step.position}')),
            title: Text(step.exercise.name),
            subtitle: Text(
              '${step.sets} ${step.sets == 1 ? 'serie' : 'series'} × ${step.targetLabel}'
              '${step.restSeconds > 0 ? '\nDescanso sugerido: ${step.restSeconds} s' : ''}',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/exercises/${step.exercise.id}'),
          ),
        ),
      ],
      const SizedBox(height: 16),
      const Text(
        'Consulta cada ejercicio para ver la ejecución, las variantes y las recomendaciones de seguridad.',
      ),
    ],
  );
}

String _phase(RoutineStep step) => switch (step.exercise.category) {
  ExerciseCategory.warmup => 'Calentamiento',
  ExerciseCategory.mobilityCooldown => 'Enfriamiento',
  _ => 'Bloque principal',
};

class _PhaseHeading extends StatelessWidget {
  const _PhaseHeading({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(label, style: Theme.of(context).textTheme.titleMedium),
  );
}
