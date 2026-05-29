import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IndustrialLoadingWidget extends StatelessWidget {
  const IndustrialLoadingWidget({super.key, this.label = 'Carregando'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 180,
          child: LinearProgressIndicator(
            minHeight: 3,
            color: AppColors.primary,
            backgroundColor: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
          ),
        ),
      ],
    );
  }
}
