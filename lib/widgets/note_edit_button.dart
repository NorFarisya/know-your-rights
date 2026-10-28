import 'package:flutter/material.dart';

// Reusable edit button for note cards.
// A soft rounded background makes the tap area clearer.
class NoteEditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NoteEditButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xFFF4E8DC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE6D7CA),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.edit_outlined,
            size: 18,
            color: Color(0xFF90725D),
          ),
        ),
      ),
    );
  }
}