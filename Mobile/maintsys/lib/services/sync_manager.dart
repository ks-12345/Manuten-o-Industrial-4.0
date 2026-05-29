import 'sync_queue_service.dart';

abstract interface class SyncManager {
  Future<void> syncPending();
}

class OfflineFirstSyncManager implements SyncManager {
  const OfflineFirstSyncManager(this._queueService);

  final SyncQueueService _queueService;

  @override
  Future<void> syncPending() async {
    final items = await _queueService.pending();

    for (final item in items) {
      try {
        // Supabase upsert/upload will be connected per record type.
        await _queueService.markSynced(item.localId);
      } on Object {
        await _queueService.markError(item.localId);
      }
    }
  }
}
