
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Shared service for checking network connectivity.
// Both the Dashboard and Connectivity screen use it.
class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService instance =
      ConnectivityService._();

  final Connectivity _connectivity = Connectivity();

  // null means the initial check has not finished.
  // true means a network type was detected.
  // false means no network connection was detected.
  final ValueNotifier<bool?> isConnected =
      ValueNotifier<bool?>(null);

  StreamSubscription<List<ConnectivityResult>>?
      _subscription;

  bool _started = false;

  // Starts listening for network changes.
  Future<void> start() async {
    if (_started) return;

    _started = true;

    _subscription = _connectivity
        .onConnectivityChanged
        .listen(
      _updateStatus,
      onError: (Object error) {
        debugPrint('Connectivity error: $error');
        isConnected.value = null;
      },
    );

    await refresh();
  }

  // Checks the current network connection.
  Future<void> refresh() async {
    try {
      final results =
          await _connectivity.checkConnectivity();

      _updateStatus(results);
    } catch (error) {
      debugPrint('Unable to check network: $error');
      isConnected.value = null;
    }
  }

  // Convert connection types to a simple status.
  void _updateStatus(List<ConnectivityResult> results) {
    isConnected.value = results.any(
      (result) => result != ConnectivityResult.none,
    );
  }

  // Stop the listener if the service is no longer needed.
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    _started = false;
  }
}
