import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/drift_exercise_repository.dart';
import '../domain/exercise.dart';

final exerciseCatalogProvider = FutureProvider<List<Exercise>>((ref) {
  return ref.watch(exerciseRepositoryProvider).listAll();
});

final exerciseByIdProvider = FutureProvider.family<Exercise?, String>((
  ref,
  id,
) {
  return ref.watch(exerciseRepositoryProvider).findById(id);
});
