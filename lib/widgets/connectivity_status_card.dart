import 'package:flutter/material.dart';

// Import the shared connectivity service to detect
// changes in the device's network connection.
import '../services/connectivity_service.dart';

// Import the shared application colours to maintain
// consistent styling across the Know Ur Rights app.
import '../theme/app_colors.dart';

// ======================================================
// KNOW UR RIGHTS - CONNECTIVITY STATUS CARD
// ======================================================
// This reusable widget displays the current network connectivity status on the Dashboard.
// The card updates automatically whenever the device's network connectivity changes.
// Users can also tap the card to open the full Connectivity Status screen.
class ConnectivityStatusCard extends StatefulWidget {
  // ----------------------------------------------------
  // 1. NAVIGATION CALLBACK
  // ----------------------------------------------------
  // This callback is provided by the Dashboard.
  // It determines what happens when the user taps the Connectivity Status card.
  final VoidCallback onTap;

  const ConnectivityStatusCard({
    super.key,
    required this.onTap,
  });

  @override
  State<ConnectivityStatusCard> createState() =>
      _ConnectivityStatusCardState();
}

// ======================================================
// CONNECTIVITY STATUS CARD STATE
// ======================================================
// StatefulWidget is used because this widget starts connectivity monitoring when it is first created.
// The displayed information is updated automatically
// through ValueListenableBuilder.
class _ConnectivityStatusCardState
    extends State<ConnectivityStatusCard> {

  // ----------------------------------------------------
  // 2. INITIALIZE CONNECTIVITY MONITORING
  // ----------------------------------------------------
  // initState runs once when the widget is created.
  // It starts the shared ConnectivityService so the
  // application can detect network connection changes.
  @override
  void initState() {
    super.initState();

    // Start monitoring the device's network availability.
    ConnectivityService.instance.start();
  }

  // ----------------------------------------------------
  // 3. BUILD CONNECTIVITY STATUS CARD
  // ----------------------------------------------------
  // Builds the Dashboard card based on the current network connectivity status.
  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder listens to the shared
    // connectivity status stored in ConnectivityService.
    // Whenever isConnected changes, the card rebuilds
    // automatically to display the updated information.
    return ValueListenableBuilder<bool?>(
      valueListenable:
          ConnectivityService.instance.isConnected,

      builder: (context, connected, child) {

        // Check whether a network connection is detected.
        final isOnline = connected == true;

        // Check whether the connectivity status is unknown or the initial check has not completed.
        final isChecking = connected == null;

        // ------------------------------------------------
        // 4. DETERMINE STATUS TITLE
        // ------------------------------------------------
        // Display a different title depending on whether
        // the device is connected, disconnected or checking.
        final title = isChecking
            ? 'Checking Connection...'
            : isOnline
                ? 'Network Connected'
                : 'You are Offline';

        // ------------------------------------------------
        // 5. DETERMINE STATUS MESSAGE
        // ------------------------------------------------
        // Explain which resources are available based
        // on the detected network connection.
        // Essential rights information remains accessible
        // offline because it is stored within the app.
        final message = isChecking
            ? 'Checking your device network status.'
            : isOnline
                ? 'Rights information is available offline. '
                    'External resources may require internet access.'
                : 'Rights information is available offline. '
                    'External websites may be unavailable.';

        // ------------------------------------------------
        // 6. DETERMINE STATUS COLOUR
        // ------------------------------------------------
        // Use green when a network connection is detected.
        // Use warm brown when the device is disconnected.
        // Colours are retrieved from the shared AppColors
        // class to maintain consistency.
        final statusColor = isOnline
            ? AppColors.online
            : AppColors.offline;

        // ------------------------------------------------
        // 7. CONNECTIVITY CARD DESIGN
        // ------------------------------------------------
        // Material provides the background and supports
        // the InkWell touch interaction.
        return Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),

          // InkWell makes the entire card clickable.
          // The navigation action is defined by the parent Dashboard through widget.onTap.
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(18),

            // Container controls the card size, spacing, border and rounded corners.
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.navy,
                ),
                borderRadius: BorderRadius.circular(18),
              ),

              // Row arranges the connectivity icon,
              // status information and arrow horizontally.
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ------------------------------------
                  // 8. CONNECTIVITY STATUS ICON
                  // ------------------------------------
                  // Display a different icon depending on the current connectivity status.
                  Icon(
                    isChecking
                        ? Icons.sync
                        : isOnline
                            ? Icons.wifi
                            : Icons.wifi_off,

                    color: isChecking
                        ? AppColors.navy
                        : statusColor,
                  ),

                  // Add spacing between the icon and text.
                  const SizedBox(width: 10),

                  // ------------------------------------
                  // 9. CONNECTIVITY INFORMATION
                  // ------------------------------------
                  // Expanded allows the text section to use the remaining horizontal space.
                  // This helps prevent text overflow on devices with smaller screens.
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        // Display the current network connectivity status title.
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Display additional information about the detected connection.
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ------------------------------------
                  // 10. NAVIGATION ARROW
                  // ------------------------------------
                  // Indicates that the user can tap the card to view more connectivity details.
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.navy,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
