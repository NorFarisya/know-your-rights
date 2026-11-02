
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ======================================================
// KNOW UR RIGHTS - CONNECTIVITY SERVICE
// ======================================================
// This service manages the network connectivity statusof the Know Ur Rights application.
// It is shared between the Dashboard and Connectivity Status screen so both screens receive the same status.
// A singleton pattern is used to ensure that only one ConnectivityService instance manages network changes.
class ConnectivityService {
  // ----------------------------------------------------
  // 1. SINGLETON INSTANCE
  // ----------------------------------------------------
  // Private constructor prevents other classes from
  // creating separate instances of this service.
  ConnectivityService._();

  // Provides one shared instance that can be accessed
  // from different screens throughout the application.
  static final ConnectivityService instance =
      ConnectivityService._();

  // ----------------------------------------------------
  // 2. CONNECTIVITY VARIABLES
  // ----------------------------------------------------
  // Creates an instance of Connectivity from the
  // connectivity_plus package to check network status.
  final Connectivity _connectivity = Connectivity();

  // Stores the current connectivity status.
  //
  // null  = Initial connection check is still pending
  // true  = A network connection type is detected
  // false = No network connection is detected.
  // ValueNotifier automatically notifies listening
  // widgets whenever the status value changes.
  final ValueNotifier<bool?> isConnected =
      ValueNotifier<bool?>(null);
  // Stores the subscription that listens for network
  // connectivity changes from the device.
  StreamSubscription<List<ConnectivityResult>>?
      _subscription;
  // Prevents the service from starting multiple connectivity listeners.
  bool _started = false;

  // ----------------------------------------------------
  // 3. START CONNECTIVITY MONITORING
  // ----------------------------------------------------
  // Starts listening for network connectivity changes.
  // This method is called when the application needs
  // to monitor the device's network connection.
  Future<void> start() async {
    // Avoid creating another listener if the service
    // has already started.
    if (_started) return;

    _started = true;
    // Subscribe to the connectivity change stream.
    // Whenever the device network changes, the
    // _updateStatus method is called automatically.
    _subscription = _connectivity
        .onConnectivityChanged
        .listen(
      _updateStatus,
      // Handles errors that occur while listening
      // for network connectivity changes.
      onError: (Object error) {
        debugPrint('Connectivity error: $error');
        // Set the status to null when an error occurs
        // because the current connection state is unknown.
        isConnected.value = null;
      },
    );
    // Perform an initial connectivity check immediately
    // after starting the network listener.
    await refresh();
  }

  // ----------------------------------------------------
  // 4. CHECK CURRENT CONNECTIVITY STATUS
  // ----------------------------------------------------
  // Checks the device's current network connection.
  //
  // This method can also be called manually when the
  // user selects the Refresh Status button.
  Future<void> refresh() async {
    try {
      // Retrieve the available network connection types
      // such as Wi-Fi, mobile data or no connection.
      final results =
          await _connectivity.checkConnectivity();
      // Pass the results to update the application status.
      _updateStatus(results);
    } catch (error) {
      // Handle errors if the connectivity check fails.
      debugPrint('Unable to check network: $error');
      // Set the status to unknown if the check fails.
      isConnected.value = null;
    }
  }

  // ----------------------------------------------------
  // 5. UPDATE CONNECTIVITY STATUS
  // ---------------------------------------------------
  // Converts the connectivity results into a simple
  // true or false value for the application interface.
  // If at least one network connection type is detected,
  // the status becomes true.
  // If all results indicate no connection, the status
  // becomes false.
  void _updateStatus(List<ConnectivityResult> results) {
    isConnected.value = results.any(
      (result) => result != ConnectivityResult.none,
    );
  }

  // ----------------------------------------------------
  // 6. STOP CONNECTIVITY MONITORING
  // ----------------------------------------------------
  // Stops listening for connectivity changes when
  // the service is no longer required.
  // Cancelling the subscription helps prevent
  // unnecessary background listeners.
  Future<void> stop() async {
    // Cancel the existing connectivity subscription.
    await _subscription?.cancel();
    // Clear the subscription reference.
    _subscription = null;
    // Allow the service to be started again later.
    _started = false;
  }
}
