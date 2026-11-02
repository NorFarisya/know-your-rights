
import 'package:flutter/foundation.dart';

// Import the PersonalNote model to represent
// the information stored in each personal note.
import '../models/personal_note.dart';

// ======================================================
// KNOW UR RIGHTS - NOTE STORAGE SERVICE
// ======================================================
// This service manages the temporary storage of personal notes in the Know Ur Rights application.
// Users can create new notes and update existing notes through the My Notes feature.
// For Practical 1, notes are stored in application memory without using a database or permanent storage.
// A singleton pattern ensures that all screens accessthe same shared notes collection.
class NoteStorageService {
  // ----------------------------------------------------
  // 1. SINGLETON INSTANCE
  // ----------------------------------------------------
  // Private constructor prevents other classes from creating multiple NoteStorageService objects.
  NoteStorageService._();
  // Creates one shared instance of NoteStorageService.
  // This instance is used by MyNotesScreen to manage notes throughout the application session.
  static final NoteStorageService instance =
      NoteStorageService._();

  // ----------------------------------------------------
  // 2. SHARED NOTES COLLECTION
  // ----------------------------------------------------
  // ValueNotifier stores a list of PersonalNote objects.
  // It automatically notifies listening widgets whenever
  // the notes list is replaced with an updated list.
  // MyNotesScreen uses ValueListenableBuilder to listen
  // for these changes and update the displayed notes.
  // Two example notes are provided initially to match the group's Canva mockup.
  final ValueNotifier<List<PersonalNote>> notes =
      ValueNotifier<List<PersonalNote>>([
    // ------------------------------------
    // EXAMPLE NOTE 1 - EMPLOYMENT RIGHTS
    // ------------------------------------
    // Sample note about delayed salary payment.
    // isExample is set to true so the interface can identify it as a sample note.
    const PersonalNote(
      title: 'Unpaid Salary',
      category: 'Employment',
      description: 'Questions about delayed salary payment.',
      isExample: true,
    ),

    // ------------------------------------
    // EXAMPLE NOTE 2 - CONSUMER RIGHTS
    // ------------------------------------
    // Sample note about a faulty purchased product.
    // This provides another example from a different rights category for the My Notes interface.
    const PersonalNote(
      title: 'Faulty Product',
      category: 'Consumer',
      description: 'Steps to follow regarding a defective item.',
      isExample: true,
    ),
  ]);

  // ----------------------------------------------------
  // 3. ADD NEW NOTE
  // ----------------------------------------------------
  // Adds a new PersonalNote object to the existing notes collection.
  // This function is called by MyNotesScreen after
  // the user successfully completes the Create Note form.
  void addNote(PersonalNote note) {
    // Create a new list containing the existing notes
    // followed by the newly created note.
    // The spread operator (...) copies all existing
    // notes into the new list.
    // Assigning a new list to notes.value triggers
    // ValueNotifier to notify its listeners.
    notes.value = [
      ...notes.value,
      note,
    ];
  }

  // ----------------------------------------------------
  // 4. UPDATE EXISTING NOTE
  // ----------------------------------------------------
  // Updates an existing note using its position
  // in the notes collection.
  // index identifies which note should be updated.
  // updatedNote contains the new note information.
  // This function is called by MyNotesScreen after
  // the user successfully completes the Edit Note form.
  void updateNote(int index, PersonalNote updatedNote) {

    // ------------------------------------
    // VALIDATE NOTE INDEX
    // ------------------------------------
    // Check that the selected index is within
    // the valid range of the notes collection.
    // If the index is negative or greater than the last available position, stop the update.
    // This prevents invalid list access errors.
    if (index < 0 || index >= notes.value.length) return;

    // ------------------------------------
    // CREATE AN UPDATED NOTES LIST
    // ------------------------------------
    // Create a separate copy of the current list.
    // This allows us to update one note without directly modifying the existing list object.
    final updatedList = List<PersonalNote>.from(notes.value);

    // ------------------------------------
    // REPLACE THE SELECTED NOTE
    // ------------------------------------
    // Replace the original note at the selected
    // index with the updated PersonalNote object.
    updatedList[index] = updatedNote;

    // -----------------------------------
    // NOTIFY THE USER INTERFACE
    // ------------------------------------
    // Assign the updated list to the ValueNotifier.
    // This notifies ValueListenableBuilder in MyNotesScreen,
    // causing the notes list to rebuild and display
    // the updated information automatically.
    notes.value = updatedList;
  }
}
