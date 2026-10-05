import '../../exercises/domain/exercise.dart';
import '../../profile/domain/user_profile.dart';

enum RoutineKind { official, custom, copy }

enum PrescriptionType { repetitions, seconds }

class RoutineStep {
  const RoutineStep({
    required this.position,
    required this.exercise,
    required this.sets,
    required this.prescriptionType,
    required this.targetReps,
    required this.targetSeconds,
    required this.restSeconds,
    required this.notes,
  });

  final int position;
  final Exercise exercise;
  final int sets;
  final PrescriptionType prescriptionType;
  final int? targetReps;
  final int? targetSeconds;
  final int restSeconds;
  final String? notes;

  String get targetLabel {
    final target = prescriptionType == PrescriptionType.seconds
        ? '$targetSeconds s'
        : '$targetReps repeticiones';
    return notes == null ? target : '$target $notes';
  }
}

class Routine {
  Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.goal,
    required this.level,
    required this.estimatedMinutes,
    required this.kind,
    required this.originRoutineId,
    required this.editable,
    required this.archived,
    required this.safetyNote,
    required this.contentVersion,
    required List<RoutineStep> steps,
  }) : steps = List.unmodifiable(steps);

  final String id;
  final String name;
  final String description;
  final FitnessGoal goal;
  final FitnessLevel level;
  final int estimatedMinutes;
  final RoutineKind kind;
  final String? originRoutineId;
  final bool editable;
  final bool archived;
  final String safetyNote;
  final int contentVersion;
  final List<RoutineStep> steps;
}

List<Routine> filterRoutines(
  List<Routine> routines, {
  FitnessGoal? goal,
  FitnessLevel? level,
}) => routines
    .where(
      (routine) =>
          (goal == null || routine.goal == goal) &&
          (level == null || routine.level == level),
    )
    .toList(growable: false);
