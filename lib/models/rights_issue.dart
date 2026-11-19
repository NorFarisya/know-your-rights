
// KNOW YOUR RIGHTS
// Model for storing rights issues and legal information.

// Represents a legal reference or official resource.
class LegalSource {
  final String title;
  final String description;
  final String url;

  const LegalSource({
    required this.title,
    required this.description,
    required this.url,
  });
}

// Represents one rights-related issue in the app.
class RightsIssue {

  // Basic information displayed on Explore Rights.
  final String title;
  final String category;
  final String description;

  // Information displayed on Rights Details.
  final String problemOverview;
  final List<String> rights;
  final List<String> nextSteps;

  // Agency or organization providing assistance.
  final String agencyName;
  final String agencyDescription;

  // Links to legislation and official guidance.
  final List<LegalSource> sources;

  // Important legal limitations or regional scope.
  final String jurisdictionNote;

  const RightsIssue({
    required this.title,
    required this.category,
    required this.description,

    // Optional for now because detailed content
    // has been added one issue at a time.
    this.problemOverview = '',
    this.rights = const [],
    this.nextSteps = const [],
    this.agencyName = '',
    this.agencyDescription = '',
    this.sources = const [],
    this.jurisdictionNote = '',
  });
}
