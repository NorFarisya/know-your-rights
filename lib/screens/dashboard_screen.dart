
import 'package:flutter/material.dart';

// Import reusable widgets from separate Dart files.
import '../widgets/rights_category_card.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/connectivity_status_card.dart';

// Import the screens used for navigation.
import 'placeholder_screen.dart';
import 'my_notes_screen.dart';
import 'connectivity_screen.dart';

// Group colour palette for Know Your Rights.
class AppColors {
  static const brown = Color(0xFF90725D);
  static const cream = Color(0xFFEBDBCB);
  static const navy = Color(0xFF2F3547);
  static const blueGrey = Color(0xFFCED9E4);
  static const blue = Color(0xFF95C2F9);
  static const background = Color(0xFFFAF6F2);
}

// Dashboard is the main homepage after login.
// StatelessWidget is used because the Dashboard layout
// does not manage its own changing data.
//
// Connectivity updates are handled separately inside
// the reusable ConnectivityStatusCard widget.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // ------------------------------------------------
  // TEMPORARY NAVIGATION
  // ------------------------------------------------

  // Opens placeholder screens for unfinished features.
  // Later, we can replace these destinations with
  // the actual screens created by group members.
  void _openPlaceholder(
    BuildContext context,
    String title, {
    String? category,
  }) {
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

  // ------------------------------------------------
  // MY NOTES NAVIGATION
  // ------------------------------------------------

  // Opens the actual My Notes screen.
  void _openMyNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyNotesScreen(),
      ),
    );
  }

  // ------------------------------------------------
  // CONNECTIVITY NAVIGATION
  // ------------------------------------------------

  // Opens the real Connectivity Status screen.
  // The screen updates according to network availability.
  void _openConnectivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConnectivityScreen(),
      ),
    );
  }

  // ------------------------------------------------
  // MAIN DASHBOARD SCREEN
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Reusable bottom navigation.
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 0,

        onTap: (index) {
          if (index == 0) {
            // Already on Home / Dashboard.
            return;
          }

          if (index == 1) {
            // Sai's Explore Rights screen will be
            // connected when the group code is integrated.
            _openPlaceholder(
              context,
              'Explore Rights',
            );
          }

          if (index == 2) {
            // Open our actual My Notes screen.
            _openMyNotes(context);
          }
        },
      ),

      // SafeArea prevents content from overlapping
      // system status bars and screen edges.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20, 24, 20, 24,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Welcome header with profile button.
              _buildWelcomeCard(context),

              const SizedBox(height: 20),

              // Introductory information.
              _buildIntroCard(),

              const SizedBox(height: 28),

              // Category section heading.
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
              // FIRST ROW: EMPLOYMENT AND CONSUMER
              // ------------------------------------

              Row(
                children: [
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Employment',
                      subtitle: 'Workplace issues',
                      icon: Icons.work_outline,

                      backgroundColor:
                          const Color(0xFFE8D6C4),

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

                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Consumer',
                      subtitle: 'Purchases & refunds',
                      icon: Icons.shopping_cart_outlined,

                      backgroundColor:
                          const Color(0xFFE3F0E6),

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
              // SECOND ROW: DIGITAL AND HOUSING
              // ------------------------------------

              Row(
                children: [
                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Digital',
                      subtitle: 'Online safety',
                      icon: Icons.verified_user_outlined,

                      backgroundColor:
                          const Color(0xFFD7E9FF),

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

                  Expanded(
                    child: RightsCategoryCard(
                      title: 'Housing',
                      subtitle: 'Rent & tenancy',
                      icon: Icons.home_outlined,

                      backgroundColor:
                          const Color(0xFFE8E0F8),

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
              // REAL CONNECTIVITY STATUS CARD
              // ------------------------------------

              // This widget is imported from:
              // lib/widgets/connectivity_status_card.dart
              //
              // It listens for network changes through
              // the shared ConnectivityService.
              //
              // Clicking it opens the full Connectivity
              // Status screen.
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

  // ------------------------------------------------
  // WELCOME CARD
  // ------------------------------------------------

  // Brown welcome header based on our Canva design.
  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'KNOW YOUR RIGHTS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'Hello, welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'Understand your rights, '
                  'one step at a time.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Profile button uses a temporary placeholder.
          // It can be connected to the group profile
          // screen later.
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.cream,

            child: IconButton(
              tooltip: 'Profile',

              icon: const Icon(
                Icons.person_outline,
                color: AppColors.navy,
                size: 29,
              ),

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

  // ------------------------------------------------
  // INTRODUCTORY SUMMARY CARD
  // ------------------------------------------------

  // Explains what Know Your Rights can help users do.
  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(18),
      ),

      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 23,
          ),

          SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Your rights, made simple',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

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
