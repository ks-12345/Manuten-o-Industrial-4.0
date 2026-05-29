import 'package:flutter/material.dart';

import '../../core/enums/maintenance_enums.dart';

class StatusColors {
  const StatusColors._();

  static Color machine(MachineStatus status) => switch (status) {
    MachineStatus.running => const Color(0xFF5CF2A8),
    MachineStatus.attention => const Color(0xFFFFC857),
    MachineStatus.broken => const Color(0xFFFF4D5E),
    MachineStatus.maintenance => const Color(0xFF2AD4FF),
  };

  static Color sync(SyncStatus status) => switch (status) {
    SyncStatus.pending => const Color(0xFFFFC857),
    SyncStatus.syncing => const Color(0xFF2AD4FF),
    SyncStatus.synced => const Color(0xFF5CF2A8),
    SyncStatus.error => const Color(0xFFFF4D5E),
  };

  static Color priority(PriorityLevel priority) => switch (priority) {
    PriorityLevel.low => const Color(0xFF5CF2A8),
    PriorityLevel.medium => const Color(0xFFFFC857),
    PriorityLevel.high => const Color(0xFFFF8A3D),
    PriorityLevel.critical => const Color(0xFFFF4D5E),
  };
}
