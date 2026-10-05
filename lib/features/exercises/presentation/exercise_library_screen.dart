import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../application/exercise_catalog_provider.dart';
import '../domain/exercise.dart';
import 'exercise_labels.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  ExerciseCategory? _category;
  ExerciseDifficulty? _difficulty;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _category = null;
      _difficulty = null;
    });
  }

  Future<void> _openFilters() async {
    var selectedCategory = _category;
    var selectedDifficulty = _difficulty;
    final selection =
        await showModalBottomSheet<(ExerciseCategory?, ExerciseDifficulty?)>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (sheetContext) => StatefulBuilder(
            builder: (context, updateSheet) => SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  24 + MediaQuery.viewInsetsOf(context).bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Filtrar ejercicios',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<ExerciseCategory?>(
                      initialValue: selectedCategory,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<ExerciseCategory?>(
                          value: null,
                          child: Text('Todas las categorías'),
                        ),
                        ...ExerciseCategory.values.map(
                          (category) => DropdownMenuItem<ExerciseCategory?>(
                            value: category,
                            child: Text(
                              category.label,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          updateSheet(() => selectedCategory = value),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ExerciseDifficulty?>(
                      initialValue: selectedDifficulty,
                      decoration: const InputDecoration(
                        labelText: 'Dificultad',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<ExerciseDifficulty?>(
                          value: null,
                          child: Text('Todos los niveles'),
                        ),
                        ...ExerciseDifficulty.values.map(
                          (difficulty) => DropdownMenuItem<ExerciseDifficulty?>(
                            value: difficulty,
                            child: Text(difficulty.label),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          updateSheet(() => selectedDifficulty = value),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => Navigator.pop(sheetContext, (
                        selectedCategory,
                        selectedDifficulty,
                      )),
                      child: const Text('Aplicar filtros'),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(sheetContext, (null, null)),
                      child: const Text('Restablecer filtros'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
    if (selection == null || !mounted) return;
    setState(() {
      _category = selection.$1;
      _difficulty = selection.$2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(exerciseCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios')),
      body: SafeArea(
        child: catalog.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo abrir la biblioteca local.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => ref.invalidate(exerciseCatalogProvider),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
          data: (exercises) {
            final visible = filterExercises(
              exercises,
              query: _query,
              category: _category,
              difficulty: _difficulty,
            );
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar ejercicio',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() => _query = value),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: _openFilters,
                            icon: const Icon(Icons.tune),
                            label: Text(
                              _category == null && _difficulty == null
                                  ? 'Filtros'
                                  : 'Filtros activos',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${visible.length} ${visible.length == 1 ? 'ejercicio' : 'ejercicios'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'No hay ejercicios con estos filtros.',
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: _clearFilters,
                                child: const Text('Limpiar filtros'),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: visible.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final exercise = visible[index];
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.directions_run_outlined),
                              ),
                              title: Text(exercise.name),
                              subtitle: Text(
                                '${exercise.category.label} · ${exercise.difficulty.label} · ${exercise.prescription}',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () =>
                                  context.push('/exercises/${exercise.id}'),
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
