import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoidTheme {
  static const Color voidBlack = Color(0xFF050505);
  static const Color darkGray = Color(0xFF121212);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color dimCyan = Color(0xFF004D40);
  static const Color errorRed = Color(0xFFFF0033);
  static const Color warningOrange = Color(0xFFFFAB00);
  static const Color signalGreen = Color(0xFF00FF41);
  static const Color purpleHaze = Color(0xFF6200EA);
  static const Color terminalGreen = Color(0xFF33FF00); // Classic CRT

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: voidBlack,
      primaryColor: neonCyan,
      colorScheme: const ColorScheme.dark(
        primary: neonCyan,
        secondary: purpleHaze,
        surface: darkGray,
        error: errorRed,
        onPrimary: voidBlack,
        onSecondary: Colors.white,
        onSurface: neonCyan,
        onError: voidBlack,
      ),
      fontFamily: GoogleFonts.shareTechMono().fontFamily,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.shareTechMono(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: neonCyan,
          shadows: [
            Shadow(color: neonCyan.withValues(alpha: 0.8), blurRadius: 8),
          ],
        ),
        displayMedium: GoogleFonts.shareTechMono(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.shareTechMono(
          fontSize: 16,
          color: neonCyan.withValues(alpha: 0.9),
        ),
        bodyMedium: GoogleFonts.shareTechMono(
          fontSize: 14,
          color: neonCyan.withValues(alpha: 0.7),
        ),
      ),
      iconTheme: const IconThemeData(color: neonCyan),
      appBarTheme: AppBarTheme(
        backgroundColor: voidBlack,
        elevation: 0,
        titleTextStyle: GoogleFonts.shareTechMono(
          fontSize: 20,
          color: neonCyan,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: neonCyan),
      ),
      cardTheme: CardThemeData(
        color: darkGray.withValues(alpha: 0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: neonCyan.withValues(alpha: 0.3), width: 1),
        ),
      ),
    );
  }
}
