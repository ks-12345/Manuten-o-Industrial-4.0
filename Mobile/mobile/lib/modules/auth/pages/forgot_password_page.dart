import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('RECUPERAR SENHA'),
      ),
      body: const Center(
        child: Text('Tela de recuperação (placeholder).'),
      ),
    );
  }
}
