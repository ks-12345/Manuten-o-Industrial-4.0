import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('DASHBOARD INDUSTRIAL')),
      body: Center(
        child: Text(
          'Dashboard (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
