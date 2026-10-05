import 'dart:convert';
import 'dart:io';

// Las plantillas oficiales usan solo ejercicios del catálogo local aprobado.
const _specs = <_RoutineSpec>[
  _RoutineSpec(
    'OFF-LOSE-BEGINNER',
    'Movimiento para empezar',
    'Alterna cardio suave y fuerza básica a un ritmo cómodo.',
    'loseWeight',
    'beginner',
    20,
    [
      'EX-001',
      'EX-002',
      'EX-046',
      'EX-007',
      'EX-048',
      'EX-013',
      'EX-035',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-LOSE-INTERMEDIATE',
    'Cardio y fuerza constante',
    'Combina intervalos moderados con piernas, core y tren superior.',
    'loseWeight',
    'intermediate',
    30,
    [
      'EX-001',
      'EX-004',
      'EX-047',
      'EX-016',
      'EX-041',
      'EX-045',
      'EX-014',
      'EX-050',
      'EX-054',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-LOSE-ADVANCED',
    'Circuito de alta energía',
    'Intervalos exigentes con opciones de menor impacto en cada ejercicio.',
    'loseWeight',
    'advanced',
    40,
    [
      'EX-001',
      'EX-005',
      'EX-052',
      'EX-018',
      'EX-042',
      'EX-051',
      'EX-022',
      'EX-040',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-CONDITION-BEGINNER',
    'Base de condición física',
    'Trabaja coordinación y resistencia suave sin movimientos complejos.',
    'improveCondition',
    'beginner',
    20,
    [
      'EX-001',
      'EX-003',
      'EX-046',
      'EX-013',
      'EX-007',
      'EX-029',
      'EX-035',
      'EX-055',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-CONDITION-INTERMEDIATE',
    'Resistencia de cuerpo completo',
    'Alterna ejercicios de piernas, brazos, core y cardio moderado.',
    'improveCondition',
    'intermediate',
    30,
    [
      'EX-001',
      'EX-004',
      'EX-047',
      'EX-011',
      'EX-022',
      'EX-041',
      'EX-014',
      'EX-054',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-CONDITION-ADVANCED',
    'Resistencia dinámica',
    'Sesión variada con fuerza, estabilidad y cambios de ritmo.',
    'improveCondition',
    'advanced',
    40,
    [
      'EX-001',
      'EX-005',
      'EX-052',
      'EX-017',
      'EX-024',
      'EX-042',
      'EX-049',
      'EX-036',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-STRENGTH-BEGINNER',
    'Fuerza esencial',
    'Construye una base de fuerza con movimientos controlados.',
    'gainStrength',
    'beginner',
    20,
    [
      'EX-001',
      'EX-004',
      'EX-007',
      'EX-013',
      'EX-020',
      'EX-029',
      'EX-035',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-STRENGTH-INTERMEDIATE',
    'Fuerza equilibrada',
    'Entrena piernas, empuje, espalda y estabilidad del tronco.',
    'gainStrength',
    'intermediate',
    30,
    [
      'EX-001',
      'EX-005',
      'EX-011',
      'EX-022',
      'EX-030',
      'EX-036',
      'EX-014',
      'EX-054',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-STRENGTH-ADVANCED',
    'Fuerza y control avanzado',
    'Trabaja patrones exigentes manteniendo la técnica y el control.',
    'gainStrength',
    'advanced',
    40,
    [
      'EX-001',
      'EX-004',
      'EX-016',
      'EX-023',
      'EX-025',
      'EX-040',
      'EX-034',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-HABIT-BEGINNER',
    'Hábito de 15 minutos',
    'Una sesión corta y accesible para empezar con constancia.',
    'buildHabit',
    'beginner',
    15,
    [
      'EX-001',
      'EX-002',
      'EX-046',
      'EX-007',
      'EX-019',
      'EX-037',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-HABIT-INTERMEDIATE',
    'Hábito de cuerpo completo',
    'Una rutina compacta que combina fuerza ligera y movimiento.',
    'buildHabit',
    'intermediate',
    25,
    [
      'EX-001',
      'EX-003',
      'EX-010',
      'EX-022',
      'EX-029',
      'EX-035',
      'EX-046',
      'EX-053',
      'EX-060',
    ],
  ),
  _RoutineSpec(
    'OFF-HABIT-ADVANCED',
    'Constancia con desafío',
    'Mantén el hábito con fuerza, estabilidad y cardio moderado.',
    'buildHabit',
    'advanced',
    35,
    [
      'EX-001',
      'EX-004',
      'EX-017',
      'EX-024',
      'EX-031',
      'EX-041',
      'EX-036',
      'EX-053',
      'EX-060',
    ],
  ),
];

class _RoutineSpec {
  const _RoutineSpec(
    this.id,
    this.name,
    this.description,
    this.goal,
    this.level,
    this.estimatedMinutes,
    this.exerciseIds,
  );

  final String id;
  final String name;
  final String description;
  final String goal;
  final String level;
  final int estimatedMinutes;
  final List<String> exerciseIds;
}

void main() {
  final source = jsonDecode(
    File('assets/data/exercises_v1.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final exercises = {
    for (final value in source['exercises'] as List<dynamic>)
      (value as Map<String, dynamic>)['id'] as String: value,
  };
  final routineIds = <String>{};
  final goalLevels = <String>{};
  final output = <Map<String, Object?>>[];

  for (final spec in _specs) {
    if (!routineIds.add(spec.id) ||
        !goalLevels.add('${spec.goal}:${spec.level}')) {
      throw StateError(
        'Rutina o combinación objetivo/nivel duplicada: ${spec.id}',
      );
    }
    if (spec.estimatedMinutes < 15 ||
        spec.estimatedMinutes > 45 ||
        spec.exerciseIds.toSet().length != spec.exerciseIds.length) {
      throw StateError('Duración o lista de ejercicios inválida: ${spec.id}');
    }
    final steps = <Map<String, Object?>>[];
    for (var index = 0; index < spec.exerciseIds.length; index++) {
      final id = spec.exerciseIds[index];
      final exercise = exercises[id];
      if (exercise == null) throw StateError('Ejercicio desconocido: $id');
      final category = exercise['category'] as String;
      final preparation = index < 2;
      final cooldown = index >= spec.exerciseIds.length - 2;
      if ((preparation && category != 'warmup') ||
          (cooldown && category != 'mobilityCooldown') ||
          (!preparation &&
              !cooldown &&
              (category == 'warmup' || category == 'mobilityCooldown'))) {
        throw StateError('Orden de fases inválido en ${spec.id}: $id');
      }
      if (!preparation &&
          !cooldown &&
          _levelRank(exercise['difficulty'] as String) >
              _levelRank(spec.level)) {
        throw StateError('Ejercicio demasiado difícil en ${spec.id}: $id');
      }
      final prescription = exercise['prescription'] as String;
      final seconds = RegExp(r'^(\d+) s(?: (por lado))?$')
          .firstMatch(prescription);
      final reps = RegExp(r'^(\d+) (?:repeticiones|(por lado)|(por pierna))$')
          .firstMatch(prescription);
      if (seconds == null && reps == null) {
        throw StateError('Prescripción desconocida para $id: $prescription');
      }
      final isWarmupOrCooldown = preparation || cooldown;
      steps.add({
        'position': index + 1,
        'exerciseId': id,
        'sets': isWarmupOrCooldown
            ? 1
            : switch (spec.level) {
                'beginner' => 2,
                'intermediate' => 3,
                _ => 3,
              },
        'prescriptionType': seconds == null ? 'repetitions' : 'seconds',
        'targetReps': reps == null ? null : int.parse(reps.group(1)!),
        'targetSeconds': seconds == null ? null : int.parse(seconds.group(1)!),
        'restSeconds': isWarmupOrCooldown
            ? 0
            : switch (spec.level) {
                'beginner' => 45,
                'intermediate' => 40,
                _ => 45,
              },
        'notes': seconds?.group(2) ?? reps?.group(2) ?? reps?.group(3),
      });
    }
    output.add({
      'id': spec.id,
      'name': spec.name,
      'description': spec.description,
      'goal': spec.goal,
      'level': spec.level,
      'estimatedMinutes': spec.estimatedMinutes,
      'kind': 'official',
      'originRoutineId': null,
      'editable': false,
      'archived': false,
      'safetyNote':
          spec.exerciseIds.any(
            (id) => (exercises[id] as Map<String, dynamic>)['impact'] == 'high',
          )
          ? 'Incluye movimientos de alto impacto. Si no los toleras, usa la variante fácil indicada en el detalle de cada ejercicio.'
          : 'Ajusta el ritmo a tu capacidad y detén el ejercicio si aparece dolor o malestar importante.',
      'exercises': steps,
    });
  }
  if (output.length != 12 || goalLevels.length != 12) {
    throw StateError(
      'Se requieren 12 rutinas: cuatro objetivos por tres niveles.',
    );
  }
  final target = File('assets/data/routines_v1.json');
  target.parent.createSync(recursive: true);
  target.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'version': 1, 'routines': output})}\n',
  );
  stdout.writeln(
    'Generadas ${output.length} rutinas oficiales en ${target.path}',
  );
}

int _levelRank(String level) => switch (level) {
  'beginner' => 0,
  'intermediate' => 1,
  'advanced' => 2,
  _ => throw StateError('Nivel desconocido: $level'),
};
