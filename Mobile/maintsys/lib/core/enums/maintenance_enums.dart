enum MachineStatus { running, attention, broken, maintenance }

enum OccurrenceStatus { open, underAnalysis, inMaintenance, finished, canceled }

enum PriorityLevel { low, medium, high, critical }

enum SyncStatus { pending, syncing, synced, error }

enum UserRole { admin, supervisor, technician }

extension MachineStatusLabel on MachineStatus {
  String get label => switch (this) {
    MachineStatus.running => 'Funcionando',
    MachineStatus.attention => 'Atencao',
    MachineStatus.broken => 'Quebrada',
    MachineStatus.maintenance => 'Manutencao',
  };
}

extension OccurrenceStatusLabel on OccurrenceStatus {
  String get label => switch (this) {
    OccurrenceStatus.open => 'Aberto',
    OccurrenceStatus.underAnalysis => 'Em analise',
    OccurrenceStatus.inMaintenance => 'Em manutencao',
    OccurrenceStatus.finished => 'Finalizado',
    OccurrenceStatus.canceled => 'Cancelado',
  };
}

extension PriorityLevelLabel on PriorityLevel {
  String get label => switch (this) {
    PriorityLevel.low => 'Baixa',
    PriorityLevel.medium => 'Media',
    PriorityLevel.high => 'Alta',
    PriorityLevel.critical => 'Critica',
  };
}

extension SyncStatusLabel on SyncStatus {
  String get label => switch (this) {
    SyncStatus.pending => 'Pendente',
    SyncStatus.syncing => 'Sincronizando',
    SyncStatus.synced => 'Sincronizado',
    SyncStatus.error => 'Erro',
  };
}
