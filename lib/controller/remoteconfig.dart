import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/constant/variable.dart';

final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
Future<void> fetchAndActivateRemoteConfig() async {
  try {
    // Fetch the latest config
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await _remoteConfig.fetchAndActivate();
    showPrice = _remoteConfig.getBool('showDiscountedPrice');
    if (kDebugMode) {
      print("checking value $showPrice");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching Remote Config: $e');
    }
  }
}
