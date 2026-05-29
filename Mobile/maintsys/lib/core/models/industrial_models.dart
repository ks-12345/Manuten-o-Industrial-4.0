import '../enums/maintenance_enums.dart';

class IndustrialMetric {
  const IndustrialMetric({
    required this.label,
    required this.value,
    required this.trend,
    required this.status,
  });

  final String label;
  final String value;
  final String trend;
  final MachineStatus status;
}

class MachineSummary {
  const MachineSummary({
    required this.id,
    required this.code,
    required this.name,
    required this.sector,
    required this.status,
    required this.lastUpdate,
    required this.mtbfHours,
    required this.mttrHours,
  });

  final String id;
  final String code;
  final String name;
  final String sector;
  final MachineStatus status;
  final DateTime lastUpdate;
  final double mtbfHours;
  final double mttrHours;
}

class OccurrenceSummary {
  const OccurrenceSummary({
    required this.id,
    required this.machineCode,
    required this.sector,
    required this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String machineCode;
  final String sector;
  final String description;
  final PriorityLevel priority;
  final OccurrenceStatus status;
  final DateTime createdAt;
  final SyncStatus syncStatus;
}

class SyncQueueItem {
  const SyncQueueItem({
    required this.localId,
    required this.recordType,
    required this.createdAt,
    required this.status,
    required this.attempts,
    this.syncedAt,
  });

  final String localId;
  final String recordType;
  final DateTime createdAt;
  final SyncStatus status;
  final int attempts;
  final DateTime? syncedAt;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.metrics,
    required this.machines,
    required this.occurrences,
    required this.syncQueue,
  });

  final List<IndustrialMetric> metrics;
  final List<MachineSummary> machines;
  final List<OccurrenceSummary> occurrences;
  final List<SyncQueueItem> syncQueue;
}
