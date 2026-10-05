import '../domain/user_profile.dart';

extension FitnessGoalLabel on FitnessGoal {
  String get label => switch (this) {
    FitnessGoal.loseWeight => 'Perder peso',
    FitnessGoal.improveCondition => 'Mejorar condición',
    FitnessGoal.gainStrength => 'Ganar fuerza',
    FitnessGoal.buildHabit => 'Crear hábito',
  };
}

extension FitnessLevelLabel on FitnessLevel {
  String get label => switch (this) {
    FitnessLevel.beginner => 'Principiante',
    FitnessLevel.intermediate => 'Intermedio',
    FitnessLevel.advanced => 'Avanzado',
  };
}

extension WeightUnitLabel on WeightUnit {
  String get label => switch (this) {
    WeightUnit.kg => 'kg',
    WeightUnit.lb => 'lb',
  };
}

const weekdayLabels = <int, String>{
  DateTime.monday: 'Lun',
  DateTime.tuesday: 'Mar',
  DateTime.wednesday: 'Mié',
  DateTime.thursday: 'Jue',
  DateTime.friday: 'Vie',
  DateTime.saturday: 'Sáb',
  DateTime.sunday: 'Dom',
};
