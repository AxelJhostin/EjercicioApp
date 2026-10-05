import 'exercise.dart';

abstract interface class ExerciseRepository {
  Future<List<Exercise>> listAll();

  Future<Exercise?> findById(String id);
}
