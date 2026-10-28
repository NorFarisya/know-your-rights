
import 'package:flutter/material.dart';

import '../models/personal_note.dart';
import '../widgets/note_form_buttons.dart';

// This screen is reused for both Create Note and Edit Note.
// When an existing note is passed, its information is displayed
// automatically so the user can update it.
class CreateEditNoteScreen extends StatefulWidget {
  final PersonalNote? existingNote;

  const CreateEditNoteScreen({
    super.key,
    this.existingNote,
  });

  @override
  State<CreateEditNoteScreen> createState() =>
      _CreateEditNoteScreenState();
}

class _CreateEditNoteScreenState
    extends State<CreateEditNoteScreen> {

  // Group colour palette for Know Your Rights.
  static const brown = Color(0xFF90725D);
  static const navy = Color(0xFF2F3547);
  static const background = Color(0xFFFAF6F2);
  static const blueGrey = Color(0xFFCED9E4);
  static const softBeige = Color(0xFFF4E8DC);

  // The form key is used to validate required fields.
  final _formKey = GlobalKey<FormState>();

  // Controllers store the text entered by the user.
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  // Stores the category selected from the dropdown.
  String? _selectedCategory;

  // Categories follow the four main rights categories.
  final List<String> _categories = [
    'Employment',
    'Consumer',
    'Digital',
    'Housing',
  ];

  // Determines whether this page is creating or editing a note.
  bool get isEditing => widget.existingNote != null;

  @override
  void initState() {
    super.initState();

    // If editing, display the previous title and description.
    // If creating, start with empty fields.
    _titleController = TextEditingController(
      text: widget.existingNote?.title ?? '',
    );

    _descriptionController = TextEditingController(
      text: widget.existingNote?.description ?? '',
    );

    // Automatically select the existing category when editing.
    _selectedCategory = widget.existingNote?.category;
  }

  @override
  void dispose() {
    // Dispose controllers to release resources.
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Validate all form fields before saving.
  void _saveNote() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Create an updated PersonalNote object.
    final note = PersonalNote(
      title: _titleController.text.trim(),
      category: _selectedCategory!,
      description: _descriptionController.text.trim(),
      isExample: false,
    );

    // Return the saved note to MyNotesScreen.
    // The parent screen will update its notes list.
    Navigator.pop(context, note);
  }

  // ------------------------------------------------
  // TEXT FIELD DESIGN
  // ------------------------------------------------

  // Shared design for Note Title and Description.
  // Using one function keeps both fields consistent.
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.all(17),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: navy,
          width: 0.8,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: brown,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CATEGORY DROPDOWN DESIGN
  // ------------------------------------------------

  // Special dropdown decoration with a beige arrow box.
  // This matches the soft rounded buttons in My Notes.
  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: navy,
          width: 0.8,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: brown,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

    // Reusable dropdown arrow with a centered beige background.
    Widget _buildDropdownArrow() {
      return Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: softBeige,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE6D7CA),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: brown,
            size: 22,
          ),
        ),
      );
    }
    
  // ------------------------------------------------
  // FIELD LABEL
  // ------------------------------------------------

  // Reusable label shown above each form field.
  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: navy,
        ),
      ),
    );
  }

  // ------------------------------------------------
  // MAIN SCREEN
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 28,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Brown header matching the Canva mockup.
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),

                  decoration: BoxDecoration(
                    color: brown,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        isEditing
                            ? 'Edit Note'
                            : 'Create Note',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Form introduction.
                const Text(
                  'Record Your Concern',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Write down important details to refer to later.',
                  style: TextStyle(
                    fontSize: 13,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 27),

                // ------------------------------------
                // NOTE TITLE
                // ------------------------------------

                _fieldLabel('Note Title *'),

                TextFormField(
                  controller: _titleController,
                  decoration: _inputDecoration(
                    'e.g. Unpaid Salary',
                  ),

                  textCapitalization:
                      TextCapitalization.sentences,

                  // Prevent saving an empty title.
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
                // CATEGORY DROPDOWN
                // ------------------------------------

                _fieldLabel('Category *'),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  isExpanded: true,

                  // The arrow is now styled in its own widget.
                  icon: _buildDropdownArrow(),

                  decoration: _dropdownDecoration(),

                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  menuMaxHeight: 220,

                  style: const TextStyle(
                    fontSize: 14,
                    color: navy,
                  ),

                  hint: const Text(
                    'Select a category',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  // Generate options from the categories list.
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 14,
                          color: navy,
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },

                  // Category selection is compulsory.
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 23),

                // ------------------------------------
                // DESCRIPTION
                // ------------------------------------

                _fieldLabel('Description *'),

                TextFormField(
                  controller: _descriptionController,

                  // Allows the user to enter longer notes.
                  minLines: 5,
                  maxLines: 7,

                  decoration: _inputDecoration(
                    'Describe your concern here...',
                  ),

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
                // INFORMATION CARD
                // ------------------------------------

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 21,
                        color: navy,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          'Your note will be saved temporarily '
                          'during this app session.',
                          style: TextStyle(
                            fontSize: 12,
                            color: navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ------------------------------------
                // SAVE AND CANCEL BUTTONS
                // ------------------------------------

                // Buttons are imported from note_form_buttons.dart.
                // The same widget supports Save and Update.
                NoteFormButtons(
                  isEditing: isEditing,

                  onCancel: () {
                    Navigator.pop(context);
                  },

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
