import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'corrective_entity.g.dart';

@collection
class CorrectiveEntity {
  CorrectiveEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.occurrenceLocalId,
    this.occurrenceRemoteId,
    this.technicianId,
    this.solution = '',
    this.partsReplacedJson = '[]',
    List<String> photos = const <String>[],
    this.repairTimeMinutes = 0,
    this.finalNotes = '',
    this.finishedAt,
    this.syncStatus = SyncStatus.pending,
  }) : photos = List<String>.from(photos);

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  int occurrenceLocalId;

  String? occurrenceRemoteId;
  String? technicianId;
  String solution;
  String partsReplacedJson;
  List<String> photos;
  int repairTimeMinutes;
  String finalNotes;
  DateTime? finishedAt;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  SyncStatus syncStatus;
}
