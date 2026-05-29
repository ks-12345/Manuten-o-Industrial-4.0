import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../features/checklists/domain/entities/checklist_entity.dart';
import '../../features/checklists/domain/entities/checklist_item_entity.dart';
import '../../features/correctives/domain/entities/corrective_entity.dart';
import '../../features/inspections/domain/entities/inspection_entity.dart';
import '../../features/machines/domain/entities/machine_entity.dart';
import '../../features/notifications/domain/entities/notification_entity.dart';
import '../../features/occurrences/domain/entities/occurrence_entity.dart';
import '../../features/preventives/domain/entities/preventive_entity.dart';
import '../../shared/constants/status_enum.dart';
import '../database/isar_service.dart';
import '../network/connectivity_service.dart';
import '../supabase/supabase_service.dart';
import 'sync_queue_entity.dart';

final syncManagerProvider = Provider<SyncManager>((ref) {
  return SyncManager(
    isarService: IsarService.instance,
    supabaseService: SupabaseService.instance,
    connectivityService: ref.watch(connectivityServiceProvider),
  );
});

final syncBootstrapProvider = Provider<void>((ref) {
  final manager = ref.watch(syncManagerProvider);
  final subscription = manager.watchConnectivityAndSync();
  ref.onDispose(subscription.cancel);
});

class SyncManager {
  SyncManager({
    required IsarService isarService,
    required SupabaseService supabaseService,
    required ConnectivityService connectivityService,
  }) : _isarService = isarService,
       _supabaseService = supabaseService,
       _connectivityService = connectivityService;

  final IsarService _isarService;
  final SupabaseService _supabaseService;
  final ConnectivityService _connectivityService;

  StreamSubscription<bool> watchConnectivityAndSync() {
    return _connectivityService.watchOnline().listen((online) {
      if (online) unawaited(processQueue());
    });
  }

  Future<void> enqueue({
    required SyncEntityType entityType,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    final isar = await _isarService.database;
    final item = SyncQueueEntity(
      entityType: entityType,
      operation: operation,
      payloadJson: jsonEncode(payload),
    );

    await isar.writeTxn(() => isar.syncQueueEntitys.put(item));
  }

  Future<void> processQueue() async {
    if (!_supabaseService.isConfigured) return;
    if (!await _connectivityService.isOnline()) return;

    final isar = await _isarService.database;
    final queue = await isar.syncQueueEntitys
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .or()
        .syncStatusEqualTo(SyncStatus.error)
        .findAll();

    for (final item in queue) {
      final elapsed = DateTime.now().difference(item.updatedAt);
      final backoff = Duration(seconds: 1 << item.attempts.clamp(0, 5));
      if (item.syncStatus == SyncStatus.error &&
          item.attempts < 5 &&
          elapsed < backoff) {
        continue;
      }
      await _syncItem(isar, item);
    }
  }

  Future<void> retryFailed(int localId) async {
    final isar = await _isarService.database;
    final item = await isar.syncQueueEntitys.get(localId);
    if (item == null) return;
    item.syncStatus = SyncStatus.pending;
    item.updatedAt = DateTime.now();
    await isar.writeTxn(() => isar.syncQueueEntitys.put(item));
    await processQueue();
  }

  Future<void> _syncItem(Isar isar, SyncQueueEntity item) async {
    item.syncStatus = SyncStatus.syncing;
    item.updatedAt = DateTime.now();
    await isar.writeTxn(() => isar.syncQueueEntitys.put(item));

    try {
      final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
      final table = _tableFor(item.entityType);
      final response = await _supabaseService.client
          .from(table)
          .upsert(payload, onConflict: 'id')
          .select('id')
          .maybeSingle();

      final remoteId = response?['id']?.toString() ?? payload['id']?.toString();
      await _markEntitySynced(isar, item.entityType, payload, remoteId);

      item.remoteId = remoteId;
      item.syncedAt = DateTime.now();
      item.syncStatus = SyncStatus.synced;
      item.errorMessage = null;
      item.updatedAt = DateTime.now();
      await isar.writeTxn(() => isar.syncQueueEntitys.put(item));
    } on Object catch (error) {
      item.attempts += 1;
      item.errorMessage = error.toString();
      item.syncStatus = item.attempts >= 5
          ? SyncStatus.error
          : SyncStatus.pending;
      item.updatedAt = DateTime.now();
      await isar.writeTxn(() => isar.syncQueueEntitys.put(item));
    }
  }

  String _tableFor(SyncEntityType type) => switch (type) {
    SyncEntityType.machine => 'machines',
    SyncEntityType.occurrence => 'occurrences',
    SyncEntityType.inspection => 'inspections',
    SyncEntityType.corrective => 'correctives',
    SyncEntityType.preventive => 'preventives',
    SyncEntityType.checklist => 'checklists',
    SyncEntityType.checklistItem => 'checklist_items',
    SyncEntityType.notification => 'notifications',
  };

  Future<void> _markEntitySynced(
    Isar isar,
    SyncEntityType type,
    Map<String, dynamic> payload,
    String? remoteId,
  ) async {
    final localId = payload['local_id'];
    if (localId is! int) return;

    await isar.writeTxn(() async {
      switch (type) {
        case SyncEntityType.machine:
          final entity = await isar.machineEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.machineEntitys.put(entity);
          }
        case SyncEntityType.occurrence:
          final entity = await isar.occurrenceEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.occurrenceEntitys.put(entity);
          }
        case SyncEntityType.inspection:
          final entity = await isar.inspectionEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.inspectionEntitys.put(entity);
          }
        case SyncEntityType.corrective:
          final entity = await isar.correctiveEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.correctiveEntitys.put(entity);
          }
        case SyncEntityType.preventive:
          final entity = await isar.preventiveEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.preventiveEntitys.put(entity);
          }
        case SyncEntityType.checklist:
          final entity = await isar.checklistEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.checklistEntitys.put(entity);
          }
        case SyncEntityType.checklistItem:
          final entity = await isar.checklistItemEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.checklistItemEntitys.put(entity);
          }
        case SyncEntityType.notification:
          final entity = await isar.notificationEntitys.get(localId);
          if (entity != null) {
            entity.remoteId = remoteId ?? entity.remoteId;
            entity.syncStatus = SyncStatus.synced;
            entity.updatedAt = DateTime.now();
            await isar.notificationEntitys.put(entity);
          }
      }
    });
  }
}
