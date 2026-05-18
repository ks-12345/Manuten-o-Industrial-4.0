import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../modules/auth/pages/login_page.dart';
import '../../modules/dashboard/pages/dashboard_page.dart';
import '../../modules/mapa/pages/mapa_page.dart';
import '../../modules/maquinas/pages/maquinas_page.dart';
import '../../modules/maquinas/pages/machine_detail_page.dart';
import '../../modules/ocorrencias/pages/ocorrencias_page.dart';
import '../../modules/ocorrencias/pages/nova_ocorrencia_page.dart';
import '../../modules/checklist/pages/checklist_page.dart';
import '../../modules/historico/pages/historico_page.dart';
import '../../shared/widgets/industrial_scaffold.dart';

part 'app_router.g.dart';

// Router guardado para remover runtime navigation errors no momento de compilação.

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
      ShellRoute(
        builder: (_, __, child) => IndustrialScaffold(child: child),
        routes: [
          GoRoute(
              path: '/dashboard', builder: (_, __) => const DashboardPage()),
          GoRoute(path: '/mapa', builder: (_, __) => const MapaPage()),
          GoRoute(path: '/maquinas', builder: (_, __) => const MaquinasPage()),
          GoRoute(
            path: '/maquinas/:id',
            builder: (_, state) => MachineDetailPage(
              machineId: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
              path: '/ocorrencias',
              builder: (_, __) => const OcorrenciasPage()),
          GoRoute(
              path: '/ocorrencias/nova',
              builder: (_, __) => const NovaOcorrenciaPage()),
          GoRoute(
            path: '/checklist/:machineId',
            builder: (_, state) => ChecklistPage(
              machineId: int.parse(state.pathParameters['machineId']!),
              checklistId: 1,
            ),
          ),
          GoRoute(
              path: '/historico', builder: (_, __) => const HistoricoPage()),
        ],
      ),
    ],
  );
}
