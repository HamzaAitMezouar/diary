import 'package:flutter/material.dart';

class AppThemes {
  // Light theme colors
  static const Color primaryLight = Color(0xFF2AE3B1);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color textLight = Color(0xFF212121);
  static const Color accentLight = Color(0xFF26C6DA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFBDBDBD);
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color warningLight = Color(0xFFFFA000);

  // Dark theme colors
  static const Color primaryDark = Color(0xFF2AE3B1);
  static const Color backgroundDark = Color.fromARGB(255, 12, 31, 15);
  static const Color textDark = Color(0xFFF5F5F5);
  static const Color accentDark = Color(0xFF00ACC1);
  static const Color cardDark = Color.fromARGB(255, 0, 10, 8);
  static const Color dividerDark = Color(0xFF616161);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color warningDark = Color(0xFFFFA726);

  // Get theme data based on brightness
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryLight,
      scaffoldBackgroundColor: backgroundLight,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: textLight)),
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: accentLight,
        background: backgroundLight,
        onBackground: textLight,
        surface: cardLight,
        onSurface: textLight,
        error: errorLight,
        onError: Colors.white,
      ),
      dividerColor: dividerLight,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: backgroundDark,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: textDark)),
      colorScheme: const ColorScheme.dark(
          primary: primaryDark,
          secondary: accentDark,
          background: backgroundDark,
          onBackground: textDark,
          surface: cardDark,
          onSurface: textDark,
          error: errorDark,
          onError: cardDark),
      dividerColor: dividerDark,
    );
  }
}
