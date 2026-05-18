import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../models/checklist_model.dart';
import '../providers/checklist_provider.dart';
import '../repositories/checklist_repository.dart';
import '../widgets/checklist_question_widget.dart';

class ChecklistPage extends ConsumerStatefulWidget {
  final int machineId;
  final int checklistId;

  const ChecklistPage({
    super.key,
    required this.machineId,
    required this.checklistId,
  });

  @override
  ConsumerState<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends ConsumerState<ChecklistPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checklistControllerProvider(widget.checklistId));
    final answers = state.answers.maybeWhen(
      data: (v) => v,
      orElse: () => <int, ChecklistAnswerModel>{},
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('CHECKLIST TÉCNICO'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(state.checklist),
            const SizedBox(height: 12),
            Expanded(
              child: state.checklist.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    'Falha ao carregar checklist\n$e',
                    style: const TextStyle(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                ),
                data: (checklist) {
                  if (checklist == null) {
                    return const Center(
                      child: Text(
                        'Checklist não encontrado.',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    );
                  }

                  return _ChecklistBody(
                    checklistId: widget.checklistId,
                    answers: answers,
                    scrollController: _scrollController,
                    disabled: checklist.isFinished,
                  );
                },
              ),
            ),
            _buildFooter(state.checklist),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AsyncValue<ChecklistModel?> checklist) {
    return checklist.when(
      loading: () =>
          _IndustrialHeaderSkeleton().animate().fadeIn(duration: 220.ms),
      error: (_, __) =>
          _IndustrialHeaderSkeleton().animate().fadeIn(duration: 220.ms),
      data: (c) {
        if (c == null) return const SizedBox.shrink();
        return _IndustrialHeader(
          title: c.title,
          subtitle:
              '${c.type.name.toUpperCase()} • ${AppDateUtils.formatDate(c.createdAt)}',
        ).animate().fadeIn(duration: 220.ms);
      },
    );
  }

  Widget _buildFooter(AsyncValue<ChecklistModel?> checklist) {
    return checklist.when(
      loading: () => const SizedBox(height: 54),
      error: (_, __) => const SizedBox(height: 54),
      data: (c) {
        if (c == null) return const SizedBox.shrink();
        if (c.isFinished) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Text(
                'Checklist finalizado',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }

        return Consumer(
          builder: (context, ref, _) {
            final controller = ref
                .read(checklistControllerProvider(widget.checklistId).notifier);

            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.finish(widget.checklistId);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Checklist finalizado com sucesso!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('FINALIZAR CHECKLIST'),
              ),
            );
          },
        );
      },
    );
  }
}

class _IndustrialHeaderSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Divider(height: 1, color: AppColors.border),
          SizedBox(height: 8),
          SizedBox(height: 8),
          Divider(height: 1, color: AppColors.border),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _IndustrialHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _IndustrialHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 1.2,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistBody extends ConsumerWidget {
  final int checklistId;
  final Map<int, ChecklistAnswerModel> answers;
  final ScrollController scrollController;
  final bool disabled;

  const _ChecklistBody({
    required this.checklistId,
    required this.answers,
    required this.scrollController,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(checklistRepositoryProvider);

    return StreamBuilder<List<ChecklistQuestionModel>>(
      stream: repo.watchQuestionsByChecklistId(checklistId),
      builder: (context, snapshot) {
        final questions = snapshot.data ?? const <ChecklistQuestionModel>[];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro ao carregar perguntas\n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted),
            ),
          );
        }

        if (questions.isEmpty) {
          return const Center(
            child: Text(
              'Sem perguntas configuradas para este checklist.',
              style: TextStyle(color: AppColors.textMuted),
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final q = questions[index];
            final existing = answers[q.id];

            return ChecklistQuestionWidget(
              key: ValueKey('q-${q.id}'),
              question: q,
              existingAnswer: existing,
              disabled: disabled,
              onAnswer: (answer) async {
                if (disabled) return;
                final controller =
                    ref.read(checklistControllerProvider(checklistId).notifier);
                await controller.updateAnswer(
                  checklistId: checklistId,
                  question: q,
                  answer: answer,
                );
              },
            ).animate().slideY(
                  duration: 220.ms,
                  begin: 0.05,
                  end: 0,
                );
          },
        );
      },
    );
  }
}
