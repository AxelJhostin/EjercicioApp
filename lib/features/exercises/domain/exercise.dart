enum ExerciseCategory {
  warmup,
  legsGlutes,
  upperBody,
  backPosture,
  core,
  cardio,
  mobilityCooldown,
}

enum ExerciseType { warmup, strength, cardio, flexibility, mobility, cooldown }

enum ExerciseDifficulty { beginner, intermediate, advanced }

enum ExerciseImpact { low, moderate, high }

enum ExerciseIntensity { low, moderate, high }

class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.muscleGroup,
    required this.difficulty,
    required this.prescription,
    required this.easyVariant,
    required this.hardVariant,
    required this.impact,
    required this.intensity,
    required this.imageFilename,
    required this.movement,
    required this.breathing,
    required this.safety,
  });

  final String id;
  final String name;
  final ExerciseCategory category;
  final ExerciseType type;
  final String muscleGroup;
  final ExerciseDifficulty difficulty;
  final String prescription;
  final String easyVariant;
  final String hardVariant;
  final ExerciseImpact impact;
  final ExerciseIntensity intensity;
  final String imageFilename;
  final String movement;
  final String breathing;
  final String safety;
}

List<Exercise> filterExercises(
  List<Exercise> exercises, {
  String query = '',
  ExerciseCategory? category,
  ExerciseDifficulty? difficulty,
}) {
  final normalizedQuery = _normalize(query.trim());
  return exercises
      .where((exercise) {
        if (category != null && exercise.category != category) {
          return false;
        }
        if (difficulty != null && exercise.difficulty != difficulty) {
          return false;
        }
        return normalizedQuery.isEmpty ||
            _normalize(exercise.name).contains(normalizedQuery);
      })
      .toList(growable: false);
}

String _normalize(String value) => value
    .toLowerCase()
    .replaceAll(RegExp('[áàäâ]'), 'a')
    .replaceAll(RegExp('[éèëê]'), 'e')
    .replaceAll(RegExp('[íìïî]'), 'i')
    .replaceAll(RegExp('[óòöô]'), 'o')
    .replaceAll(RegExp('[úùüû]'), 'u')
    .replaceAll('ñ', 'n');
