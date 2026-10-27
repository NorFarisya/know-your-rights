
import 'package:flutter/material.dart';

// Import our shared application theme.
import 'theme/app_theme.dart';

// Import the Explore Rights screen.
import 'screens/explore_rights_screen.dart';

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

      // Removes the red DEBUG banner.
      debugShowCheckedModeBanner: false,

      // Applies our shared Canva colour palette and theme.
      theme: AppTheme.lightTheme,

      // TEMPORARY:
      // Open Explore Rights directly for UI testing.
      // Later this will be replaced by the group's
      // onboarding, login and dashboard navigation.
      home: const ExploreRightsScreen(),
    );
  }
}
