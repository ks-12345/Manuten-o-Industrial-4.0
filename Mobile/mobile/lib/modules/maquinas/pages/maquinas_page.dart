import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MaquinasPage extends StatelessWidget {
  const MaquinasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('MÁQUINAS')),
      body: Center(
        child: Text(
          'Lista de máquinas (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
