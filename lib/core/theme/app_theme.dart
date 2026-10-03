import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _steel = Color(0xFF087F7B);
  static const _steelLight = Color(0xFF74C7BE);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(seedColor: _steel);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF5F7F7),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF5F7F7),
        foregroundColor: Color(0xFF17212B),
      ),
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: _steelLight,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF17212B),
    );
  }
}
