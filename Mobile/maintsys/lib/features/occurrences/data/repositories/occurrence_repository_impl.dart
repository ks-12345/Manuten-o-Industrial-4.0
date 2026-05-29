import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../../core/database/isar_service.dart';
import '../../../../../core/enums/maintenance_enums.dart' as core_enums;
import '../../../../../core/models/industrial_models.dart';
import '../../../../../core/network/connectivity_service.dart';
import '../../../../../core/sync/sync_manager.dart';
import '../../../../../core/sync/sync_queue_entity.dart';
import '../../../../../core/supabase/supabase_service.dart';
import '../../../../../shared/constants/status_enum.dart' as shared_enums;

import '../../../machines/domain/entities/machine_entity.dart';
import '../../../occurrences/domain/entities/occurrence_entity.dart';
import '../../domain/repositories/occurrence_repository.dart';

final occurrenceRepositoryImplProvider = Provider<OccurrenceRepository>((ref) {
  return OccurrenceRepositoryImpl(
    isarService: IsarService.instance,
    syncManager: ref.read(syncManagerProvider),
    supabaseService: SupabaseService.instance,
    connectivityService: ref.read(connectivityServiceProvider),
  );
});

class OccurrenceRepositoryImpl implements OccurrenceRepository {
  OccurrenceRepositoryImpl({
    required IsarService isarService,
    required SyncManager syncManager,
    required SupabaseService supabaseService,
    required ConnectivityService connectivityService,
  }) : _isarService = isarService,
       _syncManager = syncManager,
       _supabaseService = supabaseService,
       _connectivityService = connectivityService;

  final IsarService _isarService;
  final SyncManager _syncManager;
  final SupabaseService _supabaseService;
  final ConnectivityService _connectivityService;

  @override
  Future<List<OccurrenceSummary>> watchAll() async {
    final isar = await _isarService.database;
    final entities = await isar.occurrenceEntitys.where().findAll();

    // Offline-first: retorna Isar imediatamente.
    _refreshRemoteInBackground();

    return entities.map(_toSummary).toList();
  }

  @override
  Future<OccurrenceSummary> getById(String id) async {
    final isar = await _isarService.database;

    final localId = int.tryParse(id.replaceFirst('local-', ''));

    OccurrenceEntity? entity;
    if (localId != null) {
      entity = await isar.occurrenceEntitys.get(localId);
    }

    entity ??= await isar.occurrenceEntitys
        .filter()
        .remoteIdEqualTo(id)
        .findFirst();

    if (entity == null) {
      throw StateError('Ocorrência não encontrada: $id');
    }

    return _toSummary(entity);
  }

  @override
  @override
  Future<OccurrenceSummary> create({
    required MachineEntity machine,
    required String description,
    required shared_enums.OccurrencePriority priority,
  }) async {
    final isar = await _isarService.database;

    final entity = OccurrenceEntity(
      machineLocalId: machine.localId,
      machineRemoteId: machine.remoteId,
      machineCode: machine.code,
      sectorName: machine.sectorName,
      description: description,
      priority: priority,

      status: shared_enums.OccurrenceWorkflowStatus.open,
      syncStatus: shared_enums.SyncStatus.pending,
    );

    await isar.writeTxn(() async {
      await isar.occurrenceEntitys.put(entity);
    });

    await _syncManager.enqueue(
      entityType: shared_enums.SyncEntityType.occurrence,
      operation: 'create',
      payload: {
        'local_id': entity.localId,
        'machine_id': entity.machineRemoteId,
        'machine_code': entity.machineCode,
        'sector': entity.sectorName,
        'description': entity.description,
        'priority': entity.priority.name,
        'status': entity.status.name,
      },
    );

    return _toSummary(entity);
  }

  @override
  Future<OccurrenceSummary> updateWorkflow({
    required String localId,
    required shared_enums.OccurrenceWorkflowStatus status,
    String? technicianId,
  }) async {
    final isar = await _isarService.database;

    final parsed = int.tryParse(localId.replaceFirst('local-', ''));
    if (parsed == null) {
      throw ArgumentError('localId inválido: $localId');
    }

    final entity = await isar.occurrenceEntitys.get(parsed);
    if (entity == null) {
      throw StateError('Ocorrência não encontrada no Isar: $localId');
    }

    entity
      ..status = status
      ..technicianId = technicianId
      ..updatedAt = DateTime.now()
      ..syncStatus = shared_enums.SyncStatus.pending;

    await isar.writeTxn(() async {
      await isar.occurrenceEntitys.put(entity);
    });

    await _syncManager.enqueue(
      entityType: shared_enums.SyncEntityType.occurrence,
      operation: 'update',
      payload: {
        'local_id': entity.localId,
        'id': entity.remoteId,
        'machine_id': entity.machineRemoteId,
        'technician_id': entity.technicianId,
        'description': entity.description,
        'priority': entity.priority.name,
        'status': entity.status.name,
      },
    );

    return _toSummary(entity);
  }

  OccurrenceSummary _toSummary(OccurrenceEntity e) {
    return OccurrenceSummary(
      id: e.remoteId ?? 'local-${e.localId}',
      machineCode: e.machineCode,
      sector: e.sectorName,
      description: e.description,
      priority: _mapPriorityToCore(e.priority),
      status: _mapStatusToCore(e.status),
      createdAt: e.createdAt,
      syncStatus: _mapSyncStatusToCore(e.syncStatus),
    );
  }

  core_enums.PriorityLevel _mapPriorityToCore(
    shared_enums.OccurrencePriority p,
  ) {
    return switch (p) {
      shared_enums.OccurrencePriority.low => core_enums.PriorityLevel.low,
      shared_enums.OccurrencePriority.medium => core_enums.PriorityLevel.medium,
      shared_enums.OccurrencePriority.high => core_enums.PriorityLevel.high,
      shared_enums.OccurrencePriority.critical =>
        core_enums.PriorityLevel.critical,
    };
  }

  core_enums.OccurrenceStatus _mapStatusToCore(
    shared_enums.OccurrenceWorkflowStatus s,
  ) {
    return switch (s) {
      shared_enums.OccurrenceWorkflowStatus.open =>
        core_enums.OccurrenceStatus.open,
      shared_enums.OccurrenceWorkflowStatus.underAnalysis =>
        core_enums.OccurrenceStatus.underAnalysis,
      shared_enums.OccurrenceWorkflowStatus.inMaintenance =>
        core_enums.OccurrenceStatus.inMaintenance,
      shared_enums.OccurrenceWorkflowStatus.finished =>
        core_enums.OccurrenceStatus.finished,
      shared_enums.OccurrenceWorkflowStatus.canceled =>
        core_enums.OccurrenceStatus.canceled,
    };
  }

  core_enums.SyncStatus _mapSyncStatusToCore(shared_enums.SyncStatus s) {
    return core_enums.SyncStatus.values.firstWhere(
      (v) => v.name == s.name,
      orElse: () => core_enums.SyncStatus.pending,
    );
  }

  void _refreshRemoteInBackground() {
    // Neste sprint, mantemos offline-first apenas.
    if (!_supabaseService.isConfigured) return;
    _connectivityService.isOnline().then((online) {
      if (!online) return;
      // TODO: refresh remoto (quando mapper remoto estiver implementado)
    });
  }
}
