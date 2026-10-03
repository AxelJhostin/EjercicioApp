import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            FilledButton.icon(
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
