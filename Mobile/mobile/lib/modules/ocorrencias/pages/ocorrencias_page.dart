import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OcorrenciasPage extends StatelessWidget {
  const OcorrenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('OCORRÊNCIAS')),
      body: Center(
        child: Text(
          'Lista de ocorrências (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
