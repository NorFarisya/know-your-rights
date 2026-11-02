
import 'package:flutter/material.dart';

import '../data/rights_data.dart';
import '../models/rights_issue.dart';
import '../theme/app_theme.dart';
import 'rights_details_screen.dart'; //add to take the rights details

// Explore Rights Screen
// Displays rights issues and filters them by category.
class ExploreRightsScreen extends StatefulWidget {
  final String? initialCategory;

  // These callbacks will connect to the group's navigation later.
  final VoidCallback? onHomeTap;
  final VoidCallback? onNotesTap;

  const ExploreRightsScreen({
    super.key,
    this.initialCategory,
    this.onHomeTap,
    this.onNotesTap,
  });

  @override
  State<ExploreRightsScreen> createState() =>
      _ExploreRightsScreenState();
}

class _ExploreRightsScreenState
    extends State<ExploreRightsScreen> {

  String? selectedCategory;

  final List<String> categories = [
    'Employment',
    'Consumer',
    'Digital',
    'Housing',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : null;
  }

  // Returns the issues belonging to the selected category.
  // A null category means all issues are displayed.
  List<RightsIssue> get filteredIssues {
    if (selectedCategory == null) {
      return rightsIssues;
    }

    return rightsIssues
        .where((issue) => issue.category == selectedCategory)
        .toList();
  }

  // Icons used in the Canva design.
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

  // Pastel backgrounds for the issue icons.
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

  // Category label colours.
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


// Opens the Rights Details page for the selected issue.
// The selected RightsIssue object is passed to the next screen.
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


  // Temporary navigation feedback.
  void showNavigationMessage(String destination) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$destination will be connected later'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),

      // TOP HEADER
      appBar: AppBar(
        toolbarHeight: 94,
        backgroundColor: AppTheme.beaver,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 12,
          ),
          children: [

            // INTRODUCTION
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
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 7),
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

            // DYNAMIC SCROLLING LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              itemCount: filteredIssues.length,
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
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  // CATEGORY FILTER CHIP
  Widget buildCategoryChip(String category) {
    final bool isSelected = selectedCategory == category;

    return Material(
      color: isSelected
          ? AppTheme.malibu
          : const Color(0xFFF5F0EC),

      borderRadius: BorderRadius.circular(9),

      child: InkWell(
        borderRadius: BorderRadius.circular(9),

        onTap: () {
          setState(() {
            // Tapping the selected category again clears the filter.
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
  Widget buildIssueCard(RightsIssue issue) {
    final Color iconBackground =
        getCategoryBackground(issue.category);

    final Color labelColor =
        getCategoryTextColor(issue.category);

    return AnimatedIssueCard(
      onTap: ()=> openIssue(issue),
      child:Material(
      color: AppTheme.cardWhite,
      borderRadius: BorderRadius.circular(10),

      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        child: Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
              const Icon(
                Icons.chevron_right,
                size: 27,
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
  Widget buildBottomNavigation() {
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
            children: [

              // HOME
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

              // EXPLORE - CURRENT PAGE
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

//animation for the categories

 
 // ANIMATED ISSUE CARD
 // Creates a short press-and-bounce effect before navigation.

class AnimatedIssueCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedIssueCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<AnimatedIssueCard> createState() =>
      _AnimatedIssueCardState();
}

class _AnimatedIssueCardState extends State<AnimatedIssueCard> {
  bool isHovered = false;
  bool isPressed = false;
  bool isOpening = false;

  double get cardScale {
    if (isPressed) {
      return 0.95;
    }

    if (isHovered) {
      return 1.02;
    }

    return 1.0;
  }

  Future<void> handleTap() async {
    if (isOpening) return;

    isOpening = true;

    // Hold the pressed effect briefly.
    setState(() {
      isPressed = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 120),
    );

    if (!mounted) return;

    // Bounce back to normal size.
    setState(() {
      isPressed = false;
    });

    await Future.delayed(
      const Duration(milliseconds: 180),
    );

    if (!mounted) return;

    // Open Rights Details after the animation.
    widget.onTap();

    isOpening = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedScale(
        scale: cardScale,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutBack,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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

          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: handleTap,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
