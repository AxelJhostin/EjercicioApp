import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/units/weight_converter.dart';
import '../application/profile_notifier.dart';
import '../domain/user_profile.dart';
import 'profile_labels.dart';

class ProfileFormScreen extends ConsumerWidget {
  const ProfileFormScreen({super.key, required this.isOnboarding});

  final bool isOnboarding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(isOnboarding ? 'Configurar perfil' : 'Editar perfil'),
      ),
      body: SafeArea(
        child: profileState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo cargar el perfil local.'),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => ref.invalidate(profileNotifierProvider),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
          data: (profile) =>
              _ProfileForm(initialProfile: profile, isOnboarding: isOnboarding),
        ),
      ),
    );
  }
}

class _ProfileForm extends ConsumerStatefulWidget {
  const _ProfileForm({
    required this.initialProfile,
    required this.isOnboarding,
  });

  final UserProfile? initialProfile;
  final bool isOnboarding;

  @override
  ConsumerState<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  FitnessGoal? _goal;
  FitnessLevel? _level;
  late Set<int> _availableDays;
  late int _preferredDurationMinutes;
  late WeightUnit _weightUnit;
  bool _daysError = false;
  bool _saving = false;
  bool _weightEdited = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.initialProfile;
    _goal = profile?.goal;
    _level = profile?.level;
    _availableDays = {...?profile?.availableDays};
    _preferredDurationMinutes = profile?.preferredDurationMinutes ?? 30;
    _weightUnit = profile?.weightUnit ?? WeightUnit.kg;
    _nameController = TextEditingController(text: profile?.displayName ?? '');
    _ageController = TextEditingController(
      text: profile?.age?.toString() ?? '',
    );
    _heightController = TextEditingController(
      text: _formatNumber(profile?.heightCm),
    );
    _weightController = TextEditingController(
      text: _formatNumber(
        profile?.initialWeightKg == null
            ? null
            : WeightConverter.fromKilograms(
                profile!.initialWeightKg!,
                _weightUnit,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  static String _formatNumber(double? value) =>
      value == null ? '' : value.toStringAsFixed(1);

  static double? _parseNumber(String text) {
    final normalized = text.trim().replaceAll(',', '.');
    return normalized.isEmpty ? null : double.tryParse(normalized);
  }

  String? _validatePositiveNumber(String? text) {
    if (text == null || text.trim().isEmpty) return null;
    final value = _parseNumber(text);
    if (value == null || !value.isFinite || value <= 0) {
      return 'Introduce un número mayor que cero.';
    }
    return null;
  }

  void _changeWeightUnit(WeightUnit next) {
    if (next == _weightUnit) return;
    final entered = _parseNumber(_weightController.text);
    if (entered != null && entered.isFinite && entered > 0) {
      final kilograms =
          !_weightEdited && widget.initialProfile?.initialWeightKg != null
          ? widget.initialProfile!.initialWeightKg!
          : WeightConverter.toKilograms(entered, _weightUnit);
      _weightController.text = _formatNumber(
        WeightConverter.fromKilograms(kilograms, next),
      );
    }
    setState(() => _weightUnit = next);
  }

  Future<void> _save() async {
    if (_saving) return;
    final validFields = _formKey.currentState!.validate();
    setState(() => _daysError = _availableDays.isEmpty);
    if (!validFields || _daysError) return;

    final enteredWeight = _parseNumber(_weightController.text);
    final initialWeightKg =
        !_weightEdited && widget.initialProfile?.initialWeightKg != null
        ? widget.initialProfile!.initialWeightKg
        : enteredWeight == null
        ? null
        : WeightConverter.toKilograms(enteredWeight, _weightUnit);
    final profile = UserProfile(
      goal: _goal!,
      level: _level!,
      availableDays: _availableDays,
      preferredDurationMinutes: _preferredDurationMinutes,
      weightUnit: _weightUnit,
      displayName: _nameController.text.trim().isEmpty
          ? null
          : _nameController.text.trim(),
      age: _ageController.text.trim().isEmpty
          ? null
          : int.parse(_ageController.text.trim()),
      heightCm: _parseNumber(_heightController.text),
      initialWeightKg: initialWeightKg,
    );

    setState(() => _saving = true);
    try {
      await ref.read(profileNotifierProvider.notifier).save(profile);
      if (!mounted) return;
      context.go(widget.isOnboarding ? '/home' : '/profile');
    } catch (error) {
      if (!mounted) return;
      final message = error is FormatException
          ? error.message
          : 'No se pudo guardar el perfil. Inténtalo de nuevo.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tu punto de partida',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Estos datos preparan tu futuro plan de entrenamiento. Todo queda en este dispositivo.',
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<FitnessGoal>(
              key: const ValueKey('goal-field'),
              initialValue: _goal,
              decoration: const InputDecoration(
                labelText: 'Objetivo *',
                border: OutlineInputBorder(),
              ),
              items: FitnessGoal.values
                  .map(
                    (goal) =>
                        DropdownMenuItem(value: goal, child: Text(goal.label)),
                  )
                  .toList(),
              validator: (value) =>
                  value == null ? 'Selecciona un objetivo.' : null,
              onChanged: (value) => setState(() => _goal = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<FitnessLevel>(
              key: const ValueKey('level-field'),
              initialValue: _level,
              decoration: const InputDecoration(
                labelText: 'Nivel *',
                border: OutlineInputBorder(),
              ),
              items: FitnessLevel.values
                  .map(
                    (level) => DropdownMenuItem(
                      value: level,
                      child: Text(level.label),
                    ),
                  )
                  .toList(),
              validator: (value) =>
                  value == null ? 'Selecciona un nivel.' : null,
              onChanged: (value) => setState(() => _level = value),
            ),
            const SizedBox(height: 24),
            Text(
              'Días disponibles *',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: weekdayLabels.entries
                  .map(
                    (entry) => FilterChip(
                      key: ValueKey('day-${entry.key}'),
                      label: Text(entry.value),
                      selected: _availableDays.contains(entry.key),
                      onSelected: (selected) => setState(() {
                        if (selected) {
                          _availableDays.add(entry.key);
                        } else {
                          _availableDays.remove(entry.key);
                        }
                        _daysError = false;
                      }),
                    ),
                  )
                  .toList(),
            ),
            if (_daysError)
              Text(
                'Selecciona al menos un día.',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            const SizedBox(height: 24),
            Text(
              'Duración preferida: $_preferredDurationMinutes min',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _preferredDurationMinutes.toDouble(),
              min: 15,
              max: 45,
              divisions: 6,
              label: '$_preferredDurationMinutes min',
              onChanged: (value) =>
                  setState(() => _preferredDurationMinutes = value.round()),
            ),
            const SizedBox(height: 16),
            Text(
              'Unidad de peso: ${_weightUnit.label}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<WeightUnit>(
              segments: const [
                ButtonSegment(value: WeightUnit.kg, label: Text('kg')),
                ButtonSegment(value: WeightUnit.lb, label: Text('lb')),
              ],
              selected: {_weightUnit},
              onSelectionChanged: (units) => _changeWeightUnit(units.first),
            ),
            const SizedBox(height: 8),
            const Text('Las medidas de longitud se guardarán en centímetros.'),
            const SizedBox(height: 32),
            Text(
              'Datos opcionales',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Puedes completarlos después para mejorar el seguimiento.',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (text) => text != null && text.trim().length > 80
                  ? 'Escribe un nombre de hasta 80 caracteres.'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (text) {
                if (text == null || text.trim().isEmpty) return null;
                final age = int.tryParse(text.trim());
                return age == null || age <= 0
                    ? 'Introduce una edad positiva.'
                    : null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _validatePositiveNumber,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              key: const ValueKey('weight-field'),
              decoration: InputDecoration(
                labelText: 'Peso inicial (${_weightUnit.label})',
                border: const OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: _validatePositiveNumber,
              onChanged: (value) => _weightEdited = true,
            ),
            const SizedBox(height: 32),
            FilledButton(
              key: const ValueKey('save-profile'),
              onPressed: _saving ? null : _save,
              child: Text(_saving ? 'Guardando…' : 'Guardar perfil'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
