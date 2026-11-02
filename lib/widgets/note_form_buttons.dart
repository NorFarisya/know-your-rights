
import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - NOTE FORM BUTTONS
// ======================================================
// This reusable widget displays the Cancel and
// Save/Update buttons in the Create/Edit Note screen.
// It receives callback functions from the parent form
// to handle button interactions.
// StatelessWidget is used because the buttons do not
// manage their own changing data.
class NoteFormButtons extends StatelessWidget {

  // ----------------------------------------------------
  // 1. BUTTON CALLBACKS AND FORM MODE
  // ----------------------------------------------------
  // Stores the action performed when the user
  // presses the Cancel button.
  final VoidCallback onCancel;

  // Stores the action performed when the user
  // presses the Save or Update button.
  final VoidCallback onSave;

  // Identifies whether the form is creating
  // a new note or editing an existing note.
  //
  // true  = Edit mode.
  // false = Create mode.
  final bool isEditing;

  // ----------------------------------------------------
  // 2. BUTTON CONSTRUCTOR
  // ----------------------------------------------------
  // Creates the reusable form buttons.
  // Both callbacks are required, while isEditing is optional and defaults to false.
  const NoteFormButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.isEditing = false,
  });

  // ----------------------------------------------------
  // 3. BUILD FORM BUTTONS
  // ---------------------------------------------------
  // Builds the Cancel and Save/Update buttons
  // displayed at the bottom of the note form.
  @override
  Widget build(BuildContext context) {
    // Row arranges both buttons horizontally.
    return Row(
      children: [

        // --------------------------------------------
        // 4. CANCEL BUTTON
        // --------------------------------------------
        // Expanded allows the Cancel button to occupy half of the available horizontal space.
        Expanded(
          child: OutlinedButton(

            // Execute the cancel callback provided
            // by the parent Create/Edit Note screen.
            onPressed: onCancel,

            // Configure the appearance of the button.
            style: OutlinedButton.styleFrom(

              // Use the shared brown colour for the text.
              foregroundColor: AppColors.brown,

              // Add a brown outline around the button.
              side: const BorderSide(
                color: AppColors.brown,
              ),

              // Add vertical spacing inside the button.
              padding: const EdgeInsets.symmetric(
                vertical: 17,
              ),

              // Apply rounded corners to match
              // the application's button design.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),

            // Display the Cancel button label.
            child: const Text('Cancel'),
          ),
        ),

        // Add horizontal spacing between the buttons.
        const SizedBox(width: 20),

        // --------------------------------------------
        // 5. SAVE / UPDATE BUTTON
        // --------------------------------------------
        // Expanded gives the Save/Update button the same width as the Cancel button.
        Expanded(
          child: ElevatedButton(

            // Execute the save callback provided
            // by the parent Create/Edit Note screen.
            onPressed: onSave,

            // Configure the appearance of the button.
            style: ElevatedButton.styleFrom(

              // Use brown as the button background.
              backgroundColor: AppColors.brown,

              // Use white for the button text.
              foregroundColor: AppColors.white,

              // Add vertical spacing inside the button.
              padding: const EdgeInsets.symmetric(
                vertical: 17,
              ),

              // Apply rounded corners to match
              // the Cancel button.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),

            // Change the button label depending
            // on whether the user is creating
            // or editing a personal note.
            child: Text(
              isEditing ? 'Update Note' : 'Save Note',

              // Centre the button label.
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
