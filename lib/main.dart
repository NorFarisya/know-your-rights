
// Imports Flutter's Material package to use app widgets and styling.
import 'package:flutter/material.dart';

// Imports the first onboarding screen to display when the app starts.
import 'screens/onboarding_screen1.dart';

// Main function that starts the Flutter application.
void main() {
  runApp(const KnowYourRightsApp());
}

// Root widget that sets up the application's theme and starting screen.
class KnowYourRightsApp extends StatelessWidget {
  const KnowYourRightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic structure and navigation for the app.
    return MaterialApp(
      // Hides the debug banner from the top-right corner.
      debugShowCheckedModeBanner: false,

      // Sets the name of the application.
      title: 'Know Your Rights',

      // Defines the visual theme used throughout the application.
      theme: ThemeData(
        useMaterial3: true,
      ),

      // Opens the first onboarding screen when the app launches.
      home: const OnboardingScreen1(),
    );
  }
}