import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class IndustrialCard extends StatelessWidget {
  final Widget child;
  final Color? accentColor;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const IndustrialCard({
    super.key,
    required this.child,
    this.accentColor,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: accentColor ?? AppColors.border, width: accentColor != null ? 2 : 0.5),
            left: const BorderSide(color: AppColors.border, width: 0.5),
            right: const BorderSide(color: AppColors.border, width: 0.5),
            bottom: const BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: child,
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.05, end: 0, duration: 250.ms);
  }
}

/// Card de KPI para o Dashboard
class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color accentColor;
  final IconData icon;

  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IndustrialCard(
      accentColor: accentColor,
      child: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label.toUpperCase(), style: const TextStyle(fontSize: 9, letterSpacing: 1.5, color: AppColors.textMuted)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: accentColor, height: 1)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ]),
        Positioned(
          right: 0,
          top: 0,
          child: Icon(icon, size: 32, color: accentColor.withOpacity(0.12)),
        ),
      ]),
    );
  }
}