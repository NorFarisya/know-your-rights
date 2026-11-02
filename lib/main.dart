
import 'package:flutter/material.dart';

// Import the shared application theme created by Sai.
import 'theme/app_theme.dart';

// Import Kirti's onboarding screen.
import 'screens/onboarding_screen1.dart';

// Starting point of the Flutter application.
void main() {
  runApp(const MyApp());
}

// Root widget of the Know Your Rights application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name.
      title: 'Know Your Rights',

      // Remove the debug banner.
      debugShowCheckedModeBanner: false,

      // Apply Sai's shared application theme.
      theme: AppTheme.lightTheme,

      // Start the application with Kirti's onboarding.
      home: const OnboardingScreen1(),
    );
  }
}
