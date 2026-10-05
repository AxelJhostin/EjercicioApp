import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/units/weight_converter.dart';
import '../application/profile_notifier.dart';
import '../domain/user_profile.dart';
import 'profile_labels.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
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
          data: (profile) => profile == null
              ? _EmptyProfile(onCreate: () => context.push('/onboarding'))
              : _ProfileDetails(
                  profile: profile,
                  onEdit: () => context.push('/profile/edit'),
                ),
        ),
      ),
    );
  }
}

class _EmptyProfile extends StatelessWidget {
  const _EmptyProfile({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 64),
          const SizedBox(height: 16),
          Text(
            'Prepara tu perfil',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Elige tu objetivo, nivel y días disponibles. Puedes completar los datos opcionales después.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: onCreate,
            child: const Text('Configurar perfil'),
          ),
        ],
      ),
    ),
  );
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({required this.profile, required this.onEdit});

  final UserProfile profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final days = profile.availableDays.toList()..sort();
    final incomplete =
        profile.displayName == null ||
        profile.age == null ||
        profile.heightCm == null ||
        profile.initialWeightKg == null;
    final weight = profile.initialWeightKg;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          profile.displayName?.isNotEmpty == true
              ? profile.displayName!
              : 'Tu perfil',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        if (incomplete) ...[
          const SizedBox(height: 6),
          Text(
            'Perfil incompleto · los datos opcionales pueden añadirse después',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 24),
        _Detail(label: 'Objetivo', value: profile.goal.label),
        _Detail(label: 'Nivel', value: profile.level.label),
        _Detail(
          label: 'Días disponibles',
          value: days.map((day) => weekdayLabels[day]).join(', '),
        ),
        _Detail(
          label: 'Duración preferida',
          value: '${profile.preferredDurationMinutes} min',
        ),
        _Detail(label: 'Unidad de peso', value: profile.weightUnit.label),
        const _Detail(label: 'Unidad de medidas', value: 'cm'),
        if (profile.age != null)
          _Detail(label: 'Edad', value: '${profile.age} años'),
        if (profile.heightCm != null)
          _Detail(
            label: 'Altura',
            value: '${profile.heightCm!.toStringAsFixed(1)} cm',
          ),
        if (weight != null)
          _Detail(
            label: 'Peso inicial',
            value:
                '${WeightConverter.fromKilograms(weight, profile.weightUnit).toStringAsFixed(1)} ${profile.weightUnit.label}',
          ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Editar perfil'),
        ),
      ],
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(child: Text(value, textAlign: TextAlign.end)),
      ],
    ),
  );
}
