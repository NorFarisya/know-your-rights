 // ======================================================
 // KNOW UR RIGHTS - PERSONAL NOTE MODEL
 // ======================================================
// This model defines the structure of a personal note
// used in the Know Ur Rights application.
// It stores the title, rights category, description
// and example status of each note.
// The PersonalNote model is shared between the
// Create/Edit Note screen and NoteStorageService.

class PersonalNote {

  // ----------------------------------------------------
  // 1. NOTE DATA ATTRIBUTES
  // ----------------------------------------------------
  // Stores the title entered by the user.
  final String title;

  // Stores the rights category selected by the user.
  // Examples include Employment, Consumer, Digital and Housing.
  final String category;

  // Stores the detailed description of the user's concern.
  final String description;

  // Identifies whether the note is a sample note
  // provided by the application.
  //
  // true  = Sample note from the application.
  // false = Note created by the user.
  final bool isExample;


  // ----------------------------------------------------
  // 2. PERSONAL NOTE CONSTRUCTOR
  // ----------------------------------------------------
  // Creates a PersonalNote object containing
  // the information required for each note.
  // required ensures that the title, category
  // and description must be provided.
  // isExample is optional and defaults to false
  // for notes created by the user.
  const PersonalNote({
    required this.title,
    required this.category,
    required this.description,
    this.isExample = false,
  });
}
