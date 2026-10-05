import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../profile/application/profile_notifier.dart';
import '../../profile/presentation/profile_labels.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('CasaFit')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Entrena a tu ritmo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const Text('Tu espacio para entrenar en casa, sin equipamiento.'),
            const SizedBox(height: 32),
            profileState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => OutlinedButton(
                onPressed: () => ref.invalidate(profileNotifierProvider),
                child: const Text('Reintentar carga del perfil'),
              ),
              data: (profile) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (profile != null) ...[
                    Text('Objetivo actual: ${profile.goal.label}'),
                    const SizedBox(height: 12),
                  ],
                  FilledButton.icon(
                    onPressed: () => profile == null
                        ? context.push('/onboarding')
                        : context.go('/profile'),
                    icon: Icon(
                      profile == null
                          ? Icons.person_add_alt_1_outlined
                          : Icons.person_outline,
                    ),
                    label: Text(
                      profile == null ? 'Configurar perfil' : 'Ver mi perfil',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.go('/routines'),
              icon: const Icon(Icons.fitness_center_outlined),
              label: const Text('Explorar rutinas'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.go('/exercises'),
              icon: const Icon(Icons.directions_run_outlined),
              label: const Text('Ver ejercicios'),
            ),
          ],
        ),
      ),
    );
  }
}
