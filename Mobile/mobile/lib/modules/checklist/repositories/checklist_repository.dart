import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../models/checklist_model.dart';

class ChecklistRepository {
  ChecklistRepository({Isar? isar}) : _isar = isar ?? IsarService.isar;
  final Isar _isar;

  Future<ChecklistModel?> getById(int checklistId) async {
    return _isar.checklistModels.get(checklistId);
  }

  Stream<List<ChecklistModel>> watchByMachineId(int machineId) {
    return _isar.checklistModels
        .filter()
        .machineIdEqualTo(machineId)
        .watch(fireImmediately: true);
  }

  Stream<List<ChecklistQuestionModel>> watchQuestionsByChecklistId(
      int checklistId) {
    return _isar.checklistQuestionModels
        .filter()
        .checklistIdEqualTo(checklistId)
        .sortByOrder()
        .watch(fireImmediately: true);
  }

  Future<List<ChecklistQuestionModel>> getQuestionsByChecklistId(
      int checklistId) async {
    return _isar.checklistQuestionModels
        .filter()
        .checklistIdEqualTo(checklistId)
        .sortByOrder()
        .findAll();
  }

  Future<ChecklistModel> createChecklist({
    required int machineId,
    required int technicianId,
    required String title,
    required ChecklistType type,
  }) async {
    final checklist = ChecklistModel()
      ..machineId = machineId
      ..technicianId = technicianId
      ..title = title
      ..type = type
      ..isFinished = false;

    await _isar.writeTxn(() async {
      await _isar.checklistModels.put(checklist);
    });

    return checklist;
  }

  Future<void> finishChecklist({required int checklistId}) async {
    await _isar.writeTxn(() async {
      final checklist = await _isar.checklistModels.get(checklistId);
      if (checklist == null) return;
      checklist
        ..isFinished = true
        ..finishedAt = DateTime.now();
      await _isar.checklistModels.put(checklist);
    });
  }

  Future<void> upsertAnswer({required ChecklistAnswerModel answer}) async {
    await _isar.writeTxn(() async {
      // Unique constraint is not declared, so we emulate upsert by deleting existing.
      final existing = await _isar.checklistAnswerModels
          .filter()
          .questionIdEqualTo(answer.questionId)
          .checklistIdEqualTo(answer.checklistId)
          .findFirst();

      if (existing != null) {
        await _isar.checklistAnswerModels.delete(existing.id);
      }

      await _isar.checklistAnswerModels.put(answer);
    });
  }

  Future<ChecklistAnswerModel?> getAnswer(
      {required int checklistId, required int questionId}) async {
    return _isar.checklistAnswerModels
        .filter()
        .checklistIdEqualTo(checklistId)
        .questionIdEqualTo(questionId)
        .findFirst();
  }

  Future<Map<int, ChecklistAnswerModel>> getAnswersByChecklistId(
      int checklistId) async {
    final answers = await _isar.checklistAnswerModels
        .filter()
        .checklistIdEqualTo(checklistId)
        .findAll();

    return {for (final a in answers) a.questionId: a};
  }

  Future<void> seedQuestionsIfEmpty({
    required int checklistId,
    required List<ChecklistQuestionModel> questions,
  }) async {
    final existingCount = await _isar.checklistQuestionModels
        .filter()
        .checklistIdEqualTo(checklistId)
        .count();
    if (existingCount > 0) return;

    await _isar.writeTxn(() async {
      for (final q in questions) {
        await _isar.checklistQuestionModels.put(q);
      }
    });
  }
}
