
import 'package:flutter/material.dart';

// Import the rights information stored in rights_data.dart.
// This allows the screen to display the available rights issues.
import '../data/rights_data.dart';

// Import the RightsIssue model to access the information
// belonging to each individual issue.
import '../models/rights_issue.dart';

// Import the shared theme so the screen can use the same
// colours and styling as the rest of the application.
import '../theme/app_theme.dart';

// Import the details screen that opens when a user selects an issue.
import 'rights_details_screen.dart';


// EXPLORE RIGHTS SCREEN
// This screen displays the four common rights categories
// and allows users to filter and select different issues.

// StatefulWidget is used because the selected category can change
// when the user interacts with the category filters.
class ExploreRightsScreen extends StatefulWidget {

  // Stores an optional category that can be selected
  // when the Explore Rights screen is first opened.
  final String? initialCategory;

  // These callbacks allow other screens to control
  // the Home and Notes navigation.
  final VoidCallback? onHomeTap;
  final VoidCallback? onNotesTap;

  const ExploreRightsScreen({
     super.key,
     this.initialCategory,
     this.onHomeTap,
     this.onNotesTap,
  });

  // Creates the state object that manages the screen's
  // changing information and user interactions.
  @override
  State<ExploreRightsScreen> createState() =>
      _ExploreRightsScreenState();
}


// THE STATE CLASS

class _ExploreRightsScreenState
    extends State<ExploreRightsScreen> {

  // Stores the category currently selected by the user.
  // A null value means that no filter was selected.

  String? selectedCategory;

  // Stores all four categories available in the application.
  // This list is used to generate the category filter buttons.

  final List<String> categories = [
        'Employment',
        'Consumer',
        'Digital',
         'Housing',
  ];

  // INIT STATE
  // Runs once when the screen is first created.
  // Here irt checks whether an initial category was passed
  // from another screen and selects it if it is valid.

  @override
  void initState() {
    super.initState();

    selectedCategory = categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : null;
  }

  // FILTERED ISSUES
  // This getter returns the issues that should appear on the screen.
  // If no category is selected, all issues are displayed.
  // Otherwise, only issues matching the selected category are returned.

  List<RightsIssue> get filteredIssues {
    if (selectedCategory == null) {
      return rightsIssues;
    }

    // The where() method checks each issue and keeps
    // only the ones that match the selected category.
    // toList() converts the filtered results into a list.
    return rightsIssues
      .where((issue) => issue.category == selectedCategory)
      .toList();
  }

  // CATEGORY ICONS

  // Returns a different icon depending on the category.
  // A switch statement is used to check the category name

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Employment':
        return Icons.work;
      case 'Consumer':
        return Icons.shopping_cart_outlined;
      case 'Digital':
        return Icons.laptop_mac;
      case 'Housing':
        return Icons.home;
      default:
        return Icons.info_outline;
    }
  }

  // CATEGORY ICON BACKGROUNDS
  // Gives each category a different pastel background colour
  // to make the issue cards easier to recognise.

  Color getCategoryBackground(String category) {
    switch (category) {
      case 'Employment':
        return const Color(0xFFF5E9DD);
      case 'Consumer':
        return const Color(0xFFE2EFE6);
      case 'Digital':
        return const Color(0xFFD7E9FF);
      case 'Housing':
        return const Color(0xFFEAE3F8);
      default:
        return AppTheme.botticelli;
    }
  }

  // CATEGORY LABEL COLOURS

  // Returns a matching text colour for each of the category.
  // This helps the category labels stay consistent
  // with their respective icon backgrounds (must follow for all)
  Color getCategoryTextColor(String category) {
    switch (category) {
      case 'Employment':
        return AppTheme.beaver;
      case 'Consumer':
        return const Color(0xFF246B35);
      case 'Digital':
        return const Color(0xFF1766CC);
      case 'Housing':
        return const Color(0xFF51368B);
      default:
        return AppTheme.ebonyClay;
    }
  }


  // OPEN RIGHTS DETAILS
  // Opens the details page when a user selects an issue.
  // The selected RightsIssue object is passed to the next screen
  // so that the correct information can be displayed.
  void openIssue(RightsIssue issue) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RightsDetailsScreen(
          issue: issue,
        ),
      ),
    );
  }


  // TEMPORARY NAVIGATION MESSAGE

  // Displays a short message if the Home or Notes
  // navigation has not been connected yet.
  void showNavigationMessage(String destination) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

        content: Text('$destination will be connected later'),
        duration: const Duration(seconds: 2),

      ),
    );
  }


  // BUILD METHOD
  // Builds the overall layout of the Explore Rights screen.
  // Flutter calls this method again whenever the screen state changes.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Sets the background colour of the whole screen
      backgroundColor: const Color(0xFFFAF7F4),

      // TOP HEADER
      // AppBar provides the title and back button at the top.

      appBar: AppBar(
        toolbarHeight: 94,
        backgroundColor: AppTheme.beaver,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        // Rounds the bottom corners of the header.
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),

        // Back button to return to the previous screen.
        // If there is no previous screen then will use the Home callback

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 23,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              widget.onHomeTap?.call();
            }
          },
        ),

        title: const Text(
          'Explore Rights',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      // PAGE CONTENT

      // SafeArea prevents the content from overlapping
      // system areas such as the phone status bar.

      body: SafeArea(
        child: ListView(

          // Adds spacing around the page content.
          // ListView allows the whole page to scroll vertically
          // when the content does not fit on the screen.


          padding: const EdgeInsets.only(
            top: 18,
            bottom: 12,
          ),
          children: [

            // INTRODUCTION

            // Introduces the purpose of the Explore Rights screen.

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find information about\n'
                    'common rights issues',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Select a category or search for a '
                    'situation to learn more.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.beaver,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // CATEGORY FILTERS

            // Displays the four category buttons horizontally.
            // ListView.separated adds equal spacing between each button.

            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: categories.length,

                // Adds a small gap between category buttons


                separatorBuilder: (_, __) =>
                    const SizedBox(width: 7),

                // Builds each category button using its list position

                itemBuilder: (context, index) {
                  final category = categories[index];
                  return buildCategoryChip(category);
                },
              ),
            ),

            const SizedBox(height: 10),

            // COMMON ISSUES TITLE

            const Padding(
              padding: EdgeInsets.only(left: 40, bottom: 8),
              child: Text(
                'Common Issues',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // DYNAMIC ISSUE LIST

            // ListView.builder will create the issue cards based on
            // the filteredIssues list

            ListView.builder(

              // shrinkWrap allows this ListView to take only
              // the space required by its children.

              shrinkWrap: true,

              // Disables its own scrolling because the outer
              // ListView already handles vertical scrolling

              physics: const NeverScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),

              // Controls how many isue cards are displayed.

              itemCount: filteredIssues.length,

              // Builds each card using the corresponding issue data.

              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: buildIssueCard(filteredIssues[index]),
                );
              },
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION

      // Displays the Home, Explore and Notes navigation options.

      bottomNavigationBar: buildBottomNavigation(),
    );
  }


  // CATEGORY FILTER CHIP

  // Creates one clickable button for each rights category.

  Widget buildCategoryChip(String category) {

    // Checks whether this category is currently selected.

    // The result controls the button background and border colours

    final bool isSelected = selectedCategory == category;


    return Material(
      // Selected categories have a different background colour.

      color: isSelected
          ? AppTheme.malibu
          : const Color(0xFFF5F0EC),

      borderRadius: BorderRadius.circular(9),

      child: InkWell(
        borderRadius: BorderRadius.circular(9),

        // Runs when the user taps a category button.

        onTap: () {
          setState(() {

            // Updates the selected category.
            // Tapping the same category again removes the filter
            // and show all four rights issues.

            selectedCategory = isSelected ? null : category;
          });
        },

        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 6,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: isSelected
                  ? AppTheme.malibu
                  : const Color(0xFF958B86),
              width: 0.8,
            ),
          ),

          child: Row(
            // Keeps the button width based on its content.
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                getCategoryIcon(category),
                  size: 17,
                  color: Colors.black,

              ),

              const SizedBox(width: 5),

              Text(
                category,
                  style: TextStyle(
                     fontSize: 11,
                     fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                    color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // REUSABLE RIGHTS ISSUE CARD

  // Creates a card for each issue using the information
  // stored in the rights_data.dart file.

  Widget buildIssueCard(RightsIssue issue) {

    // Gets the correct icon background and label colour
    // based on the category of the current issue.

    final Color iconBackground =
        getCategoryBackground(issue.category);

    final Color labelColor =
        getCategoryTextColor(issue.category);

    // AnimatedIssueCard adds the hover and press effects
    // and will handle the tap before opening the details page.
    return AnimatedIssueCard(

      onTap: ()=> openIssue(issue),
      child:Material(
      color: AppTheme.cardWhite,
      borderRadius: BorderRadius.circular(10),

      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        child: Container(

          // Ensures that the card will haeve enough height for its contents

          constraints: const BoxConstraints(minHeight: 100),

          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),

          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black87,
              width: 0.9,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            children: [

              // LARGE PASTEL ICON CIRCLE
              // Displays an icon based on the issue category.

              Container(
                width: 73,
                height: 73,

                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  getCategoryIcon(issue.category),
                  size: 40,
                  color: labelColor,
                ),
              ),

              const SizedBox(width: 13),

              // ISSUE CONTENT

              // Expanded allows the text section to use
              // the remaining available horizontal space

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Displays the issue title from the data list.

                    Text(
                      issue.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // CATEGORY LABEL

                    // Displays the category using its matching colour.

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),

                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        issue.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: labelColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // ISSUE DESCRIPTION


                    // Displays a short explanation of the issue.

                    Text(
                      issue.description,
                      style: const TextStyle(

                        fontSize: 11,
                        height: 1.35,
                        color: AppTheme.beaver,

                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // RIGHT ARROW
              // Indicates that the card can be opened for more details.
              const Icon(
                Icons.chevron_right,
                size:27,
                color: Color(0xFF667080),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }


  // BOTTOM NAVIGATION BAR

  // Builds the navigation section at the bottom of the screen.
  Widget buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border:Border(
          top: BorderSide(
            color: Color(0xFFBEBEBE),
            width: 0.8,
          ),
        ),
      ),

      // SafeArea prevents the navigation bar from overlapping
      // the bottom system area of the device.
      child:SafeArea(
        top: false,

        child: SizedBox(
          height: 58,

          child: Row(
            children: [

              // HOME
              // Calls the Home navigation callback when tapped.
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (widget.onHomeTap != null) {
                      widget.onHomeTap!();
                    } else {
                      showNavigationMessage('Home');
                    }
                  },
                  child: const Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        size: 26,
                        color: Colors.black,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // EXPLORE which is CURRENT PAGE

              // Highlights Explore to show that this is
              // the page currently being viewed.
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7E9FF),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Icon(
                        Icons.search,
                        size: 25,
                        color: Color(0xFF1477F8),
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

              // NOTES
              // Calls the Notes navigation callback when tapped.
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (widget.onNotesTap != null) {
                      widget.onNotesTap!();
                    } else {
                      showNavigationMessage('Notes');
                    }
                  },

                  child: const Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 26,
                        color: Colors.black,
                      ),
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
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
}



// ANIMATED ISSUE CARD

// A separate StatefulWidget is used to manage the card animation.
// It allows each card to respond independently to mouse hovering
// and tapping without rebuilding the entire Explore Rights screen.

class AnimatedIssueCard extends StatefulWidget {

  // The child is the actual card design that will be animated.
  final Widget child;

  // This callback tells the card what to do after the animation.
  final VoidCallback onTap;

  const AnimatedIssueCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  // Creates the state object that controls the animation.
  @override
  State<AnimatedIssueCard> createState() =>
      _AnimatedIssueCardState();
}


class _AnimatedIssueCardState extends State<AnimatedIssueCard> {

  // Tracks whether the mouse pointer is currently over the card.
  bool isHovered = false;

  // Tracks whether the card is currently being pressed.
  bool isPressed = false;

  // Prevents the user from triggering multiple navigation actions
  // while the animation is still running.
  bool isOpening = false;

  // Determines the card size based on the current interaction.
  double get cardScale {
    if (isPressed){
      // Slightly shrinks the card when the user presses it.
      return 0.95;
    }

    if(isHovered){
      // Slightly enlarges the card when the mouse hovers over it.

      return 1.02;
    }

    // Returns the card to its original size.

    return 1.0;
  }


  // HANDLE CARD TAP
  // Creates a short press-and-bounce effect before navigation.
  Future<void> handleTap() async {

    // Stops repeated taps while the current animation is running.
    if (isOpening) return;

    isOpening = true;

    // Changes the card to its pressed size.
    setState(() {
      isPressed = true;
    });

    // Keeps the pressed effect visible briefly.
    await Future.delayed(
      const Duration(milliseconds: 120),
    );

    // Checks whether the widget is still active before
    // calling setState again.

    if(!mounted) return;

    // Changes the card back to its normal size.
    setState(() {
      isPressed = false;
    });

    // Allows the bounce-back animation to finish.
    await Future.delayed(
      const Duration(milliseconds: 180),
    );

    // Checks again before navigating to another screen.
    if (!mounted) return;

    // Opens the Rights Details page after the animation.
    widget.onTap();

    isOpening = false;
  }


  // BUILD ANIMATED CARD
  @override
  Widget build(BuildContext context) {
    return MouseRegion(

      // Detects when the mouse enters the card area.
      // This is mainly useful when running the app on a computer.
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      // Detects when the mouse leaves the card area.
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedScale(
        // Changes the card size based on cardScale.
        // AnimatedScale automatically creates a smooth transition.
        scale: cardScale,

        duration: const Duration(milliseconds: 160),

        // Creates a slight bounce effect during the size change.
        curve: Curves.easeOutBack,

        child: AnimatedContainer(
          // Animates the shadow when the card is hovered or pressed.
          duration: const Duration(milliseconds: 160),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            // Adds a shadow to make the card appear slightly raised.
            // The shadow disappears when the interaction ends.
            boxShadow: isHovered || isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),

          // InkWell provides the tap interaction and ripple effect.
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),

              // Runs the animation before opening the details page

              onTap: handleTap,
            

              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
