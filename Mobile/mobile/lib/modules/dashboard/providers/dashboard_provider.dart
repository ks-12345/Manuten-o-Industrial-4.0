import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

import '../../../core/database/isar_service.dart';
import '../../maquinas/models/machine_model.dart';
import '../../ocorrencias/models/occurrence_model.dart';

class DashboardKpis {
  final int machinesActive;
  final int machinesBroken;
  final int preventivesOverdue;
  final int correctivesOpen;
  final int occurrencesOpen;

  const DashboardKpis({
    required this.machinesActive,
    required this.machinesBroken,
    required this.preventivesOverdue,
    required this.correctivesOpen,
    required this.occurrencesOpen,
  });
}

class DashboardState {
  final DashboardKpis kpis;
  final List<PieChartSectionData> statusPie;
  final BarChartGroupData? occurrencesBars;

  const DashboardState({
    required this.kpis,
    required this.statusPie,
    required this.occurrencesBars,
  });

  static const empty = DashboardState(
    kpis: DashboardKpis(
      machinesActive: 0,
      machinesBroken: 0,
      preventivesOverdue: 0,
      correctivesOpen: 0,
      occurrencesOpen: 0,
    ),
    statusPie: [],
    occurrencesBars: null,
  );
}

final dashboardProvider = FutureProvider<DashboardState>((ref) async {
  final isar = IsarService.isar;

  final machines = await isar.machineModels.where().findAll();
  final occurrences = await isar.occurrenceModels.where().findAll();

  final active = machines.where((m) => m.status == MachineStatus.active).length;
  final broken = machines.where((m) => m.status == MachineStatus.broken).length;

  final now = DateTime.now();
  int preventivesOverdue = 0;

  for (final m in machines) {
    final next = m.nextPreventive;
    if (next != null && next.isBefore(now)) {
      preventivesOverdue++;
    }
  }

  final occurrencesOpen = occurrences
      .where((o) =>
          o.status == OccurrenceStatus.open ||
          o.status == OccurrenceStatus.analysis)
      .length;

  // Sem modelo de corretiva ainda no repo, usamos ocorrências em manutenção como proxy.
  final correctivesOpen =
      occurrences.where((o) => o.status == OccurrenceStatus.maintenance).length;

  final total = machines.isEmpty ? 1 : machines.length;
  PieChartSectionData section(int value, int total, int color) {
    return PieChartSectionData(
      value: value.toDouble(),
      color: Color(color),
      radius: 52,
      title: '${((value / total) * 100).toStringAsFixed(0)}%',
      titleStyle: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFE8EAF0)),
    );
  }

  final statusPie = <PieChartSectionData>[
    section(machines.where((m) => m.status == MachineStatus.active).length,
        total, 0xFF00C853),
    section(machines.where((m) => m.status == MachineStatus.attention).length,
        total, 0xFFFFD600),
    section(machines.where((m) => m.status == MachineStatus.broken).length,
        total, 0xFFD50000),
    section(machines.where((m) => m.status == MachineStatus.maintenance).length,
        total, 0xFF2962FF),
  ];

  // Barras: ocorrências por prioridade (4 categorias)
  int low =
      occurrences.where((o) => o.priority == OccurrencePriority.low).length;
  int medium =
      occurrences.where((o) => o.priority == OccurrencePriority.medium).length;
  int high =
      occurrences.where((o) => o.priority == OccurrencePriority.high).length;
  int critical = occurrences
      .where((o) => o.priority == OccurrencePriority.critical)
      .length;

  final barGroups = BarChartGroupData(
    x: 0,
    barRods: [
      BarChartRodData(toY: low.toDouble(), color: const Color(0xFF8B8FA8)),
      BarChartRodData(toY: medium.toDouble(), color: const Color(0xFFFFD600)),
      BarChartRodData(toY: high.toDouble(), color: const Color(0xFF2962FF)),
      BarChartRodData(toY: critical.toDouble(), color: const Color(0xFFD50000)),
    ],
  );

  return DashboardState(
    kpis: DashboardKpis(
      machinesActive: active,
      machinesBroken: broken,
      preventivesOverdue: preventivesOverdue,
      correctivesOpen: correctivesOpen,
      occurrencesOpen: occurrencesOpen,
    ),
    statusPie: statusPie,
    occurrencesBars: barGroups,
  );
});
