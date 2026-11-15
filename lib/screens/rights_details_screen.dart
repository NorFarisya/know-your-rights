
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/rights_issue.dart';
import '../models/personal_note.dart';
import '../services/note_storage_service.dart';
import '../theme/app_theme.dart';

import 'my_notes_screen.dart';
import 'dashboard_screen.dart';

// Reusable Rights Details screen.
// The displayed information changes based on the selected issue.
class RightsDetailsScreen extends StatelessWidget {
  final RightsIssue issue;

  const RightsDetailsScreen({
    super.key,
    required this.issue,
  });

  // Shared colours based on the Canva design.
  static const Color pageBackground = Color(0xFFFAF7F4);
  static const Color blueBackground = Color(0xFFD7E9FF);
  static const Color brownBackground = Color(0xFFF5E9DD);
  static const Color blueIcon = Color(0xFF173E80);

  // Displays a temporary message for unfinished features.
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Copies a resource URL without requiring extra packages.
  void copySource(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));

    showMessage(context, 'Source link copied to clipboard');
  }

  // Shared bordered container matching the Canva layout.
  Widget buildSectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        border: Border.all(
          color: Colors.black87,
          width: 0.85,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  // Creates the circular icons beside each section.
  Widget buildSectionIcon({
    required IconData icon,
    required bool blue,
  }) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: blue ? blueBackground : brownBackground,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: blue ? blueIcon : AppTheme.beaver,
        size: 25,
      ),
    );
  }

  // Reusable section heading.
  Widget buildHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Reusable body text.
  Widget buildBodyText(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 12,
        height: 1.4,
        color: AppTheme.beaver,
      ),
    );
  }

  // Creates bullet-point and numbered lists.
  Widget buildTextList(
    List<String> items, {
    bool numbered = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < items.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: numbered ? 21 : 15,
                  child: Text(
                    numbered ? '${index + 1}.' : '•',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.beaver,
                    ),
                  ),
                ),
                Expanded(
                  child: buildBodyText(items[index]),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Changes the issue icon depending on the category.
  IconData getIssueIcon() {
    switch (issue.category) {
      case 'Employment':
        return Icons.work_outline;
      case 'Consumer':
        return Icons.shopping_cart_outlined;
      case 'Digital':
        return Icons.laptop_mac;
      case 'Housing':
        return Icons.home;
      default:
        return Icons.description_outlined;
    }
  }

  // ISSUE SUMMARY
  Widget buildIssueSummary() {
    return buildSectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: blueBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              getIssueIcon(),
              color: blueIcon,
              size: 34,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeading(issue.title),

                const SizedBox(height: 4),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: blueBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    issue.category,
                    style: const TextStyle(
                      color: Color(0xFF1766CC),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                buildBodyText(issue.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PROBLEM OVERVIEW
  Widget buildProblemOverview() {
    return buildSectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionIcon(
            icon: Icons.error,
            blue: false,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeading('Problem Overview'),
                const SizedBox(height: 4),
                buildBodyText(
                  issue.problemOverview.isEmpty
                      ? 'Information will be added soon.'
                      : issue.problemOverview,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WHAT ARE YOUR RIGHTS?
  Widget buildRights() {
    return buildSectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionIcon(
            icon: Icons.balance,
            blue: true,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeading('What Are Your Rights?'),
                const SizedBox(height: 4),

                if (issue.rights.isEmpty)
                  buildBodyText(
                    'Legal information will be added soon.',
                  )
                else
                  buildTextList(issue.rights),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SUGGESTED NEXT STEPS
  Widget buildNextSteps() {
    return buildSectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionIcon(
            icon: Icons.send_rounded,
            blue: false,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeading('Suggested Next Steps'),
                const SizedBox(height: 4),

                if (issue.nextSteps.isEmpty)
                  buildBodyText(
                    'Suggested actions will be added soon.',
                  )
                else
                  buildTextList(
                    issue.nextSteps,
                    numbered: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WHERE TO SEEK HELP AND LEGAL SOURCES
  Widget buildSeekHelp(BuildContext context) {
    return buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionIcon(
                icon: Icons.people,
                blue: true,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeading('Where to Seek Help'),
                    const SizedBox(height: 4),
                    buildBodyText(
                      issue.agencyDescription.isEmpty
                          ? 'Official guidance will be added soon.'
                          : issue.agencyDescription,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Agency information card.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    color: blueBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: blueIcon,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeading(
                        issue.agencyName.isEmpty
                            ? 'Agency / Resource Name'
                            : issue.agencyName,
                      ),
                      const SizedBox(height: 3),
                      buildBodyText(
                        'Official guidance and legal references',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Display the legal references and agency links.
          if (issue.sources.isNotEmpty) ...[
            const SizedBox(height: 12),

            const Text(
              'Legal References & Resources',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.ebonyClay,
              ),
            ),

            const SizedBox(height: 7),

            for (final source in issue.sources)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Material(
                  color: const Color(0xFFF4F7FC),
                  borderRadius: BorderRadius.circular(8),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),

                    // Temporary: copy the official source URL.
                    onTap: () =>
                        copySource(context, source.url),

                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.link,
                            color: blueIcon,
                            size: 20,
                          ),

                          const SizedBox(width: 9),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  source.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppTheme.ebonyClay,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                buildBodyText(
                                  source.description,
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.copy,
                            color: blueIcon,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  // SAVE RIGHTS ISSUE TO MY NOTES
  void _saveToNotes(BuildContext context) {

    // Access the shared note storage.
    final storage = NoteStorageService.instance;

    // Check whether this issue has already been saved.
    final alreadySaved = storage.notes.value.any(
      (note) =>
          note.title.trim().toLowerCase() ==
              issue.title.trim().toLowerCase() &&
          note.category.trim().toLowerCase() ==
              issue.category.trim().toLowerCase(),
    );

    // Prevent duplicate notes.
    if (alreadySaved) {
      showMessage(
        context,
        'This issue is already saved in My Notes.',
      );
      return;
    }

    // Create a new personal note using the selected issue.
    final newNote = PersonalNote(
      title: issue.title,
      category: issue.category,
      description: issue.problemOverview.isNotEmpty
          ? issue.problemOverview
          : issue.description,
      isExample: false,
    );

    // Add the new note to shared temporary storage.
    storage.addNote(newNote);

    // Display confirmation.
    showMessage(
      context,
      'Successfully saved to My Notes!',
    );
  }

  // ACTION BUTTONS
  Widget buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 43,
              child: ElevatedButton.icon(
                onPressed: () {
                  _saveToNotes(context);
                },
                icon: const Icon(
                  Icons.bookmark_border,
                  size: 19,
                ),
                label: const Text(
                  'Save to Notes',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 43,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1766FF),
                  side: const BorderSide(
                    color: Color(0xFF1766FF),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                ),
                child: const Text(
                  'Back to Explore',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  // BOTTOM NAVIGATION
  Widget buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFBEBEBE),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              // HOME
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Navigate directly to Dashboard.
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 26),
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),

              // EXPLORE - ACTIVE TAB
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Return to Explore Rights.
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 28,
                        decoration: BoxDecoration(
                          color: blueBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xFF1477F8),
                          size: 25,
                        ),
                      ),
                      const Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1477F8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // NOTES
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Open My Notes.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyNotesScreen(),
                      ),
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 26,
                      ),
                      Text(
                        'Notes',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // BROWN HEADER
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: AppTheme.beaver,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
        title: const Text(
          'Rights Details',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // SCROLLABLE MAIN CONTENT
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            24, 14, 24, 15,
          ),
          children: [
            buildIssueSummary(),
            buildProblemOverview(),
            buildRights(),
            buildNextSteps(),
            buildSeekHelp(context),

            // Disclaimer appears after the sources.
            if (issue.jurisdictionNote.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
                child: Text(
                  issue.jurisdictionNote,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.4,
                    color: AppTheme.beaver,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            buildActionButtons(context),
          ],
        ),
      ),

      // FIXED BOTTOM NAVIGATION
      bottomNavigationBar: buildBottomNavigation(context),
    );
  }
}
