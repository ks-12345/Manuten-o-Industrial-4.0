import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/industrial_map/presentation/industrial_map_screen.dart';
import '../features/machines/presentation/machine_list_screen.dart';
import '../features/occurrences/presentation/occurrences_screen.dart';
import '../features/offline_sync/presentation/sync_status_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashScreen.route,
    routes: [
      GoRoute(
        path: SplashScreen.route,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: DashboardScreen.route,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: MachineListScreen.route,
        builder: (context, state) => const MachineListScreen(),
      ),
      GoRoute(
        path: OccurrencesScreen.route,
        builder: (context, state) => const OccurrencesScreen(),
      ),
      GoRoute(
        path: IndustrialMapScreen.route,
        builder: (context, state) => const IndustrialMapScreen(),
      ),
      GoRoute(
        path: SyncStatusScreen.route,
        builder: (context, state) => const SyncStatusScreen(),
      ),
    ],
  );
});
