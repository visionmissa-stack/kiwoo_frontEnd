import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pinput/reactive_pinput.dart';
import 'package:sizing/sizing.dart';

import 'package:kiwoo/app/core/utils/actions/overlay.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../../../core/utils/variables.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/count_down.dart';
import '../controllers/otp_controller.dart';

class OTPView extends GetWidget<OTPController> {
  const OTPView({super.key, required this.onAuthentificated});
  final FutureOr<void> Function() onAuthentificated;
  @override
  Widget build(BuildContext context) {
    // activeColor: AppColors.PRIMARY1,
    // selectedFillColor: AppColors.WHITE,
    // selectedColor: Colors.grey.shade400,
    // activeFillColor: AppColors.WHITE,
    // inactiveFillColor: AppColors.WHITE,
    // shape: PinCodeFieldShape.box,
    // borderRadius: BorderRadius.circular(10),
    // borderWidth: 1.5,
    // inactiveColor: Colors.grey.shade400,
    // fieldHeight: 56,
    // fieldWidth: 56,

    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 85.ss),
              Text(
                "VERIFICATION",
                textAlign: TextAlign.center,
                style: TextThemeHelper.headlineLarge,
              ),
              verticalSpaceRegular,
              Text(
                "Enter the code sent to the ${controller.otpContacted.isEmail ? 'Email' : 'Phone'}",
                textAlign: TextAlign.center,
                style: TextThemeHelper.authTitle,
              ),
              verticalSpaceRegular,
              Text(
                controller.otpContacted,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextThemeHelper.forgotPassword,
              ),

              IconButton(
                icon: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.edit), Text("Change Email")],
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              verticalSpaceRegular,
              Obx(
                () => CountDownWidget(
                  title: "counttDoun title",
                  duration: controller.duration.value,
                  onDone: () => controller.updateDuration(0),
                  style: TextThemeHelper.welcomeTitle,
                  onDoneWidget: AppButton(
                    height: 37.ss,
                    width: .5.sw,
                    buttonText: AppStrings.RESEND_CODE_BTN,
                    onTap: () {
                      controller.pin.value = "";
                      controller.resendOtpApiCall();
                    },
                  ),
                ),
              ),
              verticalSpaceLarge,
              ReactiveForm(
                formGroup: controller.formGroup,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    ReactivePinPut<String>(
                      formControlName: 'pin',
                      length: 4,
                      obscureText: false,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                    ),
                    verticalSpaceRegular,
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return AppButton(
                          buttonText: AppStrings.VERIFY_EMAIL,
                          onTap:
                              form.control('pin').invalid ||
                                  controller.duration.value.inSeconds == 0
                              ? null
                              : () {
                                  showOverlay(
                                    asyncFunction: () async {
                                      var resp = await controller
                                          .verifyOtpApi();
                                      if (resp) {
                                        return onAuthentificated();
                                      }
                                    },
                                  );
                                },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
