import 'package:flutter/material.dart';

class AppTheme {
  // ПАЛИТРА ПО РЕФЕРЕНСУ И ТЗ:
  // • #FF7012 — основной оранжевый: кнопки, активные вкладки, индикаторы прогресса.
  // • #292929 — графитовый: нижняя навигация, тёмные карточки.
  // • #101020 — основной фон.
  // • #191940 — фон информационных карточек.
  // • #25256A — дополнительные акцентные поверхности.
  // • #3434DD — сине-фиолетовый: декоративные линии и отдельные элементы.
  // • #FFFFFF — заголовки и основной текст.
  // • #B9B9CC — второстепенные подписи.
  // • #323249 — разделители и контуры.
  // На оранжевых кнопках использовать текст #101020.

  static const Color primary = Color(0xFFFF7012);
  static const Color navBackground = Color(0xFF292929);
  static const Color background = Color(0xFF101020);
  static const Color cardBackground = Color(0xFF191940);
  static const Color surfaceAccent = Color(0xFF25256A);
  static const Color secondaryLine = Color(0xFF3434DD);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB9B9CC);
  static const Color border = Color(0xFF323249);
  static const Color onPrimary = Color(0xFF101020);

  // Совместимость для существующих сервисов
  static const Color surface = navBackground;
  static const Color surfaceCard = cardBackground;
  static const Color surfaceElevated = surfaceAccent;
  static const Color surfaceBorder = border;
  static const Color textMuted = textSecondary;
  static const Color accentGold = primary;
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentRose = Color(0xFFEF4444);

  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double screenPadding = 16.0;
  static const double buttonHeight = 48.0;

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withAlpha(80),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get orangeGlow => [
        BoxShadow(
          color: primary.withAlpha(60),
          blurRadius: 18,
          spreadRadius: 2,
        ),
      ];

  static List<BoxShadow> get neonGlow => orangeGlow;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondaryLine,
        surface: cardBackground,
        error: accentRose,
        onPrimary: onPrimary,
        onSurface: textPrimary,
      ),
      fontFamily: null, // Системный шрифт
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size(0, buttonHeight),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          elevation: 0,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        iconTheme: IconThemeData(color: primary),
      ),
    );
  }
}
