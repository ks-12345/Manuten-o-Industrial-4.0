import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'inspection_entity.g.dart';

@collection
class InspectionEntity {
  InspectionEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.occurrenceLocalId,
    this.occurrenceRemoteId,
    this.technicianId,
    this.notes = '',
    this.diagnosis = '',
    this.otherProblemDescription,
    this.checklistResponsesJson = '{}',
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  int occurrenceLocalId;

  String? occurrenceRemoteId;
  String? technicianId;
  String notes;
  String diagnosis;
  String? otherProblemDescription;
  String checklistResponsesJson;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  SyncStatus syncStatus;
}
