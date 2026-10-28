
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

// Temporary entry point used only to preview Farisya's Dashboard.
// The group's original main.dart remains unchanged.
void main() {
  runApp(const DashboardPreviewApp());
}

class DashboardPreviewApp extends StatelessWidget {
  const DashboardPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Your Rights',
      home: DashboardScreen(),
    ); //meterialapp
  }
}
