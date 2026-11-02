import 'package:flutter/material.dart';

// Import the shared connectivity service to check
// and monitor changes in the device network connection.
import '../services/connectivity_service.dart';

// Import the shared application colours to maintain
// consistent styling throughout the Know Ur Rights app.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - CONNECTIVITY STATUS SCREEN
// ======================================================
// This screen displays detailed information about the
// device's current network connectivity status.
// It helps users understand which application features
// remain accessible when the device is offline.
// The screen automatically updates whenever the
// network connection changes.
class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({super.key});

  @override
  State<ConnectivityScreen> createState() =>
      _ConnectivityScreenState();
}

// ======================================================
// CONNECTIVITY SCREEN STATE
// ======================================================

// StatefulWidget is used because this screen starts
// network monitoring when it is first created.
//
// ValueListenableBuilder automatically rebuilds the
// interface whenever the connectivity status changes.
class _ConnectivityScreenState
    extends State<ConnectivityScreen> {

  // ----------------------------------------------------
  // 1. INITIALIZE CONNECTIVITY MONITORING
  // ----------------------------------------------------
  // initState runs once when the screen is created.
  //
  // It starts the shared ConnectivityService to monitor
  // the device's network connection.
  @override
  void initState() {
    super.initState();

    // Start listening for network connectivity changes.
    ConnectivityService.instance.start();
  }

  // ----------------------------------------------------
  // 2. BUILD MAIN CONNECTIVITY SCREEN
  // ----------------------------------------------------
  // Builds the main screen layout and displays the
  // current connectivity information.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Use the shared background colour.
      backgroundColor: AppColors.background,

      // SafeArea prevents content from overlapping
      // the device's status bar and screen edges.
      body: SafeArea(

        // ValueListenableBuilder listens to the current
        // connectivity status from ConnectivityService.
        // When the network status changes, the screen
        // automatically rebuilds with updated information.
        child: ValueListenableBuilder<bool?>(
          valueListenable:
              ConnectivityService.instance.isConnected,

          builder: (context, connected, child) {

            // Check whether a network connection is detected.
            final online = connected == true;

            // Check whether the network status is unknown
            // or the initial connection check is pending.
            final checking = connected == null;

            // SingleChildScrollView allows the content
            // to scroll on devices with smaller screens.
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20, 24, 20, 28,
              ),

              // Column arranges the screen components
              // vertically from top to bottom.
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // Display the screen title and back button.
                  _buildHeader(),

                  const SizedBox(height: 26),

                  // Display the current connectivity status.
                  _buildStatusCard(online, checking),

                  const SizedBox(height: 26),

                  // Explain which features users can access.
                  _buildAccessCard(online, checking),

                  const SizedBox(height: 26),

                  // Display additional offline access information.
                  _buildInfoCard(online, checking),

                  const SizedBox(height: 18),

                  // ------------------------------------
                  // 3. REFRESH CONNECTIVITY BUTTON
                  // ------------------------------------
                  // Allows users to manually check their
                  // current network connectivity status.
                  Center(
                    child: TextButton.icon(
                      // Calls refresh() from ConnectivityService
                      // when the user taps the button.
                      onPressed: () {
                        ConnectivityService.instance
                            .refresh();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Status'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.brown,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // 4. CONNECTIVITY SCREEN HEADER
  // ----------------------------------------------------
  // Creates the brown header displayed at the top
  // of the Connectivity Status screen.
  // The header contains a back button, screen title
  // and a short description.
  Widget _buildHeader() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),

      decoration: BoxDecoration(
        color: AppColors.brown,
        borderRadius: BorderRadius.circular(15),
      ),

      // Row arranges the back button and heading
      // horizontally within the header.
      child: Row(
        children: [
          // Back button returns users to the
          // previous screen using Navigator.pop.
          IconButton(
            tooltip: 'Back',

            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
            ),

            onPressed: () => Navigator.pop(context),
          ),

          // Expanded allows the heading to occupy
          // the remaining horizontal space.
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Main screen title.
                Text(
                  'Connectivity Status',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),

                SizedBox(height: 5),

                // Short description of the screen.
                Text(
                  'Check your current network connection.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 5. CONNECTIVITY STATUS CARD
  // ----------------------------------------------------
  // Creates a status card based on the device's
  // current network connectivity.
  //
  // The card displays different icons, colours and
  // messages for connected, offline and checking states.
  Widget _buildStatusCard(bool online, bool checking) {

    // Determine the status text and icon colour.
    //
    // Navy  = Connection status is being checked
    // Green = Network connection detected
    // Brown = No network connection detected
    final color = checking
        ? AppColors.navy
        : online
            ? AppColors.online
            : AppColors.offline;

    // Determine the background colour for the
    // connectivity status card.
    final cardColor = checking
        ? AppColors.blueGrey
        : online
            ? const Color(0xFFE4F0E7)
            : const Color(0xFFF1E3DC);

    // Container creates the rounded status card.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      // Column arranges the icon, title and description
      // vertically inside the status card.
      child: Column(
        children: [
          // ------------------------------------
          // CONNECTIVITY STATUS ICON
          // ------------------------------------
          // CircleAvatar creates a circular background
          // for the current connectivity status icon.
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.white,

            child: Icon(
              checking
                  ? Icons.sync
                  : online
                      ? Icons.wifi
                      : Icons.wifi_off,

              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 16),

          // ------------------------------------
          // CONNECTIVITY STATUS TITLE
          // ------------------------------------
          // Displays a title according to the
          // detected network connectivity status.
          Text(
            checking
                ? 'Checking Connection...'
                : online
                    ? 'Network Connected'
                    : "You're Offline",

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 8),

          // ------------------------------------
          // CONNECTIVITY STATUS DESCRIPTION
          // ------------------------------------
          // Displays a short explanation of the
          // device's current network connection.
          Text(
            checking
                ? 'Checking your device network status.'
                : online
                    ? 'A network connection is detected.'
                    : 'No network connection detected.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 6. REUSABLE ACCESS INFORMATION ROW
  // ----------------------------------------------------
  // Creates a reusable information row containing
  // a status icon and description.
  //
  // The warning parameter determines whether the
  // row displays a warning icon or a check icon.
  Widget _accessItem(
    String message, {
    bool warning = false,
  }) {

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      // Row positions the status icon beside the text.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display a warning icon or success icon
          // depending on the warning parameter.
          Icon(
            warning
                ? Icons.error_outline
                : Icons.check_circle_outline,

            color: warning
                ? AppColors.offline
                : AppColors.online,

            size: 21,
          ),
          const SizedBox(width: 10),

          // Expanded prevents long descriptions
          // from overflowing the screen width.
          Expanded(
            child: Text(
              message,

              style: const TextStyle(
                fontSize: 13,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 7. AVAILABLE FEATURES CARD
  // ----------------------------------------------------
  // Displays information about which application
  // features users can access based on connectivity.
  //
  // Essential locally stored information and temporary
  // notes remain accessible without a network connection.
  //
  // External resources may require internet access.
  Widget _buildAccessCard(bool online, bool checking) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: AppColors.white,

        border: Border.all(
          color: AppColors.navy,
          width: 0.7,
        ),

        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Display a heading based on the
          // current connectivity status.
          Text(
            online && !checking
                ? 'What can you access?'
                : 'What can you still access?',

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),

          // ------------------------------------
          // ACCESSIBLE OFFLINE FEATURES
          // ------------------------------------
          // Locally stored rights information remains
          // available without an internet connection.
          _accessItem(
            'Browse rights information stored in the app.',
          ),

          // Users can create and edit temporary notes
          // because notes use local application memory.
          _accessItem(
            'Create and edit temporary notes.',
          ),

          // ------------------------------------
          // EXTERNAL RESOURCE ACCESS
          // ------------------------------------
          // Show different information depending on
          // whether a network connection is detected.
          if (online && !checking)
            _accessItem(
              'Open external resources when internet '
              'access is available.',
            )
          else
            _accessItem(
              'External websites may be unavailable.',
              warning: true,
            ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 8. ADDITIONAL INFORMATION CARD
  // ----------------------------------------------------
  // Displays an informational message explaining
  // the application's offline accessibility.
  //
  // This supports the purpose of Know Ur Rights by
  // informing users that essential rights information
  // can still be read without network connectivity.
  Widget _buildInfoCard(bool online, bool checking) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // Information icon.
          const Icon(
            Icons.info_outline,
            size: 21,
            color: AppColors.navy,
          ),

          const SizedBox(width: 10),

          // Expanded allows the information text
          // to adjust to different screen widths.
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Display a heading depending on
                // the current connectivity status.
                Text(
                  checking || online
                      ? 'Good to know'
                      : "You're still supported",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.navy,
                  ),
                ),

                const SizedBox(height: 5),

                // Explain that essential locally stored
                // rights information remains available
                // even without network connectivity.
                const Text(
                  'Essential rights information stored '
                  'within the application remains '
                  'accessible without a network connection.',

                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.navy,
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
