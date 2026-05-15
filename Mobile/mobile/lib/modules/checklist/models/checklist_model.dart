import 'package:isar/isar.dart';

part 'checklist_model.g.dart';

enum ChecklistType { preventive, corrective, inspection, daily }
enum QuestionType { yesNo, okProblem, text, observation, photo }

@collection
class ChecklistModel {
  Id id = Isar.autoIncrement;
  late int machineId;
  late int technicianId;
  late String title;

  @Enumerated(EnumType.name)
  late ChecklistType type;

  bool isFinished = false;
  DateTime createdAt = DateTime.now();
  DateTime? finishedAt;
}

@collection
class ChecklistQuestionModel {
  Id id = Isar.autoIncrement;
  late int checklistId;
  late String question;
  late int order;

  @Enumerated(EnumType.name)
  late QuestionType type;

  bool isRequired = true;
}

@collection
class ChecklistAnswerModel {
  Id id = Isar.autoIncrement;
  late int questionId;
  late int checklistId;
  String? textAnswer;
  bool? boolAnswer;
  String? photoPath;
  DateTime answeredAt = DateTime.now();
}