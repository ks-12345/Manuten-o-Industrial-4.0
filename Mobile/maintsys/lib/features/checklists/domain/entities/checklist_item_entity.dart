import 'package:isar/isar.dart';

import '../../../../shared/constants/status_enum.dart';

part 'checklist_item_entity.g.dart';

@collection
class ChecklistItemEntity {
  ChecklistItemEntity({
    this.localId = Isar.autoIncrement,
    this.remoteId,
    required this.checklistLocalId,
    this.occurrenceLocalId,
    required this.question,
    this.answer,
    this.observation,
    this.photoPath,
    this.isRequired = true,
    this.answerType = ChecklistAnswerType.okProblem,
    this.syncStatus = SyncStatus.pending,
  });

  Id localId;

  @Index(unique: true, replace: true)
  String? remoteId;

  @Index()
  int checklistLocalId;

  int? occurrenceLocalId;
  String question;
  String? answer;
  String? observation;
  String? photoPath;
  bool isRequired;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  @enumerated
  ChecklistAnswerType answerType;

  @enumerated
  SyncStatus syncStatus;
}
