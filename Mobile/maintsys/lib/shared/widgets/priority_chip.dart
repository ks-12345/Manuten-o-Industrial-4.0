import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/status_enum.dart';

class PriorityChip extends StatefulWidget {
  const PriorityChip({required this.priority, super.key});

  final OccurrencePriority priority;

  @override
  State<PriorityChip> createState() => _PriorityChipState();
}

class _PriorityChipState extends State<PriorityChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.65,
      upperBound: 1,
    );
    if (widget.priority == OccurrencePriority.critical) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant PriorityChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.priority == OccurrencePriority.critical &&
        !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (widget.priority != OccurrencePriority.critical) {
      _controller.stop();
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(widget.priority);
    return FadeTransition(
      opacity: widget.priority == OccurrencePriority.critical
          ? _controller
          : const AlwaysStoppedAnimation(1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color.withValues(alpha: 0.46)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.priority_high, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              widget.priority.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _color(OccurrencePriority priority) => switch (priority) {
    OccurrencePriority.low => AppColors.lowPriority,
    OccurrencePriority.medium => AppColors.warning,
    OccurrencePriority.high => AppColors.highPriority,
    OccurrencePriority.critical => AppColors.error,
  };
}
