
import 'package:flutter/material.dart';

// ======================================================
// KNOW UR RIGHTS - RIGHTS CATEGORY CARD
// ======================================================
// This reusable widget displays an individual rights
// category card on the Know Ur Rights Dashboard.
// It provides users with access to different rights
// categories such as Employment, Consumer, Digital
// and Housing.
// StatelessWidget is used because the card receives
// its information and interaction callback from
// the parent DashboardScreen.
class RightsCategoryCard extends StatelessWidget {

  // ----------------------------------------------------
  // 1. CATEGORY INFORMATION AND PARAMETERS
  // ----------------------------------------------------
  // Stores the name of the rights category.
  final String title;

  // Stores a short description of the category.
  final String subtitle;

  // Stores the icon displayed inside the category card.
  final IconData icon;

  // Defines the background colour of the category card.
  // The colour is provided by DashboardScreen so that
  // each rights category can have its own background.
  final Color backgroundColor;

  // Stores the function executed when the user taps the category card.
  // The parent DashboardScreen decides which screen
  // should open after the card is selected.
  final VoidCallback onTap;

  // ----------------------------------------------------
  // 2. CATEGORY CARD CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a RightsCategoryCard using the category
  // information and callback provided by the Dashboard.
  // All parameters are required to ensure that
  // each category card has complete information.
  const RightsCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  // ----------------------------------------------------
  // 3. BUILD CATEGORY CARD INTERFACE
  // ----------------------------------------------------
  // Builds the reusable rights category card
  // displayed on the Dashboard.
  @override
  Widget build(BuildContext context) {

    // Material provides the visual surface and
    // rounded background for the category card.
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),

      // ------------------------------------------------
      // 4. CARD TAP INTERACTION
      // ------------------------------------------------
      // InkWell makes the entire category card clickable.
      // It also provides visual ripple feedback
      // when the user taps the card.
      child: InkWell(
        onTap: onTap,

        // Match the touch interaction corners
        // with the rounded card design.
        borderRadius: BorderRadius.circular(20),

        // Container controls the card's height
        // and internal spacing.
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(12),

          // Column arranges the category icon,
          // title, subtitle and arrow vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------
              // 5. CATEGORY ICON
              // ----------------------------------------
              // Display the icon representing the
              // selected rights category.
              Icon(
                icon,
                size: 23,
              ),

              // Spacer pushes the category title
              // and description towards the bottom
              // of the available card space.
              const Spacer(),

              // ----------------------------------------
              // 6. CATEGORY TITLE
              // ----------------------------------------
              // Display the main category name.
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ----------------------------------------
              // 7. CATEGORY DESCRIPTION
              // ----------------------------------------
              // Display a short explanation of
              // the selected rights category.
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),

              // ----------------------------------------
              // 8. NAVIGATION INDICATOR
              // ----------------------------------------
              // Display an outward arrow at the
              // bottom-right corner of the card.
              // This visually indicates that users
              // can select the card to explore more.
              const Align(
                alignment: Alignment.bottomRight,

                child: Icon(
                  Icons.arrow_outward,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
