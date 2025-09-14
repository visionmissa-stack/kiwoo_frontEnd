import 'dart:async';

import 'package:KIWOO/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:KIWOO/app/modules/connection/providers/connection_provider.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final provider = Get.put(ConnectionProvider());
  final formKey = GlobalKey<FormState>();
  var formKeyNewPass = GlobalKey<FormState>();

  String email = "";
  String newPassword = "";
  Timer? timer;
  final enableResend = RxBool(false);
  final isLoading = RxBool(false);

  int remainingSecoends = 1;
  final time = '00:00'.obs;

  void startTimer(int secoends) {
    debugPrint("In Timer");
    const duration = Duration(seconds: 1);
    remainingSecoends = secoends;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSecoends == 0) {
        enableResend.value = true;
        timer.cancel();
      } else {
        int minute = remainingSecoends ~/ 60;
        minute = minute % 60;
        int secoends = remainingSecoends % 60;
        time.value =
            "${minute.toString().padLeft(2, "0")}:${secoends.toString().padLeft(2, "0")}";
        remainingSecoends--;
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future resetPassword() async {
    var response = await provider.resetPassword(email, newPassword);
    if (response?.isSuccess == true) {
      Get.offNamedUntil(Routes.LOGIN, ModalRoute.withName(Routes.CONNECTION));
      response!.showMessage();
    } else {
      Get.back(closeOverlays: true);
    }
  }
}
