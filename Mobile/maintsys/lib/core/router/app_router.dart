import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/industrial_map/presentation/industrial_map_screen.dart';
import '../../features/machines/presentation/machine_list_screen.dart';
import '../../features/occurrences/presentation/occurrences_screen.dart';
import '../../features/offline_sync/presentation/sync_status_screen.dart';
import 'module_screen.dart';

import '../../features/occurrences/presentation/screens/occurrence_new_screen.dart';
import '../../features/occurrences/presentation/screens/occurrence_detail_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/splash';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const machines = '/machines';
  static const machineDetail = '/machines/:id';
  static const occurrences = '/occurrences';
  static const newOccurrence = '/occurrences/new';
  static const occurrenceDetail = '/occurrences/:id';
  static const inspection = '/occurrences/:id/inspection';
  static const corrective = '/occurrences/:id/corrective';
  static const preventives = '/preventives';
  static const checklist = '/checklist/:checklistId';
  static const history = '/history';
  static const map = '/map';
  static const notifications = '/notifications';
  static const syncStatus = '/sync-status';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isPublic =
          location == AppRoutes.splash || location == AppRoutes.login;
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.asData?.value.isAuthenticated ?? false;

      if (isLoading) return null;
      if (!isAuthenticated && !isPublic) return AppRoutes.login;
      if (isAuthenticated && location == AppRoutes.login) {
        return AppRoutes.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.machines,
        builder: (context, state) => const MachineListScreen(),
      ),
      GoRoute(
        path: AppRoutes.machineDetail,
        builder: (context, state) => ModuleScreen(
          title: 'Detalhe da Maquina',
          icon: Icons.precision_manufacturing,
          message: 'Dados gerais, historico e preventiva da maquina.',
        ),
      ),
      GoRoute(
        path: AppRoutes.occurrences,
        builder: (context, state) => const OccurrencesScreen(),
      ),
      GoRoute(
        path: AppRoutes.newOccurrence,
        builder: (context, state) => const OccurrenceNewScreen(),
      ),
      GoRoute(
        path: AppRoutes.occurrenceDetail,
        builder: (context, state) =>
            OccurrenceDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.inspection,
        builder: (context, state) => const ModuleScreen(
          title: 'Inspecao',
          icon: Icons.fact_check_outlined,
          message: 'Checklist dinamico e diagnostico tecnico.',
        ),
      ),
      GoRoute(
        path: AppRoutes.corrective,
        builder: (context, state) => const ModuleScreen(
          title: 'Corretiva',
          icon: Icons.build_outlined,
          message: 'Solucao aplicada, pecas trocadas e finalizacao.',
        ),
      ),

      GoRoute(
        path: AppRoutes.preventives,
        builder: (context, state) => const ModuleScreen(
          title: 'Preventivas',
          icon: Icons.event_available_outlined,
          message: 'Agenda de preventivas ordenada por proxima data.',
        ),
      ),
      GoRoute(
        path: AppRoutes.checklist,
        builder: (context, state) => const ModuleScreen(
          title: 'Checklist',
          icon: Icons.checklist_outlined,
          message: 'Respostas offline item a item com progresso.',
        ),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const ModuleScreen(
          title: 'Historico',
          icon: Icons.history_outlined,
          message: 'Manutencoes finalizadas com filtros tecnicos.',
        ),
      ),
      GoRoute(
        path: AppRoutes.map,
        builder: (context, state) => const IndustrialMapScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const ModuleScreen(
          title: 'Notificacoes',
          icon: Icons.notifications_outlined,
          message: 'Alertas locais e eventos em tempo real.',
        ),
      ),
      GoRoute(
        path: AppRoutes.syncStatus,
        builder: (context, state) => const SyncStatusScreen(),
      ),
    ],
  );
});
