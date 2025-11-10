import 'dart:async';

import 'package:kiwoo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../data/models/register_model.dart';
import '../../providers/connection_provider.dart';

class RegisterController extends GetxController {
  late final ConnectionProvider provider;
  final formKey = GlobalKey<FormState>();
  var phoneFormatter = phoneFormateur();
  String name = "";
  String email = "";
  String phone = "";
  String password = "";

  late RxBool isLoading;
  @override
  void onInit() {
    isLoading = RxBool(false);
    provider = Get.find<ConnectionProvider>();
    super.onInit();
  }

  Future registerApiCall() async {
    try {
      var response = await provider.register(
        name.trim(),
        phone,
        email.trim(),
        password.trim(),
      );
      if (response?.isSuccess == true) {
        var registerData = RegisterModel.fromMap(response!.data!);
        showMsg(
          registerData.message ??
              "Otp sent to ${registerData.email} successfully",
          color: AppColors.SUCCESS,
        );
        Get.offNamedUntil(Routes.LOGIN, ModalRoute.withName(Routes.CONNECTION));
      } else {
        Get.back(closeOverlays: true);
        response?.showMessage(
          message: (response.message).isNotEmpty
              ? response.message
              : ['Server issue Please Try again or revisit the screen. '],
        );
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.log("$e", isError: true);
      isLoading.value = false;
    }
  }
}
