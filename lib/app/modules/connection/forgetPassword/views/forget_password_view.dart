import 'package:kiwoo/app/core/utils/actions/overlay.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/modules/connection/forgetPassword/views/new_password_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart' show AppColors;
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../data/models/register_model.dart' show OTPModel;
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../../bindings/otp_binding.dart';
import '../../views/otp_view.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  void submitRegistration([_]) async {
    //Get.toNamed(otpScreen, arguments: {"email": ""});
    if (controller.formGroup.valid) {
      var response = await showOverlay<OTPModel?>(
        asyncFunction: () async {
          try {
            var response = await controller.provider.askForOtpApi(
              controller.formGroup.control("email").value.trim(),
              OTPType.forgotPassword.name,
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
        },
      );
      if (response != null) {
        Get.to(
          () {
            return OTPView(
              onAuthentificated: () {
                Get.off(() => NewPasswordView());
                return;
              },
            );
          },
          opaque: false,
          binding: OTPBinding.forgotPassword(
            controller.formGroup.control("email").value.trim(),
            validity: response.otpValidity,
          ),
        );
      }
    } else {
      controller.formGroup.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.ss),
          child: Column(
            children: [
              const PresentationPageHeader(
                pageTitle: AppStrings.RESET_PASSWORD,
              ),
              verticalSpaceRegular,
              ReactiveForm(
                formGroup: controller.formGroup,
                child: ReactiveTextField(
                  formControlName: 'email',
                  decoration: textInputDecoration(hintText: AppStrings.EMAIL),
                  onTapOutside: (event) => hideKeyboard(),
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        AppStrings.PLS_ENTER_EMAILID,
                    ValidationMessage.email: (error) =>
                        AppStrings.PLS_ENTER_VALID_EMAILID,
                  },
                ),
              ),
              verticalSpaceLarge,
              customeAuthButton(
                lableName: AppStrings.RESET,
                onTap: submitRegistration,
              ),

              verticalSpaceRegular,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.BACK_TO,
                    textAlign: TextAlign.center,
                    style: TextThemeHelper.authTitle,
                  ),
                  horizontalSpaceTiny,
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.LOGIN);
                    },
                    child: Text(
                      AppStrings.LOGIN,
                      textAlign: TextAlign.left,
                      style: TextThemeHelper.registerHere,
                    ),
                  ),
                ],
              ),
              verticalSpaceRegular,
            ],
          ),
        ),
      ),
    );
  }
}
