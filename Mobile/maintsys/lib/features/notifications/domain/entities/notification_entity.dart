import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'notification_entity.g.dart';

@collection
class NotificationEntity {
  NotificationEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.title,
    required this.message,
    this.relatedRoute,
    this.readAt,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  String title;
  String message;
  String? relatedRoute;
  DateTime? readAt;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  SyncStatus syncStatus;
}
