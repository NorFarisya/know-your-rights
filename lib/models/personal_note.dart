
class PersonalNote {
  final String title;
  final String category;
  final String description;
  final bool isExample;

  // A note contains a title, category and description.
  // isExample identifies the two sample notes from Canva.
  const PersonalNote({
    required this.title,
    required this.category,
    required this.description,
    this.isExample = false,
  });
}
