
import 'package:flutter/foundation.dart';

import '../models/personal_note.dart';

// Shared temporary storage for My Notes.
//
// This service keeps notes in memory while the Flutter app
// is running. It does not use a database or local storage.
class NoteStorageService {
  // Private constructor prevents creating multiple instances.
  NoteStorageService._();

  // All screens access the same service instance.
  static final NoteStorageService instance =
      NoteStorageService._();

  // Sample notes based on our Canva mockup.
  final ValueNotifier<List<PersonalNote>> notes =
      ValueNotifier<List<PersonalNote>>([
    const PersonalNote(
      title: 'Unpaid Salary',
      category: 'Employment',
      description: 'Questions about delayed salary payment.',
      isExample: true,
    ),
    const PersonalNote(
      title: 'Faulty Product',
      category: 'Consumer',
      description: 'Steps to follow regarding a defective item.',
      isExample: true,
    ),
  ]);

  // Add a new note to the existing list.
  void addNote(PersonalNote note) {
    notes.value = [
      ...notes.value,
      note,
    ];
  }

  // Replace an existing note with its updated information.
  void updateNote(int index, PersonalNote updatedNote) {
  if (index < 0 || index >= notes.value.length) return;

  final updatedList = List<PersonalNote>.from(notes.value);
  updatedList[index] = updatedNote;
  notes.value = updatedList;
  }
}
