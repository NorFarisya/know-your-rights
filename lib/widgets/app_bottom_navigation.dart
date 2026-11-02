import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - BOTTOM NAVIGATION
// ======================================================
// This reusable widget creates the bottom navigation
// bar used throughout the Know Ur Rights application.
// It provides three main navigation destinations: Home, Explore and Notes.
// StatelessWidget is used because the navigation widget receives its selected index and tap actions
// from the parent screen.
class AppBottomNavigation extends StatelessWidget {

  // ----------------------------------------------------
  // 1. NAVIGATION PARAMETERS
  // ----------------------------------------------------
  // Stores the index of the currently selected tab.
  // 0 = Home
  // 1 = Explore
  // 2 = Notes
  final int currentIndex;

  // Receives the selected navigation index when the user taps one of the navigation items.
  // The parent screen decides which action to perform based on the selected index.
  final ValueChanged<int> onTap;

  // ----------------------------------------------------
  // 2. NAVIGATION CONSTRUCTOR
  // ----------------------------------------------------
  // Creates the reusable bottom navigation widget.
  // Both currentIndex and onTap are required so the parent screen can control the navigation.
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // ----------------------------------------------------
  // 3. BUILD BOTTOM NAVIGATION BAR
  // ----------------------------------------------------
  // Builds the bottom navigation bar containing Home, Explore and Notes destinations.
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Identifies which navigation item is currently
      // selected based on the value from the parent screen.
      currentIndex: currentIndex,

      // Calls the parent screen's callback whenever
      // the user selects a navigation destination.
      onTap: onTap,

      // Use blue to highlight the selected navigation item.
      selectedItemColor: const Color(0xFF2468E8),

      // Use navy for navigation items that are not selected.
      unselectedItemColor: AppColors.navy,

      // Set the navigation bar background to white.
      backgroundColor: AppColors.white,

      // Fixed navigation keeps all three items visible
      // with consistent spacing across the bottom bar.
      type: BottomNavigationBarType.fixed,

      // ------------------------------------------------
      // 4. NAVIGATION DESTINATIONS
      // ------------------------------------------------
      // Define the three available navigation items.
      items: const [
        // --------------------------------------------
        // HOME NAVIGATION
        // --------------------------------------------
        // Represents the main Dashboard screen.
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),

          // Display a filled home icon when selected.
          activeIcon: Icon(Icons.home),

          label: 'Home',
        ),

        // --------------------------------------------
        // EXPLORE NAVIGATION
        // --------------------------------------------
        // Represents the Explore Rights screen.
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),

        // --------------------------------------------
        // NOTES NAVIGATION
        // --------------------------------------------
        // Represents the My Notes screen.
        BottomNavigationBarItem(
          icon: Icon(Icons.description_outlined),
          label: 'Notes',
        ),
      ],
    );
  }
}
