import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  RxBool connectionStatus = false.obs;

  startMonitoring() async {
    await initConnectivity();
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status.first == ConnectivityResult.none) {
        connectionStatus.value = false;
      } else {
        connectionStatus.value = true;
      }
      update();
    } on PlatformException catch (e) {
      Get.log("PlatformException: $e", isError: true);
    }
  }
}
