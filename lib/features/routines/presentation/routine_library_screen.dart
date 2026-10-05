import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../profile/domain/user_profile.dart';
import '../../profile/presentation/profile_labels.dart';
import '../application/routine_catalog_provider.dart';
import '../domain/routine.dart';

class RoutineLibraryScreen extends ConsumerStatefulWidget {
  const RoutineLibraryScreen({super.key});

  @override
  ConsumerState<RoutineLibraryScreen> createState() =>
      _RoutineLibraryScreenState();
}

class _RoutineLibraryScreenState extends ConsumerState<RoutineLibraryScreen> {
  FitnessGoal? _goal;
  FitnessLevel? _level;

  @override
  Widget build(BuildContext context) {
    final routines = ref.watch(officialRoutinesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Rutinas')),
      body: SafeArea(
        child: routines.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudieron abrir las rutinas locales.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => ref.invalidate(officialRoutinesProvider),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
          data: (all) {
            final visible = filterRoutines(all, goal: _goal, level: _level);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Plantillas oficiales para entrenar en casa, sin equipamiento.',
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<FitnessGoal?>(
                        key: ValueKey('goal-${_goal?.name}'),
                        initialValue: _goal,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Objetivo',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<FitnessGoal?>(
                            value: null,
                            child: Text('Todos los objetivos'),
                          ),
                          ...FitnessGoal.values.map(
                            (goal) => DropdownMenuItem<FitnessGoal?>(
                              value: goal,
                              child: Text(goal.label),
                            ),
                          ),
                        ],
                        onChanged: (value) => setState(() => _goal = value),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<FitnessLevel?>(
                        key: ValueKey('level-${_level?.name}'),
                        initialValue: _level,
                        decoration: const InputDecoration(
                          labelText: 'Nivel',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<FitnessLevel?>(
                            value: null,
                            child: Text('Todos los niveles'),
                          ),
                          ...FitnessLevel.values.map(
                            (level) => DropdownMenuItem<FitnessLevel?>(
                              value: level,
                              child: Text(level.label),
                            ),
                          ),
                        ],
                        onChanged: (value) => setState(() => _level = value),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${visible.length} ${visible.length == 1 ? 'rutina' : 'rutinas'}',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('No hay rutinas con estos filtros.'),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => setState(() {
                                  _goal = null;
                                  _level = null;
                                }),
                                child: const Text('Limpiar filtros'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          itemCount: visible.length,
                          itemBuilder: (context, index) {
                            final routine = visible[index];
                            return Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () =>
                                    context.push('/routines/${routine.id}'),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        routine.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(routine.description),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${routine.goal.label} · ${routine.level.label} · ${routine.estimatedMinutes} min',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
