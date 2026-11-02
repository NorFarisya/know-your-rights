import 'package:flutter/material.dart';

// Import the shared application colours to maintain
// consistent styling throughout the Know Ur Rights app.
import '../theme/app_colors.dart';

// Import reusable widgets used to build the Dashboard.
import '../widgets/rights_category_card.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/connectivity_status_card.dart';

// Import the screens used for Dashboard navigation.
import 'placeholder_screen.dart';
import 'my_notes_screen.dart';
import 'connectivity_screen.dart';

// ======================================================
// KNOW UR RIGHTS - DASHBOARD SCREEN
// ======================================================
// The Dashboard is the main homepage displayed after
// the user completes the login process.
//
// It provides an introduction to the application,
// access to four rights categories, bottom navigation
// and the current network connectivity status.
//
// StatelessWidget is used because the Dashboard itself
// does not manage any changing data.
//
// Connectivity updates are handled separately by the
// reusable ConnectivityStatusCard widget.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // ----------------------------------------------------
  // 1. TEMPORARY SCREEN NAVIGATION
  // ----------------------------------------------------
  // Opens a temporary placeholder screen for features
  // that have not yet been integrated into the project.
  // This allows the Dashboard navigation to be tested
  // before all group members' screens are connected.
  // The optional category parameter identifies which
  // rights category was selected by the user.
  void _openPlaceholder(
    BuildContext context,
    String title, {
    String? category,
  }) {

    // Navigator.push opens a new screen while keeping
    // the current Dashboard in the navigation stack.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(
          title: title,
          category: category,
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 2. MY NOTES NAVIGATION
  // ----------------------------------------------------
  // Opens the My Notes screen when users select
  // Notes from the bottom navigation bar.
  // My Notes allows users to view, create and edit
  // their personal notes during the application session.
  void _openMyNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyNotesScreen(),
      ),
    );
  }

  // ----------------------------------------------------
  // 3. CONNECTIVITY STATUS NAVIGATION
  // ----------------------------------------------------
  // Opens the full Connectivity Status screen when
  // the user taps the Dashboard connectivity card.
  // The Connectivity Status screen displays network
  // information and explains offline accessibility.
  void _openConnectivity(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConnectivityScreen(),
      ),
    );
  }

  // ----------------------------------------------------
  // 4. BUILD MAIN DASHBOARD SCREEN
  // ----------------------------------------------------
  // Builds the Dashboard interface containing the
  // welcome section, introduction, rights categories,
  // connectivity card and bottom navigation.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the Dashboard background using the
      // shared application colour palette.
      backgroundColor: AppColors.background,

      // ------------------------------------------------
      // 5. BOTTOM NAVIGATION BAR
      // ------------------------------------------------
      // AppBottomNavigation is a reusable widget
      // shared between the Dashboard and My Notes.
      // currentIndex: 0 indicates that Home is the
      // currently selected navigation destination.
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 0,

        // Handle navigation when users select an item
        // from the bottom navigation bar.
        onTap: (index) {

          // Index 0 represents the Home/Dashboard tab.
          // No navigation is needed because users
          // are already viewing the Dashboard.
          if (index == 0) {
            return;
          }
          // Index 1 represents Explore Rights.
          //
          // A placeholder is used temporarily until
          // Sai's Explore Rights screen is integrated.
          if (index == 1) {
            _openPlaceholder(
              context,
              'Explore Rights',
            );
          }

          // Index 2 represents My Notes.
          //
          // Opens the actual My Notes screen.
          if (index == 2) {
            _openMyNotes(context);
          }
        },
      ),

      // ------------------------------------------------
      // 6. MAIN DASHBOARD CONTENT
      // ------------------------------------------------
      // SafeArea prevents Dashboard content from
      // overlapping the device's status bar and edges.
      body: SafeArea(

        // SingleChildScrollView allows the Dashboard
        // content to scroll on smaller screen sizes.
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 24,
          ),

          // Column arranges the Dashboard components
          // vertically from top to bottom.
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // Display the welcome message and
              // temporary profile navigation button.
              _buildWelcomeCard(context),

              const SizedBox(height: 20),

              // Display introductory information
              // about the Know Ur Rights application.
              _buildIntroCard(),

              const SizedBox(height: 28),

              // ------------------------------------
              // 7. RIGHTS CATEGORY SECTION HEADING
              // ------------------------------------
              // Introduces the four main rights
              // categories available in the application.
              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),

              const SizedBox(height: 12),

              // ------------------------------------
              // 8. FIRST CATEGORY ROW: EMPLOYMENT AND CONSUMER
              // ------------------------------------
              // Row displays two rights category cards
              // horizontally within the Dashboard.
              //
              // Expanded allows each card to share
              // the available horizontal screen space.
              Row(
                children: [

                  // EMPLOYMENT RIGHTS CATEGORY
                  //
                  // Provides access to information
                  // about common workplace concerns.
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Employment',
                      subtitle: 'Workplace issues',
                      icon: Icons.work_outline,

                      // Keep the original Dashboard
                      // employment category colour.
                      backgroundColor:
                          const Color(0xFFE8D6C4),

                      // Open the Employment category
                      // placeholder when tapped.
                      onTap: () {
                        _openPlaceholder(
                          context,
                          'Explore Rights',
                          category: 'Employment',
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // CONSUMER RIGHTS CATEGORY
                  // Provides access to information
                  // about purchases and refund issues.
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Consumer',
                      subtitle: 'Purchases & refunds',
                      icon: Icons.shopping_cart_outlined,

                      backgroundColor:
                          AppColors.consumer,

                      // Open the Consumer category
                      // placeholder when tapped.
                      onTap: () {
                        _openPlaceholder(
                          context,
                          'Explore Rights',
                          category: 'Consumer',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ------------------------------------
              // 9. SECOND CATEGORY ROW: DIGITAL AND HOUSING
              // ------------------------------------
              // Displays the remaining two rights
              // categories in a horizontal Row.
              Row(
                children: [

                  // DIGITAL RIGHTS CATEGORY
                  // Provides access to information
                  // about digital safety and privacy.
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Digital',
                      subtitle: 'Online safety',
                      icon: Icons.verified_user_outlined,

                      backgroundColor:
                          AppColors.digital,

                      // Open the Digital category
                      // placeholder when tapped.
                      onTap: () {
                        _openPlaceholder(
                          context,
                          'Explore Rights',
                          category: 'Digital',
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // HOUSING RIGHTS CATEGORY
                  // Provides access to information
                  // about rental and tenancy concerns.
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Housing',
                      subtitle: 'Rent & tenancy',
                      icon: Icons.home_outlined,

                      backgroundColor:
                          AppColors.housing,

                      // Open the Housing category
                      // placeholder when tapped.
                      onTap: () {
                        _openPlaceholder(
                          context,
                          'Explore Rights',
                          category: 'Housing',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // ------------------------------------
              // 10. CONNECTIVITY STATUS CARD
              // ------------------------------------
              // Display the reusable ConnectivityStatusCard
              // imported from connectivity_status_card.dart.
              //
              // The card receives network status updates
              // from the shared ConnectivityService.
              //
              // Tapping the card opens the full
              // Connectivity Status screen.
              ConnectivityStatusCard(
                onTap: () {
                  _openConnectivity(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 11. DASHBOARD WELCOME CARD
  // ----------------------------------------------------
  // Creates the brown welcome card displayed at the
  // top of the Dashboard.
  // The design follows the group's Canva mockup.
  // It contains the application name, greeting,
  // introductory tagline and profile button.
  Widget _buildWelcomeCard(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      // BoxDecoration applies the brown background
      // and rounded corners to the welcome card.
      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(20),
      ),

      // Row positions the welcome information and
      // profile button horizontally.
      child: Row(
        children: [

          // Expanded allows the welcome text to
          // use the remaining available width.
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Application name.
                Text(
                  'KNOW YOUR RIGHTS',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),

                SizedBox(height: 6),

                // Main welcome message.
                Text(
                  'Hello, welcome!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                // Application tagline.
                Text(
                  'Understand your rights, '
                  'one step at a time.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ------------------------------------
          // 12. PROFILE BUTTON
          // ------------------------------------
          // CircleAvatar creates a circular background
          // around the profile button.
          // A temporary placeholder is used until
          // the group integrates the profile feature.
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.cream,

            // IconButton makes the profile icon clickable.
            child: IconButton(
              tooltip: 'Profile',

              icon: const Icon(
                Icons.person_outline,
                color: AppColors.navy,
                size: 29,
              ),

              // Open the temporary Profile screen.
              onPressed: () {
                _openPlaceholder(
                  context,
                  'Profile',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 13. DASHBOARD INTRODUCTION CARD
  // ----------------------------------------------------
  // Creates the introductory summary card displayed
  // below the Dashboard welcome header.
  //
  // This section explains the application's purpose
  // and encourages users to explore common legal
  // issues in Malaysia.
  Widget _buildIntroCard() {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      // Use the shared blue-grey colour and rounded
      // corners to match the group's visual design.
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(18),
      ),

      // Row places the book icon beside
      // the introductory information.
      child: const Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // Book icon represents rights-related
          // information and learning resources.
          Icon(
            Icons.menu_book_outlined,
            size: 23,
          ),

          SizedBox(width: 8),

          // Expanded allows the description to wrap
          // naturally within the available screen width.
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Introduction heading.
                Text(
                  'Your rights, made simple',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                // Brief explanation of the application.
                Text(
                  'Explore common legal issues in Malaysia '
                  'and learn about possible next steps.',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
