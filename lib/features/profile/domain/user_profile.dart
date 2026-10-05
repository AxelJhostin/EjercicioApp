enum FitnessGoal { loseWeight, improveCondition, gainStrength, buildHabit }

enum FitnessLevel { beginner, intermediate, advanced }

enum WeightUnit { kg, lb }

class UserProfile {
  UserProfile({
    required this.goal,
    required this.level,
    required Set<int> availableDays,
    required this.preferredDurationMinutes,
    required this.weightUnit,
    this.displayName,
    this.age,
    this.heightCm,
    this.initialWeightKg,
  }) : availableDays = Set.unmodifiable(availableDays);

  final FitnessGoal goal;
  final FitnessLevel level;
  final Set<int> availableDays;
  final int preferredDurationMinutes;
  final WeightUnit weightUnit;
  final String? displayName;
  final int? age;
  final double? heightCm;
  final double? initialWeightKg;

  void validate() {
    if (availableDays.isEmpty ||
        availableDays.any(
          (day) => day < DateTime.monday || day > DateTime.sunday,
        )) {
      throw const FormatException('Selecciona al menos un día válido.');
    }
    if (preferredDurationMinutes < 15 || preferredDurationMinutes > 45) {
      throw const FormatException(
        'La duración debe estar entre 15 y 45 minutos.',
      );
    }
    if (displayName != null && displayName!.trim().length > 80) {
      throw const FormatException('El nombre debe tener hasta 80 caracteres.');
    }
    if (age != null && age! <= 0) {
      throw const FormatException('La edad debe ser un número positivo.');
    }
    if (heightCm != null && (!heightCm!.isFinite || heightCm! <= 0)) {
      throw const FormatException('La altura debe ser un número positivo.');
    }
    if (initialWeightKg != null &&
        (!initialWeightKg!.isFinite || initialWeightKg! <= 0)) {
      throw const FormatException('El peso debe ser un número positivo.');
    }
  }
}
