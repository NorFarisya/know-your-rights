
import 'package:flutter/material.dart';

// Shared note data and session storage.
import '../models/personal_note.dart';
import '../services/note_storage_service.dart';

// Reusable UI components.
import '../widgets/app_bottom_navigation.dart';
import '../widgets/note_card.dart';
import '../widgets/note_action_button.dart';

// Screens used for navigation.
import 'dashboard_screen.dart';
import 'create_edit_note_screen.dart';
import 'placeholder_screen.dart';

// My Notes reads data from the shared NoteStorageService.
// StatelessWidget is sufficient because ValueListenableBuilder
// automatically updates the note list when data changes.
class MyNotesScreen extends StatelessWidget {
  const MyNotesScreen({super.key});

  // Know Your Rights colour palette.
  static const Color brown = Color(0xFF90725D);
  static const Color navy = Color(0xFF2F3547);
  static const Color background = Color(0xFFFAF6F2);
  static const Color blueGrey = Color(0xFFCED9E4);

  // Access the same storage instance across all screens.
  NoteStorageService get _storage =>
      NoteStorageService.instance;

  // ------------------------------------------------
  // CREATE NOTE
  // ------------------------------------------------

  // Opens the form and adds the new note to shared storage.
  Future<void> _createNote(BuildContext context) async {
    final newNote = await Navigator.push<PersonalNote>(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateEditNoteScreen(),
      ),
    );

    // Cancel returns null, so nothing is saved.
    if (!context.mounted || newNote == null) return;

    _storage.addNote(newNote);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note saved successfully!'),
      ),
    );
  }

  // ------------------------------------------------
  // EDIT NOTE
  // ------------------------------------------------

  // Opens the form with the selected note's existing data.
  // The updated note is saved back to shared storage.
  Future<void> _editNote(
    BuildContext context,
    int index,
    PersonalNote note,
  ) async {
    final updatedNote = await Navigator.push<PersonalNote>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateEditNoteScreen(
          existingNote: note,
        ),
      ),
    );

    // Do not update anything if the user cancelled.
    if (!context.mounted || updatedNote == null) return;

    _storage.updateNote(index, updatedNote);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note updated successfully!'),
      ),
    );
  }

  // ------------------------------------------------
  // EXPLORE RIGHTS NAVIGATION
  // ------------------------------------------------

  // Temporary navigation until Sai's screen is integrated.
  void _openExplore(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PlaceholderScreen(
          title: 'Explore Rights',
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CATEGORY COLOURS
  // ------------------------------------------------

  // Match each note category with the Canva colour palette.
  Color _categoryBackground(String category) {
    switch (category) {
      case 'Employment':
        return const Color(0xFFF4E8DC);

      case 'Consumer':
        return const Color(0xFFE3F0E6);

      case 'Digital':
        return const Color(0xFFD7E9FF);

      case 'Housing':
        return const Color(0xFFE8E0F8);

      default:
        return blueGrey;
    }
  }

  // Choose a readable text colour for each category.
  Color _categoryTextColor(String category) {
    switch (category) {
      case 'Employment':
        return brown;

      case 'Consumer':
        return const Color(0xFF387455);

      default:
        return navy;
    }
  }

  // ------------------------------------------------
  // MAIN MY NOTES SCREEN
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // Reuse the shared bottom navigation.
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            // Return to the Dashboard.
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );
            }
          } else if (index == 1) {
            _openExplore(context);
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brown header.
              _buildHeader(),

              const SizedBox(height: 28),

              // Saved Notes heading and Create Note button.
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saved Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Your personal notes',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                  // Reusable blue plus button.
                  NoteActionButton(
                    onPressed: () => _createNote(context),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ------------------------------------
              // SHARED NOTES LIST
              // ------------------------------------

              // Automatically rebuild when a note is
              // created or edited through NoteStorageService.
              ValueListenableBuilder<List<PersonalNote>>(
                valueListenable: _storage.notes,

                builder: (context, savedNotes, child) {
                  // Display a message if there are no notes.
                  if (savedNotes.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No notes yet. Tap + to create one.',
                          style: TextStyle(
                            color: navy,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }

                  // Generate one reusable NoteCard per note.
                  return ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount: savedNotes.length,

                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 22),

                    itemBuilder: (context, index) {
                      final note = savedNotes[index];

                      return NoteCard(
                        category: note.category,
                        title: note.title,
                        description: note.description,

                        categoryColor:
                            _categoryBackground(note.category),

                        textColor:
                            _categoryTextColor(note.category),

                        isExample: note.isExample,

                        // The edit button opens the form
                        // with the selected note information.
                        onEdit: () {
                          _editNote(context, index, note);
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 28),

              // Temporary storage information.
              _buildInformationCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // HEADER
  // ------------------------------------------------

  // Brown header matching the Canva design.
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: brown,
        borderRadius: BorderRadius.circular(18),
      ),

      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.edit_note,
            color: Colors.white,
            size: 27,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'My Notes',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'Keep your thoughts and concerns '
                  'in one place.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------
  // TEMPORARY STORAGE INFORMATION
  // ------------------------------------------------

  // Explain that notes remain available only
  // while the application is running.
  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),

      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 21,
            color: navy,
          ),

          SizedBox(width: 9),

          Expanded(
            child: Text(
              'For Practical 1, notes are stored temporarily '
              'and may disappear when the application restarts.',
              style: TextStyle(
                fontSize: 12,
                color: navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
