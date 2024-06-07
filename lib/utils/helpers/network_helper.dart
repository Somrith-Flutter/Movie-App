import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkHelper {
  static StreamSubscription<InternetConnectionStatus>? _subscription;

  static Future<bool> isNetworkConnected() async {
    if (kIsWeb) {
      final connectivity = await Connectivity().checkConnectivity();
      return connectivity == ConnectivityResult.mobile ||
          connectivity == ConnectivityResult.wifi;
    }
    return InternetConnectionChecker().hasConnection;
  }

  static void unsubscribe() {
    _subscription?.cancel();
  }
}
