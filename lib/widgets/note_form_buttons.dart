
import 'package:flutter/material.dart';

// Reusable action buttons for creating and editing notes.
// Callbacks are provided by the parent form.
class NoteFormButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isEditing;

  const NoteFormButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF90725D);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: brown,
              side: const BorderSide(color: brown),
              padding: const EdgeInsets.symmetric(vertical: 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: brown,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Text(
              isEditing ? 'Update Note' : 'Save Note',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
