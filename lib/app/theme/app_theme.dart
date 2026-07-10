import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _ink = Color(0xFF343A32);
  static const _sage = Color(0xFF7A8B73);
  static const _paper = Color(0xFFF7F1E7);
  static const _gold = Color(0xFFB4945A);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: _sage,
      brightness: Brightness.light,
      surface: _paper,
    ).copyWith(
      primary: _sage,
      secondary: _gold,
      onSurface: _ink,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _paper,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: _paper,
        foregroundColor: _ink,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white.withValues(alpha: 0.72),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
