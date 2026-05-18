import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class NovaOcorrenciaPage extends StatelessWidget {
  const NovaOcorrenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('NOVA OCORRÊNCIA')),
      body: Center(
        child: Text(
          'Criar nova ocorrência (placeholder).',
          style: TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
