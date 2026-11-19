
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/rights_issue.dart';
import '../models/personal_note.dart';
import '../services/note_storage_service.dart';
import '../theme/app_theme.dart';
import 'my_notes_screen.dart';
import 'dashboard_screen.dart';

// REUSABLE RIGHTS DETAILS SCREEN

// This screen will display detailed information about a selected rights issue.
// The same screen is reused for all four categories.
// The information changes depending on the RightsIssue object passed to it.

class RightsDetailsScreen extends StatelessWidget {

  // Stores the selected issue so the screen knows
  // which title, description, rights and sources to display.
  final RightsIssue issue;

  const RightsDetailsScreen({

    super.key,
    required this.issue,

  });

  // SHARED COLOURS

  // These colours are used throughout the screen to keep
  // the design consistent with the Canva layout.

  static const Color pageBackground = Color(0xFFFAF7F4);
  static const Color blueBackground = Color(0xFFD7E9FF);
  static const Color brownBackground = Color(0xFFF5E9DD);
  static const Color blueIcon = Color(0xFF173E80);

  // DISPLAY MESSAGE
  // Shows a temporary SnackBar message to give feedback
  // when the user performs certain actions.
  void showMessage(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text(message),
        duration:const Duration(seconds: 2),
      ),
    );
  }

  // COPY SOURCE LINK

  // Uses Flutter Clipboard to copy a legal reference URL. (current use see how to follow link better)
  // This allows users to access the source link later
  // without needing any additional packages.
  void copySource(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));

    // Informs the user that the link has been copied.
    showMessage(context,'Source link copied to clipboard');
  }

  // REUSABLE SECTION CARD

  // Creates a bordered white container for each information section.
  // Using one method helps to avoid repeating the same container design
  // throughout the Rights Details screen.

  Widget buildSectionCard({
    required Widget child,
  }) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only (bottom: 10),
      padding: const EdgeInsets.all (12),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        border: Border.all(
          color: Colors.black87,
          width: 0.85,
        ),

         borderRadius:BorderRadius.circular(10),
      ),
      child:child,
    );
  }

  // REUSABLE SECTION ICON

  // Creates a circular background for the icons used
  // beside each information section.


  // The blue parameter controls whether the blue or brown
  // colour combination is used.

  Widget buildSectionIcon({

    required IconData icon,
    required bool blue,

  }) {


    return Container(
      width: 42,
      height: 42,
      decoration:BoxDecoration(

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

  // REUSABLE SECTION HEADING

  // Displays section titles using the same font size
  // and weight and colour throughout the page.
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

  // REUSABLE BODY TEXT

  // Displays the main information using a consistent text style

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

  // REUSABLE TEXT LIST

  // Displays information as bullet points or numbered steps.
  // The numbered parameter determines which format is used.

  Widget buildTextList(
    List<String> items, {
    bool numbered = false,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // A for loop creates one row for each item in the list.
        // This means the number of rows depends on the data provided

        for (int index = 0; index < items.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(

                  // Reserves the space for the bullet or list number

                  width:numbered ? 21 : 15,
                  child: Text(


                    // Displays a number when numbered is true.
                    // Otherwise, it will display a bullet point instead.


                    numbered ? '${index + 1}.' : '•', //like this
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.beaver,
                    ),

                  ),
                ),

                // Expanded allows longer text to wrap
                // within the available horizontal space.


                Expanded(
                  child: buildBodyText(items[index]),
                ),

              ],

            ),

          ),
      ],

    );
  }

  // ISSUE ICON

  // Selects an icon based on the category of the current issue.
  // A switch statement is used to display the correct icon.

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

  // Displays the issue title, category, description, and icon.
  // All information comes from the selected RightsIssue object.

  Widget buildIssueSummary() {
    return buildSectionCard(
      child:Row(
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

          // Expanded gives the text section the remaining space
          // so that longer titles and descriptions can fit

          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                buildHeading(issue.title),

                const SizedBox(height: 4),

                // Displays the category of the selected issue.

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),

                  decoration:BoxDecoration(
                    color: blueBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child:Text(

                    issue.category,
                    style: const TextStyle(
                      color: Color(0xFF1766CC),
                      fontSize:  11,
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                ),

                const SizedBox(height:5) ,

                //Shows a short description of the issue
              
                buildBodyText(issue.description),
              ],
            ),

          ),

        ],

      ),

    );
  }

  // PROBLEM OVERVIEW

  // Explains the selected rights issue to help users
  // understand the problem before they read their rights.

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
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                buildHeading('Problem Overview'),
                const SizedBox(height: 4),

                // Checks whether information is available.
                // Displays a temporary message if the field is empty.
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

  // Displays the legal rights related to the selected issue.

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
                buildHeading  ('What Are Your Rights?'),
                const SizedBox (height: 4),

                // Checks whether any rights information exists.
                // If available, displays it as a bullet-point list.

                if(issue.rights.isEmpty)
                  buildBodyText(
                    'Legal information coming soon.',
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

  // Shows the actions users can take to address their issue.
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

                // Displays a message if no next steps are available.
                // Otherwise, show the steps using numbered formatting.

                if (issue.nextSteps.isEmpty)
                  buildBodyText(
                    'Suggested actions coming soon.',
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

  // Displays the relevant agency information and legal references
  // so users is able to find official guidance for their selected issue


  Widget buildSeekHelp(BuildContext context) {
    return buildSectionCard(
      
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start ,
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

                    // Displays the description of the relevant agency.
                    // Shows a temporary message if the information is empty

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

          // A smaller container displays the agency name
          // separately from the other legal information.

          Container(

            width:double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color:Colors.black87),
              borderRadius: BorderRadius.circular (9) ,
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
                  child:Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      // Displays the agency name from the data model
                    
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

          // LEGAL REFERENCES AND RESOURCES

          // Only displays this section when the selected issue
          // has at least one source in the data list

          if(issue.sources.isNotEmpty) ...[
            const SizedBox(height: 12),

            const Text(

              'Legal References & Resources',
              style: TextStyle(
                fontSize:13 ,
                fontWeight:FontWeight.bold,
                color:AppTheme.ebonyClay,
              ),

            ),
            const SizedBox(height: 7),

            // Loops through the sources list to create
            // a separate resource container for each reference

            for (final source in issue.sources)

              Padding(
                padding: const EdgeInsets.only(bottom: 7),

                child:Material(

                  color: const Color(0xFFF4F7FC),
                  borderRadius: BorderRadius.circular(8),

                  child:InkWell(
                    borderRadius: BorderRadius.circular(8),

                    // When a resource is tapped its URL is copied
                    // to the clipboard instead of opening a browser (later in development change)
                    onTap: () =>
                        copySource(context, source.url),

                    child:Padding(
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
                                // Displays the source title.
                                Text(
                                  source.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppTheme.ebonyClay,
                                  ),
                                ),

                                const SizedBox(height:3),

                                // Displays a short explanation
                                // of what the source contains.

                                buildBodyText(
                                  source.description,
                                ),
                              ],
                            ),
                          ),

                          // Implied that the link can be copied.
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

  // Provide the buttons for saving the issue and returning to Explore

  Widget buildActionButtons(BuildContext context) {
    return Padding(

      padding:const EdgeInsets.symmetric(
        horizontal: 5 ,
        vertical: 4 ,
      ),

      child: Row(

        children: [
          // SAVE TO NOTES

          // Currently displays a temporary message because
          // the save functionality havent connect yet


          Expanded(
            child:SizedBox(
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

          // BACK TO EXPLORE

          // Navigator.pop() to close the current details screen
          // and returns the user to the previous Explore screen.

          Expanded(
            child: SizedBox(
            height:43,
              child:OutlinedButton (
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

  // Creates the navigation bar used to move between
  // the Home, Explore and Notes screens.

  Widget buildBottomNavigation(BuildContext context){

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

                // Clears the current navigation stack
                // and opens the Dashboard screen.

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

              // EXPLORE to ACTIVE TAB
              // Returns the user to the previous Explore screen

              Expanded(
                child:InkWell (
                  onTap: () {

                    // Return to Explore Rights screen

                    Navigator.pop(context);
                  },

                  child: Column (
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
              // Opens the My Notes screen using Navigator.push().

            
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


  // MAIN BUILD METHOD
  // Combines all the sections to create the complete Rights Details page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // BROWN HEADER
      // Displays the page title at the top of the screen.


      appBar: AppBar (

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
      // ListView allows users to scroll through all the information
      // because the details page contains several sections

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            24, 14, 24, 15,
          ),

          children: [
            // Each method here builds one section of the details page
            buildIssueSummary(),
            buildProblemOverview(),
            buildRights(),
            buildNextSteps(),
            buildSeekHelp(context),

            // DISCLAIMER
            // Only displays the jurisdiction note when information exists.
            // It appears after the legal references.


            if (issue.jurisdictionNote.isNotEmpty)
              Padding (
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

            // Displays the Save to Notes and Back to Explore buttons.
            buildActionButtons(context),
          ],
        ),
      ),

      // FIXED BOTTOM NAVIGATION

      // Keeps the navigation bar visible even when the user
      // scrolls through the details page


      bottomNavigationBar: buildBottomNavigation(context),

      
    );
  }
}
