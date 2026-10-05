import 'dart:convert';
import 'dart:io';

// Regenera el asset local desde los documentos aprobados del proyecto.
void main() {
  final catalog = File('EXERCISE_CATALOG.md').readAsLinesSync();
  final instructions = File('EXERCISE_INSTRUCTIONS.md').readAsLinesSync();
  final details = <String, Map<String, String>>{};
  String? instructionId;
  for (final line in instructions) {
    final heading = RegExp(r'^### (EX-\d{3}) — (.+)$').firstMatch(line);
    if (heading != null) {
      instructionId = heading.group(1)!;
      details[instructionId] = {'name': heading.group(2)!};
      continue;
    }
    if (instructionId == null) continue;
    for (final field in const [
      ('Ejecución', 'movement'),
      ('Respiración y control', 'breathing'),
      ('Seguridad', 'safety'),
    ]) {
      final prefix = '- **${field.$1}:** ';
      if (line.startsWith(prefix)) {
        details[instructionId]![field.$2] = line.substring(prefix.length);
      }
    }
  }

  const categories = <String, (String, String, String)>{
    'Calentamiento': ('warmup', 'warmup', 'fullBody'),
    'Piernas y glúteos': ('legsGlutes', 'strength', 'legsGlutes'),
    'Pecho, hombros y brazos': ('upperBody', 'strength', 'upperBody'),
    'Espalda, postura y cadena posterior': ('backPosture', 'strength', 'back'),
    'Core': ('core', 'strength', 'core'),
    'Cardio': ('cardio', 'cardio', 'fullBody'),
    'Movilidad, flexibilidad y enfriamiento': (
      'mobilityCooldown',
      'flexibility',
      'fullBody',
    ),
  };
  final intensities = <String, String>{};
  for (final line in catalog) {
    final match = RegExp(r'^- \*\*(Baja|Moderada|Alta):\*\* (.+)$')
        .firstMatch(line);
    if (match == null) continue;
    final intensity = switch (match.group(1)!) {
      'Baja' => 'low',
      'Moderada' => 'moderate',
      _ => 'high',
    };
    for (final range in RegExp(
      r'EX-(\d{3})(?: a EX-(\d{3}))?',
    ).allMatches(match.group(2)!)) {
      final first = int.parse(range.group(1)!);
      final last = int.parse(range.group(2) ?? range.group(1)!);
      for (var number = first; number <= last; number++) {
        final id = 'EX-${number.toString().padLeft(3, '0')}';
        if (intensities.containsKey(id)) {
          throw StateError('Intensidad duplicada: $id');
        }
        intensities[id] = intensity;
      }
    }
  }

  String? section;
  final exercises = <Map<String, Object?>>[];
  for (final line in catalog) {
    final heading = RegExp(r'^## (.+?) — \d+ ejercicios$').firstMatch(line);
    if (heading != null) {
      section = heading.group(1)!;
      if (!categories.containsKey(section)) {
        throw StateError('Categoría desconocida: $section');
      }
      continue;
    }
    if (!line.startsWith('| EX-')) continue;
    final columns = line
        .split('|')
        .sublist(1, 9)
        .map((part) => part.trim())
        .toList();
    if (columns.length != 8 || section == null) {
      throw StateError('Fila inválida: $line');
    }
    final id = columns[0];
    final detail = details[id];
    if (detail == null || detail['name'] != columns[1]) {
      throw StateError('Instrucciones ausentes o nombre diferente: $id');
    }
    for (final field in ['movement', 'breathing', 'safety']) {
      if (detail[field] == null || detail[field]!.isEmpty) {
        throw StateError('Falta $field en $id');
      }
    }
    final (category, defaultType, muscleGroup) = categories[section]!;
    final number = int.parse(id.substring(3));
    final type = switch (number) {
      58 || 59 => 'mobility',
      60 => 'cooldown',
      _ => defaultType,
    };
    exercises.add({
      'id': id,
      'name': columns[1],
      'category': category,
      'type': type,
      'muscleGroup': muscleGroup,
      'difficulty': switch (columns[2]) {
        'Principiante' => 'beginner',
        'Intermedio' => 'intermediate',
        'Avanzado' => 'advanced',
        _ => throw StateError('Nivel inválido en $id'),
      },
      'prescription': columns[3],
      'easyVariant': columns[4],
      'hardVariant': columns[5],
      'impact': switch (columns[6]) {
        'Bajo' => 'low',
        'Moderado' => 'moderate',
        'Alto' => 'high',
        _ => throw StateError('Impacto inválido en $id'),
      },
      'intensity':
          intensities[id] ?? (throw StateError('Intensidad ausente: $id')),
      'imageFilename': columns[7].replaceAll('`', ''),
      'movement': detail['movement'],
      'breathing': detail['breathing'],
      'safety': detail['safety'],
    });
  }
  if (exercises.length != 60 ||
      details.length != 60 ||
      intensities.length != 60) {
    throw StateError(
      'Se esperaban 60 ejercicios completos: catálogo=${exercises.length}, instrucciones=${details.length}, intensidades=${intensities.length}',
    );
  }
  for (var index = 0; index < exercises.length; index++) {
    final expected = 'EX-${(index + 1).toString().padLeft(3, '0')}';
    if (exercises[index]['id'] != expected) {
      throw StateError('Orden o ID inválido: $expected');
    }
  }
  final output = File('assets/data/exercises_v1.json');
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'version': 1, 'exercises': exercises})}\n',
  );
  stdout.writeln('Generados ${exercises.length} ejercicios en ${output.path}');
}
