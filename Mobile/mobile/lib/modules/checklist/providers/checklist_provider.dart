import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/isar_service.dart';
import '../models/checklist_model.dart';
import '../repositories/checklist_repository.dart';

final checklistRepositoryProvider = Provider((ref) {
  return ChecklistRepository();
});

class ChecklistState {
  final AsyncValue<ChecklistModel?> checklist;
  final AsyncValue<Map<int, ChecklistAnswerModel>> answers;

  const ChecklistState({
    this.checklist = const AsyncValue.data(null),
    this.answers = const AsyncValue.data({}),
  });

  ChecklistState copyWith({
    AsyncValue<ChecklistModel?>? checklist,
    AsyncValue<Map<int, ChecklistAnswerModel>>? answers,
  }) {
    return ChecklistState(
      checklist: checklist ?? this.checklist,
      answers: answers ?? this.answers,
    );
  }
}

class ChecklistController extends StateNotifier<ChecklistState> {
  ChecklistController({
    required ChecklistRepository repository,
  })  : _repository = repository,
        super(const ChecklistState());

  final ChecklistRepository _repository;

  Future<void> loadChecklist(int checklistId) async {
    state = state.copyWith(
        checklist: const AsyncValue.loading(),
        answers: const AsyncValue.loading());

    final checklist = await _repository.getById(checklistId);
    final answers = await _repository.getAnswersByChecklistId(checklistId);

    state = state.copyWith(
      checklist: AsyncValue.data(checklist),
      answers: AsyncValue.data(answers),
    );
  }

  Future<void> ensureChecklistAndQuestions({
    required int machineId,
    required int technicianId,
    required int checklistId,
    required ChecklistType type,
  }) async {
    // For now, we expect checklistId to exist; for a robust offline-first flow,
    // pages can create it when needed.
    await loadChecklist(checklistId);
  }

  Future<void> updateAnswer({
    required int checklistId,
    required ChecklistQuestionModel question,
    required ChecklistAnswerModel answer,
  }) async {
    await _repository.upsertAnswer(answer: answer);
    final answers = await _repository.getAnswersByChecklistId(checklistId);
    state = state.copyWith(answers: AsyncValue.data(answers));
  }

  Future<void> finish(int checklistId) async {
    await _repository.finishChecklist(checklistId: checklistId);
    await loadChecklist(checklistId);
  }
}

final checklistControllerProvider = StateNotifierProvider.autoDispose
    .family<ChecklistController, ChecklistState, int>((ref, checklistId) {
  final repository = ref.watch(checklistRepositoryProvider);
  final controller = ChecklistController(repository: repository);
  controller.loadChecklist(checklistId);
  return controller;
});

final checklistAnswersProvider =
    Provider.family<Map<int, ChecklistAnswerModel>, int>((ref, checklistId) {
  final s = ref.watch(checklistControllerProvider(checklistId));
  return s.answers
      .maybeWhen(data: (v) => v, orElse: () => <int, ChecklistAnswerModel>{});
});
