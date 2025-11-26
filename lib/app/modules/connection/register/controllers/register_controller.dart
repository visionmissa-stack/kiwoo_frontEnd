import 'dart:async';

import 'package:kiwoo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/reactive_forms/phone_number/validators.dart'
    show PhoneValidators;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart' show OTPType;
import '../../../../data/models/register_model.dart';
import '../../providers/connection_provider.dart';

class RegisterController extends GetxController {
  late final ConnectionProvider provider;
  late final FormGroup formGroup;
  late RxBool isLoading;

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
    provider = Get.find<ConnectionProvider>();

    formGroup = FormGroup(
      {
        "name": FormControl<String>(validators: [Validators.required]),
        "email": FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        "phone": FormControl<String>(
          validators: [PhoneValidators.required, PhoneValidators.valid],
        ),
        "password": FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(8),
            Validators.pattern(
              r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$!%*?&])[A-Za-z\d@#$!%*?&]{8,}$)',
            ),
          ],
        ),
        "confirmPassword": FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [Validators.mustMatch("password", "confirmPassword")],
    );

    super.onInit();
  }

  Future<OTPModel?> requestOtp() async {
    try {
      var response = await provider.askForOtpApi(
        formGroup.control("email").value.trim(),
        OTPType.register.name,
      );
      if (response?.isSuccess == true) {
        var registerData = OTPModel.fromMap(response!.data!);
        showMsg(
          registerData.message ?? "Otp sent to successfully",
          color: AppColors.SUCCESS,
        );
        return registerData;
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("$e", isError: true);
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future registerApiCall() async {
    try {
      var response = await provider.register(
        formGroup.control("name").value.trim(),
        formGroup.control("phone").value,
        formGroup.control("email").value.trim(),
        formGroup.control("password").value.trim(),
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
