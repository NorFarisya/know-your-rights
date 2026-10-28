
import 'package:flutter/material.dart';

// Import our separate reusable pencil button.
import 'note_edit_button.dart';

// This widget displays an individual saved note.
// It receives the note information from MyNotesScreen.
class NoteCard extends StatelessWidget {
  final String category;
  final String title;
  final String description;
  final Color categoryColor;
  final Color textColor;
  final VoidCallback onEdit;
  final bool isExample;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF2F3547),
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Display the category label and edit button.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Category label.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),

              // Reusable pencil button from another Dart file.
              // The onEdit callback opens the Edit Note form.
              NoteEditButton(
                onPressed: onEdit,
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Display the saved note title.
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F3547),
            ),
          ),

          const SizedBox(height: 5),

          // Display the saved note description.
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2F3547),
            ),
          ),

          // Show this label only for sample notes.
          if (isExample) ...[
            const SizedBox(height: 8),
            const Text(
              'Example note',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF90725D),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
