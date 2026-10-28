
import 'package:flutter/material.dart';

import '../services/connectivity_service.dart';

// Small reusable card for the Dashboard.
// It updates automatically when connectivity changes.
class ConnectivityStatusCard extends StatefulWidget {
  final VoidCallback onTap;

  const ConnectivityStatusCard({
    super.key,
    required this.onTap,
  });

  @override
  State<ConnectivityStatusCard> createState() =>
      _ConnectivityStatusCardState();
}

class _ConnectivityStatusCardState
    extends State<ConnectivityStatusCard> {
  static const navy = Color(0xFF2F3547);

  @override
  void initState() {
    super.initState();

    // Start observing network availability.
    ConnectivityService.instance.start();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable:
          ConnectivityService.instance.isConnected,
      builder: (context, connected, child) {
        final isOnline = connected == true;
        final isChecking = connected == null;

        final title = isChecking
            ? 'Checking Connection...'
            : isOnline
                ? 'Network Connected'
                : 'You are Offline';

        final message = isChecking
            ? 'Checking your device network status.'
            : isOnline
                ? 'Rights information is available offline. '
                    'External resources may require internet access.'
                : 'Rights information is available offline. '
                    'External websites may be unavailable.';

        final statusColor = isOnline
            ? const Color(0xFF387455)
            : const Color(0xFFA45B46);

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: navy),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    isChecking
                        ? Icons.sync
                        : isOnline
                            ? Icons.wifi
                            : Icons.wifi_off,
                    color: isChecking
                        ? navy
                        : statusColor,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    color: navy,
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
