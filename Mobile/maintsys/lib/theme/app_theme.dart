import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const _surface = Color(0xFF101820);
  static const _surfaceHigh = Color(0xFF16222B);
  static const _primary = Color(0xFF2AD4FF);
  static const _secondary = Color(0xFF5CF2A8);
  static const _danger = Color(0xFFFF4D5E);

  static ThemeData darkIndustrial() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
      primary: _primary,
      secondary: _secondary,
      error: _danger,
      surface: _surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: _surface,
      cardTheme: CardThemeData(
        color: _surfaceHigh,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _surface,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _surfaceHigh,
        indicatorColor: _primary.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
