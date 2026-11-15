import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout the Know Ur Rights app.
import '../theme/app_colors.dart';

// Import the PersonalNote model to represent
// the information stored in each personal note.
import '../models/personal_note.dart';

// Import the shared note storage service to manage
// temporary notes during the application session.
import '../services/note_storage_service.dart';

// Import reusable UI components used in My Notes.
import '../widgets/app_bottom_navigation.dart';
import '../widgets/note_card.dart';
import '../widgets/note_action_button.dart';

// Import screens used for navigation.
import 'dashboard_screen.dart';
import 'explore_rights_screen.dart';
import 'create_edit_note_screen.dart';

// ======================================================
// KNOW UR RIGHTS - MY NOTES SCREEN
// ======================================================
// This screen allows users to view, create and edit
// personal notes related to their rights and concerns.
// Notes are stored temporarily using NoteStorageService
// and remain available while the application is running.
// StatelessWidget is used because ValueListenableBuilder
// automatically updates the notes list whenever
// the shared note data changes.
class MyNotesScreen extends StatelessWidget {
  const MyNotesScreen({super.key});

  // ----------------------------------------------------
  // 1. SHARED NOTE STORAGE SERVICE
  // ----------------------------------------------------
  // Access the shared NoteStorageService instance.
  //
  // This ensures that all screens use the same notes
  // list instead of creating separate collections.
  NoteStorageService get _storage =>
      NoteStorageService.instance;

  // ----------------------------------------------------
  // 2. CREATE NEW NOTE
  // ----------------------------------------------------
  // Opens the Create Note form when users tap
  // the blue plus button on the My Notes screen.
  // After the user completes the form, the new
  // PersonalNote object is returned and added
  // to the shared notes list.
  Future<void> _createNote(BuildContext context) async {

    // Navigator.push opens the Create/Edit Note screen
    // and waits for a PersonalNote object to be returned.
    final newNote = await Navigator.push<PersonalNote>(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateEditNoteScreen(),
      ),
    );

    // Check whether the screen is still mounted and whether the user successfully saved a note.
    // If the user presses Cancel, null is returned
    // and no new note is added.
    if (!context.mounted || newNote == null) return;

    // Add the new note to the shared temporary storage.
    _storage.addNote(newNote);

    // Show a confirmation message after saving.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note saved successfully!'),
      ),
    );
  }

  // ----------------------------------------------------
  // 3. EDIT EXISTING NOTE
  // ----------------------------------------------------
  // Opens the Edit Note form with the selected
  // note's existing information.
  // The index identifies the note's position in the
  // list, while note contains its current details.
  Future<void> _editNote(
    BuildContext context,
    int index,
    PersonalNote note,
  ) async {

    // Open the Create/Edit Note screen and pass
    // the selected note to populate the form fields.
    final updatedNote = await Navigator.push<PersonalNote>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateEditNoteScreen(
          existingNote: note,
        ),
      ),
    );

    // If the user cancels editing, no changes
    // are made to the existing note.
    if (!context.mounted || updatedNote == null) return;

    // Replace the original note with the updated
    // information in the shared notes list.
    _storage.updateNote(index, updatedNote);

    // Display a confirmation message after updating.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note updated successfully!'),
      ),
    );
  }

  // ----------------------------------------------------
  // 4. EXPLORE RIGHTS NAVIGATION
  // ----------------------------------------------------
  // Opens a temporary Explore Rights placeholder.
  // This allows the bottom navigation to be tested
  // before Sai's Explore Rights screen is integrated.
    void _openExplore(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExploreRightsScreen(

            // Home button returns directly to Dashboard.
            onHomeTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
                (route) => false,
              );
            },

            // Notes button returns to the existing My Notes screen.
            onNotesTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }

  // ----------------------------------------------------
  // 5. NOTE CATEGORY BACKGROUND COLOURS
  // ----------------------------------------------------
  // Returns the appropriate background colour
  // based on the note's selected rights category.
  // The colours are retrieved from AppColors to
  // maintain consistent category styling.
  Color _categoryBackground(String category) {

    switch (category) {

      // Employment notes use a soft beige background.
      case 'Employment':
        return AppColors.employment;

      // Consumer notes use a soft green background.
      case 'Consumer':
        return AppColors.consumer;

      // Digital notes use a soft blue background.
      case 'Digital':
        return AppColors.digital;

      // Housing notes use a soft purple background.
      case 'Housing':
        return AppColors.housing;

      // Use blue-grey for any unrecognised category.
      default:
        return AppColors.blueGrey;
    }
  }

  // ----------------------------------------------------
  // 6. NOTE CATEGORY TEXT COLOURS
  // ----------------------------------------------------
  // Returns a readable text colour based on
  // the selected rights category.
  //
  // This helps users distinguish different categories
  // while maintaining readable text contrast.
  Color _categoryTextColor(String category) {
    switch (category) {

      // Employment category text uses brown.
      case 'Employment':
        return AppColors.brown;

      // Consumer category text uses green.
      case 'Consumer':
        return AppColors.online;

      // Other categories use the main navy text colour.
      default:
        return AppColors.navy;
    }
  }

  // ----------------------------------------------------
  // 7. BUILD MAIN MY NOTES SCREEN
  // ----------------------------------------------------
  // Builds the main My Notes interface containing
  // the header, Create Note button, saved notes list,
  // information card and bottom navigation.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Use the shared application background colour.
      backgroundColor: AppColors.background,

            // ------------------------------------------------
            // 8. BOTTOM NAVIGATION BAR
            // ------------------------------------------------
            // Reuse the shared bottom navigation widget.
            // currentIndex: 2 indicates that Notes is selected.    
            bottomNavigationBar: AppBottomNavigation(
              currentIndex: 2,

              onTap: (index) {

                // HOME - Return directly to Dashboard.
                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                    (route) => false,
                  );
                }

                // EXPLORE - Open Sai's actual Explore Rights screen.
                else if (index == 1) {
                  _openExplore(context);
                }
              },
            ),


      // ------------------------------------------------
      // 9. MAIN SCREEN CONTENT
      // ------------------------------------------------
      // SafeArea prevents content from overlapping
      // the device's status bar and screen edges.
      body: SafeArea(

        // SingleChildScrollView allows the page
        // to scroll on devices with smaller screens.
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 24,
          ),

          // Column arranges the My Notes components
          // vertically from top to bottom.
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Display the My Notes header.
              _buildHeader(),

              const SizedBox(height: 28),

              // ------------------------------------
              // 10. SAVED NOTES SECTION
              // ------------------------------------
              // Row places the Saved Notes heading
              // and Create Note button horizontally.
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  // Display the saved notes heading
                  // and short description.
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saved Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Your personal notes',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // ------------------------------------
                  // 11. CREATE NOTE BUTTON
                  // ------------------------------------
                  // NoteActionButton is a reusable
                  // circular blue button with a plus icon.
                  //
                  // When pressed, it opens the Create Note
                  // form through the _createNote method.
                  NoteActionButton(
                    onPressed: () => _createNote(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ------------------------------------
              // 12. SHARED NOTES LIST
              // ------------------------------------
              // ValueListenableBuilder listens to the
              // shared notes stored in NoteStorageService.
              //
              // Whenever a note is created or edited,
              // the updated notes list is displayed
              // automatically without manual refreshing.
              ValueListenableBuilder<List<PersonalNote>>(
                valueListenable: _storage.notes,
                builder: (context, savedNotes, child) {

                  // --------------------------------
                  // 13. EMPTY NOTES MESSAGE
                  // --------------------------------
                  // Display an informational message
                  // when the saved notes list is empty.
                  if (savedNotes.isEmpty) {

                    return const Padding(
                      padding: EdgeInsets.all(24),

                      child: Center(
                        child: Text(
                          'No notes yet. Tap + to create one.',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }

                  // --------------------------------
                  // 14. DISPLAY SAVED NOTES
                  // --------------------------------
                  // ListView.separated generates a
                  // reusable NoteCard for each saved note.
                  // It also inserts spacing between cards.
                  // shrinkWrap and NeverScrollableScrollPhysics
                  // allow the notes list to work inside the
                  // parent SingleChildScrollView.
                  return ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),

                    // Set the total number of notes
                    // that should be displayed.
                    itemCount: savedNotes.length,

                    // Add spacing between note cards.
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 22),

                    // Build each individual note card.
                    itemBuilder: (context, index) {

                      // Retrieve the note at the
                      // current position in the list.
                      final note = savedNotes[index];
                      return NoteCard(

                        // Display the selected note category.
                        category: note.category,

                        // Display the note title and description.
                        title: note.title,
                        description: note.description,

                        // Apply the category background colour.
                        categoryColor:
                            _categoryBackground(note.category),

                        // Apply the category text colour.
                        textColor:
                            _categoryTextColor(note.category),

                        // Identify whether the note is an
                        // example provided by the application.
                        isExample: note.isExample,

                        // --------------------------------
                        // 15. EDIT NOTE BUTTON
                        // --------------------------------
                        // The edit button opens the form
                        // using the selected note information.
                        onEdit: () {
                          _editNote(context, index, note);
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 28),

              // ------------------------------------
              // 16. TEMPORARY STORAGE INFORMATION
              // ------------------------------------
              // Inform users that their notes are
              // stored temporarily during Practical 1.
              _buildInformationCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 17. MY NOTES HEADER
  // ----------------------------------------------------
  // Creates the brown header displayed at the top
  // of the My Notes screen.
  //
  // The header contains an icon, screen title
  // and short description based on the Canva design.
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      // BoxDecoration applies the brown background
      // and rounded corners to the header.
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(18),
      ),

      // Row positions the icon and text horizontally.
      child: const Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // Display an icon representing personal notes.
          Icon(
            Icons.edit_note,
            color: AppColors.white,
            size: 27,
          ),

          SizedBox(width: 10),

          // Expanded allows the title and description
          // to use the remaining horizontal space.
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Main screen title.
                Text(
                  'My Notes',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),

                SizedBox(height: 6),

                // Short explanation of the screen.
                Text(
                  'Keep your thoughts and concerns '
                  'in one place.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 18. TEMPORARY STORAGE INFORMATION CARD
  // ----------------------------------------------------
  // Creates the blue-grey information card
  // displayed below the saved notes list.
  //
  // This card explains that notes are temporarily
  // stored in application memory for Practical 1.
  //
  // The notes are not saved to a database and
  // may disappear when the application restarts.
  Widget _buildInformationCard() {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      // Use the shared blue-grey colour and
      // rounded corners for consistent styling.
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),

      child: const Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // Information icon.
          Icon(
            Icons.info_outline,
            size: 21,
            color: AppColors.navy,
          ),

          SizedBox(width: 9),

          // Expanded allows the information message
          // to wrap naturally on smaller devices.
          Expanded(
            child: Text(
              'For Practical 1, notes are stored temporarily '
              'and may disappear when the application restarts.',

              style: TextStyle(
                fontSize: 12,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
