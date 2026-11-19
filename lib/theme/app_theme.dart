
import 'package:flutter/material.dart';

// Shared colours and styling for the app is all here, we just reuse
class AppTheme {

  // Official Canva colour palette.
  static const Color beaver = Color(0xFF90725D);
  static const Color starkWhite = Color(0xFFEBDBCB);
  static const Color ebonyClay = Color(0xFF2F3547);
  static const Color botticelli = Color(0xFFCED9E4);
  static const Color malibu = Color(0xFF95C2F9);

  // Neutral white for cards and readable backgrounds.
  static const Color cardWhite = Color(0xFFFFFFFF);

  // Shared application theme.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: beaver,
        primary: beaver,
        secondary: malibu,
        surface: cardWhite,
      ),

      scaffoldBackgroundColor:
          const Color(0xFFFAF7F4),

      appBarTheme: const AppBarTheme(
        backgroundColor: beaver,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: ebonyClay,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: ebonyClay,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: ebonyClay,
          fontSize: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: beaver,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
