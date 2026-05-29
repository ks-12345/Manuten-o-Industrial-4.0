enum SyncStatus { pending, syncing, synced, error }

enum MachineOperationalStatus { operating, attention, stopped, maintenance }

enum OccurrencePriority { low, medium, high, critical }

enum OccurrenceWorkflowStatus {
  open,
  underAnalysis,
  inMaintenance,
  finished,
  canceled,
}

enum ChecklistType { inspection, preventive, corrective }

enum ChecklistAnswerType { yesNo, okProblem, text, observation, photo }

enum SyncEntityType {
  machine,
  occurrence,
  inspection,
  corrective,
  preventive,
  checklist,
  checklistItem,
  notification,
}

enum AppUserRole { admin, supervisor, technician }

extension SyncStatusX on SyncStatus {
  String get label => switch (this) {
    SyncStatus.pending => 'Pendente',
    SyncStatus.syncing => 'Sincronizando',
    SyncStatus.synced => 'Sincronizado',
    SyncStatus.error => 'Erro',
  };

  String get remoteValue => name;
}

extension MachineOperationalStatusX on MachineOperationalStatus {
  String get label => switch (this) {
    MachineOperationalStatus.operating => 'Operando',
    MachineOperationalStatus.attention => 'Atencao',
    MachineOperationalStatus.stopped => 'Parada',
    MachineOperationalStatus.maintenance => 'Manutencao',
  };
}

extension OccurrencePriorityX on OccurrencePriority {
  String get label => switch (this) {
    OccurrencePriority.low => 'Baixa',
    OccurrencePriority.medium => 'Media',
    OccurrencePriority.high => 'Alta',
    OccurrencePriority.critical => 'Critica',
  };
}

extension OccurrenceWorkflowStatusX on OccurrenceWorkflowStatus {
  String get label => switch (this) {
    OccurrenceWorkflowStatus.open => 'Aberta',
    OccurrenceWorkflowStatus.underAnalysis => 'Em analise',
    OccurrenceWorkflowStatus.inMaintenance => 'Em manutencao',
    OccurrenceWorkflowStatus.finished => 'Finalizada',
    OccurrenceWorkflowStatus.canceled => 'Cancelada',
  };
}

extension AppUserRoleX on AppUserRole {
  String get label => switch (this) {
    AppUserRole.admin => 'Administrador',
    AppUserRole.supervisor => 'Supervisor',
    AppUserRole.technician => 'Tecnico',
  };

  static AppUserRole fromRemote(String? value) {
    return AppUserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => AppUserRole.technician,
    );
  }
}
