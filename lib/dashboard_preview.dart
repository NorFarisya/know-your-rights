
import 'package:flutter/material.dart';

// Import the Dashboard screen that will be displayed
// when running this temporary preview application.
import 'screens/dashboard_screen.dart';

// ======================================================
// KNOW UR RIGHTS - DASHBOARD PREVIEW
// ======================================================
// This file provides a temporary entry point for
// previewing Farisya's Dashboard independently.
// It allows the Dashboard to be tested and displayed
// without modifying the group's original main.dart.
// This is useful during individual UI development before integrating all group members' screens.

// ------------------------------------------------------
// 1. APPLICATION ENTRY POINT
// ------------------------------------------------------
// The main() function is the starting point of a Flutter application.
// runApp() launches the DashboardPreviewApp widget
// and displays its interface on the device.
void main() {
  runApp(const DashboardPreviewApp());
}

// ======================================================
// DASHBOARD PREVIEW APPLICATION
// ======================================================
// StatelessWidget is used because this preview
// application does not manage its own changing data.
// It provides the MaterialApp configuration and identifies DashboardScreen as the starting screen.
class DashboardPreviewApp extends StatelessWidget {
  const DashboardPreviewApp({super.key});

  // ----------------------------------------------------
  // 2. BUILD PREVIEW APPLICATION
  // ----------------------------------------------------
  // Builds the temporary Flutter application used to preview the Dashboard interface.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner from the top-right
      // corner of the application during preview.
      debugShowCheckedModeBanner: false,
      // Set the application title.
      title: 'Know Your Rights',
      // Set DashboardScreen as the first screen
      // displayed when the preview application starts.
      home: DashboardScreen(),
    );
  }
}
