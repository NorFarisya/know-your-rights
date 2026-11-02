import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - NOTE ACTION BUTTON
// ======================================================
// This reusable widget creates a circular action button used in the My Notes screen.
// It allows users to start creating a new personal note by tapping the plus icon.
// StatelessWidget is used because the button does not manage its own changing data.
class NoteActionButton extends StatelessWidget {
  // ----------------------------------------------------
  // 1. BUTTON CALLBACK
  // ----------------------------------------------------
  // Stores the function that executes when the user presses the Create Note button.
  // The parent MyNotesScreen provides this callback to open the Create Note form.
  final VoidCallback onPressed;

  // ----------------------------------------------------
  // 2. BUTTON CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a NoteActionButton and requires an onPressed callback to handle user interaction.
  const NoteActionButton({
    super.key,
    required this.onPressed,
  });

  // ----------------------------------------------------
  // 3. BUILD CREATE NOTE BUTTON
  // ----------------------------------------------------
  // Builds the circular blue action button displayed in the My Notes screen.
  @override
  Widget build(BuildContext context) {
    // Material provides the background surface
    // and circular shape for the action button.
    return Material(
      // Use the shared blue colour from AppColors.
      color: AppColors.blue,
      // CircleBorder creates the circular button shape.
      shape: const CircleBorder(),
      // IconButton provides a clickable button
      // with built-in interaction and accessibility.
      child: IconButton(
        // Tooltip provides a description when
        // users interact with or hover over the button.
        tooltip: 'Create Note',
        // Execute the callback provided by MyNotesScreen.
        onPressed: onPressed,
        // Display the plus icon to indicate
        // that users can create a new note.
        icon: const Icon(
          Icons.add,
          size: 32,
          color: AppColors.navy,
        ),
      ),
    );
  }
}
