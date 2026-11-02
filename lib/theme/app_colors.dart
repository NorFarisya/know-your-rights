
import 'package:flutter/material.dart';

// ======================================================
// KNOW UR RIGHTS - APP COLOURS AND THEME
// ======================================================
// This class stores all the colours used throughout the Know Ur Rights application.
// Keeping colours in one file helps maintain a consistent design and makes it easier to update the colour palette.
class AppColors {
  // ----------------------------------------------------
  // 1. MAIN BRAND COLOURS
  // ----------------------------------------------------
  // Primary brown colour used for headers and main buttons.
  static const Color brown = Color(0xFF90725D);

  // Soft cream colour used for secondary backgrounds.
  static const Color cream = Color(0xFFEBDBCB);

  // Dark navy colour used for headings and body text.
  static const Color navy = Color(0xFF2F3547);

  // Light blue-grey colour used for information cards.
  static const Color blueGrey = Color(0xFFCED9E4);

  // Soft blue colour used for buttons and highlights.
  static const Color blue = Color(0xFF95C2F9);

  // ----------------------------------------------------
  // 2. GENERAL APPLICATION COLOURS
  // ----------------------------------------------------
  // Main background colour for application screens.
  static const Color background = Color(0xFFFAF6F2);

  // White colour used for cards and form fields.
  static const Color white = Colors.white;

  // Border colour used to separate UI components.
  static const Color border = Color(0xFFE6D7CA);

  // ----------------------------------------------------
  // 3. RIGHTS CATEGORY COLOURS
  // ----------------------------------------------------
  // Employment category background.
  static const Color employment = Color(0xFFF4E8DC);

  // Consumer category background.
  static const Color consumer = Color(0xFFE3F0E6);

  // Digital category background.
  static const Color digital = Color(0xFFD7E9FF);

  // Housing category background.
  static const Color housing = Color(0xFFE8E0F8);

  // ----------------------------------------------------
  // 4. CONNECTIVITY STATUS COLOURS
  // ----------------------------------------------------
  // Green indicates that a network connection is detected.
  static const Color online = Color(0xFF387455);

  // Warm brown indicates that no network is detected.
  static const Color offline = Color(0xFFA45B46);

}

// ======================================================
// APPLICATION THEME
// ======================================================
// This class defines the shared ThemeData for the app.
// ThemeData allows common styling such as colours, buttons, input fields and application backgrounds
// to be managed from one central location.
class AppTheme {
  // ----------------------------------------------------
  // 5. MAIN LIGHT THEME
  // ----------------------------------------------------
  // This theme is applied to the MaterialApp so that all screens can share the same basic appearance.
  static ThemeData get lightTheme {
    return ThemeData(

      // Enables Material Design 3 components.
      useMaterial3: true,

      // Sets the primary application colour scheme.
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brown,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.brown,
        secondary: AppColors.blue,
        surface: AppColors.background,
      ),

      // Sets the default background colour of screens.
      scaffoldBackgroundColor: AppColors.background,

      // Defines the appearance of application bars.
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.brown,
        foregroundColor: AppColors.white,
        centerTitle: false,
        elevation: 0,
      ),

      // Defines the default text colour and typography.
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.navy,
        ),
        bodyMedium: TextStyle(
          color: AppColors.navy,
        ),
        titleLarge: TextStyle(
          color: AppColors.navy,
          fontWeight: FontWeight.bold,
        ),
      ),

    );
  }
}
