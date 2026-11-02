import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - PLACEHOLDER SCREEN
// ======================================================
// This screen acts as a temporary page for application
// features that have not yet been integrated.
// It allows users to navigate through unfinished
// sections while the group develops the actual screens.
// The optional category parameter allows the Dashboard
// to identify which rights category the user selected.
// StatelessWidget is used because this screen only
// displays information received through its parameters.
class PlaceholderScreen extends StatelessWidget {

  // ----------------------------------------------------
  // 1. SCREEN INFORMATION
  // ----------------------------------------------------
  // Stores the title displayed in the AppBar
  // and the placeholder message.
  final String title;

  // Stores the selected rights category.
  //
  // This parameter is optional because some placeholder
  // screens, such as Profile, do not require a category.
  final String? category;

  // ----------------------------------------------------
  // 2. PLACEHOLDER SCREEN CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a PlaceholderScreen with a required title
  // and an optional rights category.
  const PlaceholderScreen({
    super.key,
    required this.title,
    this.category,
  });

  // ----------------------------------------------------
  // 3. BUILD PLACEHOLDER SCREEN
  // ----------------------------------------------------
  // Builds the temporary interface displayed
  // when users open an unfinished application feature.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Apply the shared application background colour.
      backgroundColor: AppColors.background,

      // ------------------------------------------------
      // 4. APPLICATION BAR
      // ------------------------------------------------
      // AppBar displays the title of the selected
      // placeholder screen at the top of the page.
      appBar: AppBar(

        title: Text(title),

        // Use the shared brown colour for the AppBar.
        backgroundColor: AppColors.brown,

        // Use white for the AppBar title and icons.
        foregroundColor: AppColors.white,
      ),

      // ------------------------------------------------
      // 5. PLACEHOLDER SCREEN CONTENT
      // ------------------------------------------------

      // Center positions the placeholder content
      // in the middle of the available screen area.
      body: Center(

        // Column arranges the icon, message
        // and Back button vertically.
        child: Column(
          // Keep the content grouped around
          // the centre of the screen.
          mainAxisSize: MainAxisSize.min,
          children: [

            // ----------------------------------------
            // 6. PLACEHOLDER ICON
            // ----------------------------------------
            // Display a construction icon to indicate
            // that the selected feature is still
            // under development.
            const Icon(
              Icons.construction_outlined,
              size: 64,
              color: AppColors.brown,
            ),

            const SizedBox(height: 20),

            // ----------------------------------------
            // 7. PLACEHOLDER MESSAGE
            // ---------------------------------------
            // Display different messages depending
            // on whether a rights category was selected.
            // If category is null, display a general
            // Coming Soon message.
            // Otherwise, display the selected
            // Explore Rights category.
            Text(
              category == null
                  ? '$title - Coming Soon'
                  : 'Explore Rights: $category',

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // ----------------------------------------
            // 8. ADDITIONAL INFORMATION
            // ----------------------------------------
            // Inform users that the selected page
            // will be connected during later development.
            const Text(
              'This page will be connected later.',
            ),

            const SizedBox(height: 20),

            // ----------------------------------------
            // 9. BACK BUTTON
            // ----------------------------------------
            // ElevatedButton allows users to return
            // to the previous screen.
            ElevatedButton(
              // Navigator.pop removes the current
              // placeholder screen from the navigation stack.
              onPressed: () => Navigator.pop(context),
              // Display the Back button label.
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
