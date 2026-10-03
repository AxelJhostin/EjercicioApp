import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../shared/widgets/section_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/routines',
            builder: (context, state) => const SectionScreen(
              title: 'Rutinas',
              message: 'Aquí aparecerán tus rutinas para entrenar en casa.',
              icon: Icons.fitness_center_outlined,
            ),
          ),
          GoRoute(
            path: '/exercises',
            builder: (context, state) => const SectionScreen(
              title: 'Ejercicios',
              message:
                  'Aquí estará la biblioteca de ejercicios sin equipamiento.',
              icon: Icons.directions_run_outlined,
            ),
          ),
          GoRoute(
            path: '/progress',
            builder: (context, state) => const SectionScreen(
              title: 'Progreso',
              message: 'Aquí podrás consultar tu evolución.',
              icon: Icons.trending_up_outlined,
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const SectionScreen(
              title: 'Perfil',
              message: 'Aquí podrás configurar tus preferencias.',
              icon: Icons.person_outline,
            ),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});

  final Widget child;

  static const _paths = [
    '/home',
    '/routines',
    '/exercises',
    '/progress',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final selectedIndex = _paths.indexWhere(
      (destination) => path == destination || path.startsWith('$destination/'),
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onDestinationSelected: (index) => context.go(_paths[index]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Rutinas',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_run_outlined),
            label: 'Ejercicios',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up_outlined),
            label: 'Progreso',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
