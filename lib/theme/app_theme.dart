import 'package:flutter/material.dart';

class AppTheme {
  // Light palette - soft pastel purple
  static const Color primary = Color(0xFF7C6FCD);
  static const Color secondary = Color(0xFFA78BFA);
  static const Color accent = Color(0xFFC4B5FD);
  static const Color backgroundLight = Color(0xFFF8F7FF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textDarkLight = Color(0xFF2D2B55);
  static const Color textLightLight = Color(0xFF8B8BAE);

  // Aliases untuk backward compatibility
static const Color background = backgroundLight;
static const Color surface = surfaceLight;
static const Color textDark = textDarkLight;
static const Color textLight = textLightLight;

  // Stat card colors - pastel
  static const Color stat1 = Color(0xFFEDE9FE);
  static const Color stat1Text = Color(0xFF7C3AED);
  static const Color stat2 = Color(0xFFE0F2FE);
  static const Color stat2Text = Color(0xFF0284C7);
  static const Color stat3 = Color(0xFFFEF3C7);
  static const Color stat3Text = Color(0xFFD97706);

  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surfaceLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: surfaceLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: Color(0xFF16213E),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF16213E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF16213E),
    ),
  );
}