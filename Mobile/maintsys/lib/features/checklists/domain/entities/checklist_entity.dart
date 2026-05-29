import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'checklist_entity.g.dart';

@collection
class ChecklistEntity {
  ChecklistEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.title,
    required this.machineType,
    this.itemsJson = '[]',
    this.type = ChecklistType.inspection,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  String title;
  String machineType;
  String itemsJson;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  ChecklistType type;

  @enumerated
  SyncStatus syncStatus;
}
