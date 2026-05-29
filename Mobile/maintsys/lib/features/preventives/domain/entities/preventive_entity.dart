import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'preventive_entity.g.dart';

@collection
class PreventiveEntity {
  PreventiveEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.machineLocalId,
    this.machineRemoteId,
    required this.machineCode,
    this.checklistTemplateRemoteId,
    this.periodicityDays = 30,
    this.lastDone,
    required this.nextDue,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  int machineLocalId;

  String? machineRemoteId;
  String machineCode;
  String? checklistTemplateRemoteId;
  int periodicityDays;
  DateTime? lastDone;
  DateTime nextDue;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  SyncStatus syncStatus;
}
