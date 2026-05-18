import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('MAPA INDUSTRIAL')),
      body: Center(
        child: const Text(
          'Mapa industrial (placeholder).\nEstrutura de setores/side panel será implementada nas próximas etapas.',
          style: TextStyle(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
