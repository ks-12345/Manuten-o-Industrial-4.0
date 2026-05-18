import 'package:flutter/material.dart';
import '../models/checklist_model.dart';
import '../../../core/theme/app_colors.dart';

class ChecklistQuestionWidget extends StatefulWidget {
  final ChecklistQuestionModel question;
  final ChecklistAnswerModel? existingAnswer;
  final void Function(ChecklistAnswerModel answer) onAnswer;
  final bool disabled;

  const ChecklistQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswer,
    this.existingAnswer,
    this.disabled = false,
  });

  @override
  State<ChecklistQuestionWidget> createState() =>
      _ChecklistQuestionWidgetState();
}

class _ChecklistQuestionWidgetState extends State<ChecklistQuestionWidget> {
  bool? _boolAnswer;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
              child: Text(widget.question.question,
                  style: const TextStyle(fontSize: 12))),
          _buildTypeBadge(),
        ]),
        const SizedBox(height: 10),
        _buildAnswerWidget(),
      ]),
    );
  }

  Widget _buildTypeBadge() {
    final labels = {
      QuestionType.yesNo: 'SIM/NÃO',
      QuestionType.okProblem: 'OK/PROBLEMA',
      QuestionType.text: 'TEXTO',
      QuestionType.observation: 'OBS.',
      QuestionType.photo: 'FOTO',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        labels[widget.question.type] ?? '',
        style: const TextStyle(
            fontSize: 8, letterSpacing: 0.5, color: AppColors.textMuted),
      ),
    );
  }

  Widget _buildAnswerWidget() {
    switch (widget.question.type) {
      case QuestionType.yesNo:
        return _BoolAnswerRow(
          yesLabel: 'SIM',
          noLabel: 'NÃO',
          value: _boolAnswer,
          onChanged: _onBoolChanged,
        );
      case QuestionType.okProblem:
        return _BoolAnswerRow(
          yesLabel: 'OK',
          noLabel: 'PROBLEMA',
          yesColor: AppColors.success,
          noColor: AppColors.danger,
          value: _boolAnswer,
          onChanged: _onBoolChanged,
        );
      case QuestionType.text:
      case QuestionType.observation:
        return TextField(
          controller: _textController,
          style: const TextStyle(fontSize: 12),
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Digite sua observação...',
            hintStyle: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          onChanged: (v) => widget.onAnswer(
            ChecklistAnswerModel()
              ..questionId = widget.question.id
              ..checklistId = widget.existingAnswer?.checklistId ??
                  widget.question.checklistId
              ..textAnswer = v,
          ),
        );
      case QuestionType.photo:
        return OutlinedButton.icon(
          onPressed: () {/* integrar camera */},
          icon: const Icon(Icons.camera_alt_outlined, size: 16),
          label: const Text('FOTOGRAFAR',
              style: TextStyle(fontSize: 10, letterSpacing: 1)),
          style: OutlinedButton.styleFrom(foregroundColor: AppColors.info),
        );
    }
  }

  void _onBoolChanged(bool value) {
    if (widget.disabled) return;
    setState(() => _boolAnswer = value);
    widget.onAnswer(
      ChecklistAnswerModel()
        ..questionId = widget.question.id
        ..checklistId =
            widget.existingAnswer?.checklistId ?? widget.question.checklistId
        ..boolAnswer = value,
    );
  }
}

class _BoolAnswerRow extends StatelessWidget {
  final String yesLabel;
  final String noLabel;
  final bool? value;
  final void Function(bool) onChanged;
  final Color yesColor;
  final Color noColor;

  const _BoolAnswerRow({
    required this.yesLabel,
    required this.noLabel,
    required this.value,
    required this.onChanged,
    this.yesColor = AppColors.success,
    this.noColor = AppColors.danger,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _AnswerBtn(
          label: yesLabel,
          selected: value == true,
          color: yesColor,
          onTap: () => onChanged(true)),
      const SizedBox(width: 8),
      _AnswerBtn(
          label: noLabel,
          selected: value == false,
          color: noColor,
          onTap: () => onChanged(false)),
    ]);
  }
}

class _AnswerBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _AnswerBtn(
      {required this.label,
      required this.selected,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: selected ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              color: selected ? color : AppColors.textMuted,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400),
        ),
      ),
    );
  }
}
