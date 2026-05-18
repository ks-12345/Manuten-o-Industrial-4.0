import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MachineDetailPage extends StatelessWidget {
  final int machineId;

  const MachineDetailPage({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('DETALHE DA MÁQUINA')),
      body: Center(
        child: Text(
          'Detalhes da máquina #$machineId (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
