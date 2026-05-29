import 'package:flutter/material.dart';

import 'industrial_loading_widget.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.isLoading,
    required this.child,
    super.key,
    this.label = 'Processando',
  });

  final bool isLoading;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.52),
              child: Center(child: IndustrialLoadingWidget(label: label)),
            ),
          ),
      ],
    );
  }
}
