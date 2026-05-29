import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/status_enum.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge.machine({
    required MachineOperationalStatus status,
    super.key,
  }) : label = null,
       color = null,
       machineStatus = status,
       syncStatus = null;

  const StatusBadge.sync({required SyncStatus status, super.key})
    : label = null,
      color = null,
      machineStatus = null,
      syncStatus = status;

  const StatusBadge.custom({
    required this.label,
    required this.color,
    super.key,
  }) : machineStatus = null,
       syncStatus = null;

  final String? label;
  final Color? color;
  final MachineOperationalStatus? machineStatus;
  final SyncStatus? syncStatus;

  @override
  Widget build(BuildContext context) {
    final resolvedLabel =
        label ?? machineStatus?.label ?? syncStatus?.label ?? 'Status';
    final resolvedColor =
        color ??
        (machineStatus != null
            ? _machineColor(machineStatus!)
            : _syncColor(syncStatus ?? SyncStatus.pending));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: resolvedColor.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: resolvedColor.withValues(alpha: 0.42)),
      ),
      child: Text(
        resolvedLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: resolvedColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Color _machineColor(MachineOperationalStatus status) => switch (status) {
    MachineOperationalStatus.operating => AppColors.success,
    MachineOperationalStatus.attention => AppColors.warning,
    MachineOperationalStatus.stopped => AppColors.error,
    MachineOperationalStatus.maintenance => AppColors.maintenance,
  };

  Color _syncColor(SyncStatus status) => switch (status) {
    SyncStatus.pending => AppColors.warning,
    SyncStatus.syncing => AppColors.primary,
    SyncStatus.synced => AppColors.success,
    SyncStatus.error => AppColors.error,
  };
}
