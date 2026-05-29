import 'package:flutter/material.dart';

import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/industrial_card.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({
    required this.title,
    required this.icon,
    required this.message,
    super.key,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: IndustrialCard(
          child: EmptyState(icon: icon, message: message),
        ),
      ),
    );
  }
}
