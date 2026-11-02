
import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';


// ======================================================
// KNOW UR RIGHTS - NOTE EDIT BUTTON
// ======================================================
// This reusable widget creates an edit button used
// inside individual NoteCard widgets.
// It allows users to open the Edit Note screen
// by tapping the pencil icon.
// StatelessWidget is used because the button does
// not manage its own changing data.
class NoteEditButton extends StatelessWidget {

  // ----------------------------------------------------
  // 1. BUTTON CALLBACK
  // ----------------------------------------------------
  // Stores the function that should execute when
  // the user taps the edit button.
  // The parent NoteCard provides this callback
  // to open the Edit Note form.
  final VoidCallback onPressed;

  // ----------------------------------------------------
  // 2. BUTTON CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a NoteEditButton and requires an onPressed callback for user interaction.
  const NoteEditButton({
    super.key,
    required this.onPressed,
  });

  // ----------------------------------------------------
  // 3. BUILD EDIT BUTTON INTERFACE
  // ----------------------------------------------------
  // Builds the reusable pencil edit button displayed inside each note card.
  @override
  Widget build(BuildContext context) {

    // Material provides the visual surface required
    // for the InkWell touch and ripple interaction.
    // Transparent background allows the button's
    // custom decoration to remain visible.
    return Material(
      color: Colors.transparent,

      // InkWell detects when the user taps the button.
      child: InkWell(

        // Execute the callback provided by NoteCard.
        onTap: onPressed,

        // Apply rounded corners to the touch area.
        borderRadius: BorderRadius.circular(14),

        // Ink displays the custom background and
        // padding while supporting InkWell's ripple effect.
        child: Ink(
          padding: const EdgeInsets.all(9),

          // BoxDecoration controls the button's
          // background colour, border and shape.
          decoration: BoxDecoration(

            // Use the shared soft beige colour
            // for the edit button background.
            color: AppColors.employment,

            // Apply rounded corners to match
            // the group's Canva design.
            borderRadius: BorderRadius.circular(14),

            // Add a subtle border around the button.
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),

          // Display the pencil icon to indicate
          // that the user can edit the selected note.
          child: const Icon(
            Icons.edit_outlined,
            size: 18,
            color: AppColors.brown,
          ),
        ),
      ),
    );
  }
}
