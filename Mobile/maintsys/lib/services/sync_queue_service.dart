import '../core/enums/maintenance_enums.dart';

class SyncQueuePayload {
  const SyncQueuePayload({
    required this.localId,
    required this.recordType,
    required this.payload,
    required this.createdAt,
    required this.status,
    required this.attempts,
    this.syncedAt,
  });

  final String localId;
  final String recordType;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final SyncStatus status;
  final int attempts;
  final DateTime? syncedAt;
}

abstract interface class SyncQueueService {
  Future<void> enqueue(SyncQueuePayload payload);

  Future<List<SyncQueuePayload>> pending();

  Future<void> markSynced(String localId);

  Future<void> markError(String localId);
}
