
import 'package:flutter/material.dart';

import '../services/connectivity_service.dart';

// Full Connectivity Status screen.
// It automatically updates when the device network changes.
class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({super.key});

  @override
  State<ConnectivityScreen> createState() =>
      _ConnectivityScreenState();
}

class _ConnectivityScreenState
    extends State<ConnectivityScreen> {
  static const brown = Color(0xFF90725D);
  static const navy = Color(0xFF2F3547);
  static const background = Color(0xFFFAF6F2);
  static const blueGrey = Color(0xFFCED9E4);

  @override
  void initState() {
    super.initState();
    ConnectivityService.instance.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: ValueListenableBuilder<bool?>(
          valueListenable:
              ConnectivityService.instance.isConnected,
          builder: (context, connected, child) {
            final online = connected == true;
            final checking = connected == null;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20, 24, 20, 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 26),

                  _buildStatusCard(online, checking),

                  const SizedBox(height: 26),

                  _buildAccessCard(online, checking),

                  const SizedBox(height: 26),

                  _buildInfoCard(online, checking),

                  const SizedBox(height: 18),

                  // Allows users to manually check again.
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        ConnectivityService.instance
                            .refresh();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Status'),
                      style: TextButton.styleFrom(
                        foregroundColor: brown,
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

  // Brown heading matching the Canva mockup.
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: brown,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Connectivity Status',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Check your current network connection.',
                  style: TextStyle(
                    color: Colors.white,
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

  // Green card when connected, warm beige when offline.
  Widget _buildStatusCard(bool online, bool checking) {
    final color = checking
        ? navy
        : online
            ? const Color(0xFF387455)
            : const Color(0xFFA45B46);

    final cardColor = checking
        ? blueGrey
        : online
            ? const Color(0xFFE4F0E7)
            : const Color(0xFFF1E3DC);

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
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
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

  // Reusable information row with a status icon.
  Widget _accessItem(
    String message, {
    bool warning = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            warning
                ? Icons.error_outline
                : Icons.check_circle_outline,
            color: warning
                ? const Color(0xFFA45B46)
                : const Color(0xFF387455),
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                color: navy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Explains which app features remain available.
  Widget _buildAccessCard(bool online, bool checking) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: navy,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            online && !checking
                ? 'What can you access?'
                : 'What can you still access?',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          _accessItem(
            'Browse rights information stored in the app.',
          ),

          _accessItem(
            'Create and edit temporary notes.',
          ),

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

  // Blue information box shared by both states.
  Widget _buildInfoCard(bool online, bool checking) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 21,
            color: navy,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  checking || online
                      ? 'Good to know'
                      : "You're still supported",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Essential rights information stored '
                  'within the application remains '
                  'accessible without a network connection.',
                  style: TextStyle(
                    fontSize: 12,
                    color: navy,
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
