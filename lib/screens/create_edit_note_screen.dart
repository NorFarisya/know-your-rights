import 'package:flutter/material.dart';

// Import the PersonalNote model to store the
// title, category and description of each note.
import '../models/personal_note.dart';

// Import the reusable Save, Update and Cancel buttons.
import '../widgets/note_form_buttons.dart';

// Import the shared application colours to maintain
// consistent styling throughout Know Ur Rights.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - CREATE AND EDIT NOTE SCREEN
// ======================================================
// This screen is used for both creating a new note
// and editing an existing personal note.
// When an existing note is provided, its information
// is automatically displayed in the form fields.
// StatefulWidget is used because the screen manages
// text input, category selection and form validation.
class CreateEditNoteScreen extends StatefulWidget {
  // ----------------------------------------------------
  // 1. EXISTING NOTE INFORMATION
  // ----------------------------------------------------
  // Stores an optional PersonalNote object.
  //
  // If existingNote is null, the screen creates a new note.
  // If existingNote contains data, the screen edits that note.
  final PersonalNote? existingNote;

  const CreateEditNoteScreen({
    super.key,
    this.existingNote,
  });

  @override
  State<CreateEditNoteScreen> createState() =>
      _CreateEditNoteScreenState();
}

// ======================================================
// CREATE AND EDIT NOTE SCREEN STATE
// ======================================================
class _CreateEditNoteScreenState
    extends State<CreateEditNoteScreen> {

  // ----------------------------------------------------
  // 2. FORM VALIDATION KEY
  // ----------------------------------------------------
  // GlobalKey<FormState> allows the application to
  // validate all required form fields before saving.
  // The form will only be submitted when the title,
  // category and description pass validation.
  final _formKey = GlobalKey<FormState>();

  // ----------------------------------------------------
  // 3. TEXT EDITING CONTROLLERS
  // ----------------------------------------------------
  // TextEditingController stores the information
  // entered into the Note Title and Description fields.
  // These controllers also allow existing note
  // information to be displayed during editing.
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  // ----------------------------------------------------
  // 4. SELECTED NOTE CATEGORY
  // ----------------------------------------------------
  // Stores the rights category selected by the user
  // from the dropdown menu.
  String? _selectedCategory;

  // Defines the four available rights categories
  // used throughout the Know Ur Rights application.
  final List<String> _categories = [
    'Employment',
    'Consumer',
    'Digital',
    'Housing',
  ];

  // ----------------------------------------------------
  // 5. DETERMINE CREATE OR EDIT MODE
  // ---------------------------------------------------
  // Returns true when an existing note is provided.
  // This helps the screen display the correct title
  // and Save or Update button depending on the mode.
  bool get isEditing => widget.existingNote != null;

  // ----------------------------------------------------
  // 6. INITIALIZE FORM INFORMATION
  // ----------------------------------------------------
  // initState runs once when the screen is created.
  // If editing an existing note, the previous title,
  // description and category are loaded into the form.
  // If creating a new note, the form starts empty.
  @override
  void initState() {
    super.initState();

    // Display the existing note title when editing.
    // Otherwise, use an empty string.
    _titleController = TextEditingController(
      text: widget.existingNote?.title ?? '',
    );

    // Display the existing description when editing.
    // Otherwise, use an empty string.
    _descriptionController = TextEditingController(
      text: widget.existingNote?.description ?? '',
    );

    // Automatically select the existing note category
    // when the user opens the Edit Note screen.
    _selectedCategory = widget.existingNote?.category;
  }

  // ----------------------------------------------------
  // 7. DISPOSE TEXT CONTROLLERS
  // ----------------------------------------------------
  // dispose runs when the screen is removed.
  //
  // It releases the TextEditingController resources
  // to prevent unnecessary memory usage.
  @override
  void dispose() {

    // Release the title controller.
    _titleController.dispose();

    // Release the description controller.
    _descriptionController.dispose();

    super.dispose();
  }

  // ----------------------------------------------------
  // 8. VALIDATE AND SAVE NOTE
  // ----------------------------------------------------
  // This function is called when the user selects
  // Save Note or Update Note.
  //
  // It validates the form, creates a PersonalNote
  // object and returns it to MyNotesScreen.
  void _saveNote() {

    // Validate all required fields before saving.
    //
    // If any field is empty or invalid, validation
    // messages appear and the note is not saved.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Create a PersonalNote object containing
    // the information entered by the user.
    //
    // trim() removes unnecessary spaces from
    // the beginning and end of text values.
    final note = PersonalNote(
      title: _titleController.text.trim(),
      category: _selectedCategory!,
      description: _descriptionController.text.trim(),
      isExample: false,
    );

    // Navigator.pop closes the form and returns
    // the PersonalNote object to MyNotesScreen.
    //
    // The parent screen then adds or updates the
    // note in the shared temporary storage.
    Navigator.pop(context, note);
  }

  // ----------------------------------------------------
  // 9. REUSABLE TEXT FIELD DESIGN
  // ----------------------------------------------------
  // Creates a shared InputDecoration for the
  // Note Title and Description text fields.
  // Using one function keeps the form fields
  // visually consistent throughout the screen.
  InputDecoration _inputDecoration(String hint) {

    return InputDecoration(

      // Display example text before the user
      // enters information into the field.
      hintText: hint,

      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),

      // Apply a white background to the input field.
      filled: true,
      fillColor: AppColors.white,

      // Add spacing inside the input field.
      contentPadding: const EdgeInsets.all(17),

      // Define the general rounded input border.
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      // Display a navy border when the field
      // is not currently selected.
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(
          color: AppColors.navy,
          width: 0.8,
        ),
      ),

      // Display a brown border when the user
      // selects the input field.
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(
          color: AppColors.brown,
          width: 1.5,
        ),
      ),

      // Display a red border when the field
      // fails validation.
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),

      // Keep the red validation border visible
      // when an invalid field is selected.
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 10. CATEGORY DROPDOWN DESIGN
  // ----------------------------------------------------
  // Creates the input decoration for the category
  // dropdown menu.
  // The design matches the other input fields while
  // supporting a separate beige dropdown arrow.
  InputDecoration _dropdownDecoration() {

    return InputDecoration(

      // Apply a white background to the dropdown.
      filled: true,
      fillColor: AppColors.white,

      // Add spacing around the selected category.
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 18,
      ),

      // Define the general dropdown border.
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      // Display the navy border in its normal state.
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.navy,
          width: 0.8,
        ),
      ),

      // Display a brown border when selected.
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.brown,
          width: 1.5,
        ),
      ),

      // Display a red border when no category
      // has been selected during validation.
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      // Keep the red border when the invalid
      // dropdown is currently focused.
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 11. REUSABLE DROPDOWN ARROW
  // ----------------------------------------------------
  // Creates a custom dropdown arrow with a soft
  // beige background and rounded corners.
  // This follows the group's Canva mockup and
  // matches the rounded buttons in My Notes.
  Widget _buildDropdownArrow() {

    return Center(
      widthFactor: 1.0,
      heightFactor: 1.0,

      child: Container(
        width: 36,
        height: 36,

        alignment: Alignment.center,

        decoration: BoxDecoration(

          // AppColors.employment uses the same
          // soft beige colour as the original design.
          color: AppColors.employment,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),

        // Display the dropdown arrow icon.
        child: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.brown,
          size: 22,
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 12. REUSABLE FORM FIELD LABEL
  // ----------------------------------------------------
  // Creates a consistent label displayed above
  // each required form field.
  Widget _fieldLabel(String label) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Text(
        label,

        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.navy,
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 13. BUILD MAIN CREATE / EDIT NOTE SCREEN
  // ----------------------------------------------------
  // Builds the form interface containing the header,
  // note title, category, description, information
  // card and Save or Cancel buttons.
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // Apply the shared application background colour.
      backgroundColor: AppColors.background,

      // SafeArea keeps content away from the
      // device's status bar and screen edges.
      body: SafeArea(

        // SingleChildScrollView allows the form
        // to scroll when the keyboard is displayed
        // or when the device screen is smaller.
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 28,
          ),

          // Form groups all required input fields
          // and connects them to _formKey for validation.
          child: Form(
            key: _formKey,

            // Column arranges form components vertically.
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                // ------------------------------------
                // 14. CREATE / EDIT NOTE HEADER
                // ------------------------------------
                // Displays the brown header based
                // on the group's Canva mockup.
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  // Row positions the back button
                  // beside the screen title.
                  child: Row(
                    children: [

                      // Back button closes the form
                      // without saving any changes.
                      IconButton(
                        tooltip: 'Back',

                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                        ),
                      ),

                      // Display the appropriate heading
                      // depending on Create or Edit mode.
                      Text(
                        isEditing
                            ? 'Edit Note'
                            : 'Create Note',

                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // ------------------------------------
                // 15. FORM INTRODUCTION
                // ------------------------------------
                // Explain the purpose of creating
                // personal notes in the application.
                const Text(
                  'Record Your Concern',

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Write down important details to refer to later.',

                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.navy,
                  ),
                ),

                const SizedBox(height: 27),

                // ------------------------------------
                // 16. NOTE TITLE INPUT FIELD
                // ------------------------------------
                // Display the required Note Title label.
                _fieldLabel('Note Title *'),

                // TextFormField allows users to enter
                // the title of their personal note.
                TextFormField(
                  controller: _titleController,

                  decoration: _inputDecoration(
                    'e.g. Unpaid Salary',
                  ),

                  textCapitalization:
                      TextCapitalization.sentences,

                  // Validate the title when the
                  // user attempts to save the note.
                  //
                  // Empty titles are not accepted.
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter a note title';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 23),

                // ------------------------------------
                // 17. NOTE CATEGORY DROPDOWN
                // ------------------------------------
                // Display the required Category label.
                _fieldLabel('Category *'),

                // DropdownButtonFormField allows users
                // to select one of four rights categories.
                DropdownButtonFormField<String>(

                  // Display the selected category
                  // when creating or editing a note.
                  value: _selectedCategory,

                  // Allow the dropdown to use the
                  // available horizontal space.
                  isExpanded: true,

                  // Use the custom beige dropdown arrow.
                  icon: _buildDropdownArrow(),

                  // Apply the shared dropdown design.
                  decoration: _dropdownDecoration(),

                  dropdownColor: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  menuMaxHeight: 220,

                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.navy,
                  ),

                  // Display instructional text when
                  // no category has been selected.
                  hint: const Text(
                    'Select a category',

                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  // Generate the dropdown menu options
                  // using the four rights categories.
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.navy,
                        ),
                      ),
                    );
                  }).toList(),

                  // Update the selected category
                  // when the user chooses an option.
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },

                  // Validate the category selection.
                  //
                  // The user must select a category
                  // before the note can be saved.
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 23),

                // ------------------------------------
                // 18. NOTE DESCRIPTION INPUT FIELD
                // ------------------------------------
                // Display the required Description label.
                _fieldLabel('Description *'),

                // TextFormField allows users to enter
                // a longer explanation of their concern.
                TextFormField(
                  controller: _descriptionController,

                  // Set the visible input area to
                  // between five and seven lines.
                  minLines: 5,
                  maxLines: 7,

                  decoration: _inputDecoration(
                    'Describe your concern here...',
                  ),

                  // Validate the description before saving.
                  //
                  // Empty descriptions are not accepted.
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter a description';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // ------------------------------------
                // 19. TEMPORARY STORAGE INFORMATION
                // ------------------------------------
                // Display an information card explaining
                // how personal notes are stored.
                //
                // For Practical 1, notes use temporary
                // application memory instead of a database.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: AppColors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // Row places the information icon
                  // beside the storage explanation.
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

                      SizedBox(width: 10),

                      // Expanded allows the description
                      // to wrap on smaller screen sizes.
                      Expanded(
                        child: Text(
                          'Your note will be saved temporarily '
                          'during this app session.',

                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ------------------------------------
                // 20. SAVE AND CANCEL BUTTONS
                // ------------------------------------
                // NoteFormButtons is imported from
                // lib/widgets/note_form_buttons.dart.
                // The same reusable widget displays
                // Save Note or Update Note depending
                // on whether the form is being edited.
                NoteFormButtons(

                  // Identify whether the user is
                  // creating or editing a note.
                  isEditing: isEditing,

                  // Cancel closes the screen without
                  // returning a new or updated note.
                  onCancel: () {
                    Navigator.pop(context);
                  },

                  // Save validates the form and
                  // returns the completed note.
                  onSave: _saveNote,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
