import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'occurrence_entity.g.dart';

@collection
class OccurrenceEntity {
  OccurrenceEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.machineLocalId,
    this.machineRemoteId,
    required this.machineCode,
    required this.sectorName,
    required this.description,
    this.reporterId,
    this.technicianId,
    List<String> photos = const <String>[],
    this.priority = OccurrencePriority.medium,
    this.status = OccurrenceWorkflowStatus.open,
    this.syncStatus = SyncStatus.pending,
  }) : photos = List<String>.from(photos);

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  int machineLocalId;

  String? machineRemoteId;
  String machineCode;
  String sectorName;
  String description;
  String? reporterId;
  String? technicianId;
  List<String> photos;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  OccurrencePriority priority;

  @enumerated
  OccurrenceWorkflowStatus status;

  @enumerated
  SyncStatus syncStatus;
}
