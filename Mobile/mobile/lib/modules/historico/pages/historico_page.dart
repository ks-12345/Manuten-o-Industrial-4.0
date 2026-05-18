import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('HISTÓRICO TÉCNICO')),
      body: Center(
        child: Text(
          'Histórico técnico (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
