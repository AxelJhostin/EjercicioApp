import '../domain/exercise.dart';

extension ExerciseCategoryLabel on ExerciseCategory {
  String get label => switch (this) {
    ExerciseCategory.warmup => 'Calentamiento',
    ExerciseCategory.legsGlutes => 'Piernas y glúteos',
    ExerciseCategory.upperBody => 'Pecho, hombros y brazos',
    ExerciseCategory.backPosture => 'Espalda y postura',
    ExerciseCategory.core => 'Core',
    ExerciseCategory.cardio => 'Cardio',
    ExerciseCategory.mobilityCooldown => 'Movilidad y enfriamiento',
  };
}

extension ExerciseDifficultyLabel on ExerciseDifficulty {
  String get label => switch (this) {
    ExerciseDifficulty.beginner => 'Principiante',
    ExerciseDifficulty.intermediate => 'Intermedio',
    ExerciseDifficulty.advanced => 'Avanzado',
  };
}

extension ExerciseTypeLabel on ExerciseType {
  String get label => switch (this) {
    ExerciseType.warmup => 'Calentamiento',
    ExerciseType.strength => 'Fuerza',
    ExerciseType.cardio => 'Cardio',
    ExerciseType.flexibility => 'Flexibilidad',
    ExerciseType.mobility => 'Movilidad',
    ExerciseType.cooldown => 'Enfriamiento',
  };
}

extension ExerciseImpactLabel on ExerciseImpact {
  String get label => switch (this) {
    ExerciseImpact.low => 'Bajo',
    ExerciseImpact.moderate => 'Moderado',
    ExerciseImpact.high => 'Alto',
  };
}

extension ExerciseIntensityLabel on ExerciseIntensity {
  String get label => switch (this) {
    ExerciseIntensity.low => 'Baja',
    ExerciseIntensity.moderate => 'Moderada',
    ExerciseIntensity.high => 'Alta',
  };
}

String muscleGroupLabel(String group) => switch (group) {
  'fullBody' => 'Cuerpo completo',
  'legsGlutes' => 'Piernas y glúteos',
  'upperBody' => 'Tren superior',
  'back' => 'Espalda',
  'core' => 'Core',
  _ => group,
};
