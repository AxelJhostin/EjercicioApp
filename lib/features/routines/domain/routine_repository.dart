import 'routine.dart';

abstract interface class RoutineRepository {
  Future<List<Routine>> listOfficial();

  Future<Routine?> findOfficialById(String id);
}
