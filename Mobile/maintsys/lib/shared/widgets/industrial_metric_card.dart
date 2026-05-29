import 'package:flutter/material.dart';

import '../../core/models/industrial_models.dart';
import 'status_colors.dart';

class IndustrialMetricCard extends StatelessWidget {
  const IndustrialMetricCard({required this.metric, super.key});

  final IndustrialMetric metric;

  @override
  Widget build(BuildContext context) {
    final color = StatusColors.machine(metric.status);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    metric.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              metric.value,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              metric.trend,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
