import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/status_enum.dart';

class SyncIndicator extends StatefulWidget {
  const SyncIndicator({required this.status, super.key});

  final SyncStatus status;

  @override
  State<SyncIndicator> createState() => _SyncIndicatorState();
}

class _SyncIndicatorState extends State<SyncIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.status == SyncStatus.syncing) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant SyncIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == SyncStatus.syncing && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.status != SyncStatus.syncing) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(widget.status);
    final icon = switch (widget.status) {
      SyncStatus.pending => Icons.cloud_queue,
      SyncStatus.syncing => Icons.sync,
      SyncStatus.synced => Icons.cloud_done,
      SyncStatus.error => Icons.cloud_off,
    };

    return Tooltip(
      message: widget.status.label,
      child: RotationTransition(
        turns: widget.status == SyncStatus.syncing
            ? _controller
            : const AlwaysStoppedAnimation(0),
        child: Icon(icon, color: color),
      ),
    );
  }

  Color _color(SyncStatus status) => switch (status) {
    SyncStatus.pending => AppColors.warning,
    SyncStatus.syncing => AppColors.primary,
    SyncStatus.synced => AppColors.success,
    SyncStatus.error => AppColors.error,
  };
}
