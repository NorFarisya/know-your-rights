
import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// Import the reusable pencil button used to edit notes.
import 'note_edit_button.dart';

// ======================================================
// KNOW UR RIGHTS - NOTE CARD WIDGET
// ======================================================
// This reusable widget displays an individual saved note inside the My Notes screen.
// It receives the note information from MyNotesScreen and displays the category, title and description.
// StatelessWidget is used because the widget only
// displays information received through its parameters.
// It does not manage its own changing data.
class NoteCard extends StatelessWidget {

  // ----------------------------------------------------
  // 1. NOTE INFORMATION AND PARAMETERS
  // ----------------------------------------------------
  // Stores the rights category of the note.
  final String category;

  // Stores the title of the personal note.
  final String title;

  // Stores the description entered by the user.
  final String description;

  // Defines the background colour of the category label.
  final Color categoryColor;

  // Defines the text colour of the category label.
  final Color textColor;

  // Callback function executed when the edit button
  // is pressed by the user.
  final VoidCallback onEdit;

  // Identifies whether the displayed note is an
  // example note provided by the application.
  // true  = Sample note.
  // false = User-created note.
  final bool isExample;

  // ----------------------------------------------------
  // 2. NOTE CARD CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a NoteCard using the information provided
  // by MyNotesScreen.
  // Required parameters ensure that the note information,
  // category colours and edit callback are supplied.
  // isExample is optional and defaults to false.
  const NoteCard({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.categoryColor,
    required this.textColor,
    required this.onEdit,
    this.isExample = false,
  });

  // ----------------------------------------------------
  // 3. BUILD NOTE CARD INTERFACE
  // ----------------------------------------------------
  // Builds the individual note card displayed in the My Notes screen.
  @override
  Widget build(BuildContext context) {
    // Container controls the overall size, spacing,
    // background, border and rounded corners.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        // Use the shared white colour for the card.
        color: AppColors.white,

        // Add a navy border to separate the card
        // from the surrounding screen background.
        border: Border.all(
          color: AppColors.navy,
          width: 0.7,
        ),

        // Apply rounded corners to the note card.
        borderRadius: BorderRadius.circular(12),
      ),
      // Column arranges the note information
      // vertically inside the card.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // --------------------------------------------
          // 4. CATEGORY LABEL AND EDIT BUTTON
          // --------------------------------------------
          // Row positions the category label and edit button horizontally.
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              // ----------------------------------------
              // CATEGORY LABEL
              // ----------------------------------------
              // Container creates a coloured label
              // to identify the note's rights category.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  // Receive the category background
                  // colour from MyNotesScreen.
                  color: categoryColor,
                  // Apply rounded corners to the label.
                  borderRadius: BorderRadius.circular(12),
                ),
                // Display the selected category name.
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    // Receive the category text colour
                    // from MyNotesScreen.
                    color: textColor,
                  ),
                ),
              ),

              // ----------------------------------------
              // EDIT NOTE BUTTON
              // ----------------------------------------
              // Reuse NoteEditButton from its separate
              // Dart file to maintain consistent design.
              // When pressed, the onEdit callback
              // opens the Edit Note form with the
              // selected note's existing information.
              NoteEditButton(
                onPressed: onEdit,
              ),
            ],
          ),

          const SizedBox(height: 6),

          // --------------------------------------------
          // 5. NOTE TITLE
          // --------------------------------------------
          // Display the title of the saved personal note.
          Text(
            title,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),

          const SizedBox(height: 5),

          // --------------------------------------------
          // 6. NOTE DESCRIPTION
          // --------------------------------------------
          // Display the detailed description entered
          // by the user when creating or editing a note.
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.navy,
            ),
          ),

          // --------------------------------------------
          // 7. EXAMPLE NOTE LABEL
          // -------------------------------------------
          // Display an additional label only when
          // the note is identified as an example.
          // The collection uses the isExample parameter
          // to distinguish sample notes from user notes.
          if (isExample) ...[
            const SizedBox(height: 8),

            const Text(
              'Example note',

              style: TextStyle(
                fontSize: 11,
                color: AppColors.brown,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
