
import 'package:flutter/material.dart';

// Reusable circular action button.
// Used for creating a new note in My Notes.
class NoteActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NoteActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF95C2F9),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: 'Create Note',
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          size: 32,
          color: Color(0xFF2F3547),
        ),
      ),
    );
  }
}
