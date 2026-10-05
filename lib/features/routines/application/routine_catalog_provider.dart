import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/drift_routine_repository.dart';
import '../domain/routine.dart';

final officialRoutinesProvider = FutureProvider<List<Routine>>((ref) {
  return ref.watch(routineRepositoryProvider).listOfficial();
});

final officialRoutineByIdProvider = FutureProvider.family<Routine?, String>((
  ref,
  id,
) {
  return ref.watch(routineRepositoryProvider).findOfficialById(id);
});
