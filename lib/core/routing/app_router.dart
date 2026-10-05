import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/exercises/presentation/exercise_detail_screen.dart';
import '../../features/exercises/presentation/exercise_library_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_form_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/routines/presentation/routine_detail_screen.dart';
import '../../features/routines/presentation/routine_library_screen.dart';
import '../../shared/widgets/section_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) =>
            const ProfileFormScreen(isOnboarding: true),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) =>
            const ProfileFormScreen(isOnboarding: false),
      ),
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/routines',
            builder: (context, state) => const RoutineLibraryScreen(),
            routes: [
              GoRoute(
                path: ':routineId',
                builder: (context, state) => RoutineDetailScreen(
                  routineId: state.pathParameters['routineId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/exercises',
            builder: (context, state) => const ExerciseLibraryScreen(),
            routes: [
              GoRoute(
                path: ':exerciseId',
                builder: (context, state) => ExerciseDetailScreen(
                  exerciseId: state.pathParameters['exerciseId']!,
                ),
              ),
            ],
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
            builder: (context, state) => const ProfileScreen(),
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
