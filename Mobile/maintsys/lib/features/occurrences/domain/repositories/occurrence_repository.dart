import '../../../../../core/models/industrial_models.dart';
import '../../../machines/domain/entities/machine_entity.dart';
import '../../../../../shared/constants/status_enum.dart';

/// Abstração de operações para ocorrências (offline-first).
abstract interface class OccurrenceRepository {
  /// Lista offline-first (Isar). Refresh remoto pode ser adicionado depois.
  Future<List<OccurrenceSummary>> watchAll();

  /// Busca por id (remoteId ou localId formatado como `local-<id>`).
  Future<OccurrenceSummary> getById(String id);

  /// Cria uma ocorrência localmente.
  ///
  /// Regras:
  /// - persistir no Isar primeiro
  /// - enfileirar na SyncQueueEntity (CREATE)
  Future<OccurrenceSummary> create({
    required MachineEntity machine,
    required String description,
    required OccurrencePriority priority,
  });

  /// Atualiza workflow localmente.
  ///
  /// Regras:
  /// - persistir no Isar primeiro
  /// - enfileirar na SyncQueueEntity (UPDATE)
  Future<OccurrenceSummary> updateWorkflow({
    required String localId,
    required OccurrenceWorkflowStatus status,
    String? technicianId,
  });
}
