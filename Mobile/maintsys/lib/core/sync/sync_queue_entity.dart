import 'package:isar/isar.dart';

import '../../shared/constants/status_enum.dart';

part 'sync_queue_entity.g.dart';

@collection
class SyncQueueEntity {
  SyncQueueEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.entityType,
    required this.operation,
    required this.payloadJson,
    this.errorMessage,
    this.syncedAt,
    this.attempts = 0,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @enumerated
  SyncEntityType entityType;

  String operation;
  String payloadJson;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String? errorMessage;
  DateTime? syncedAt;
  int attempts;

  @enumerated
  SyncStatus syncStatus;
}
