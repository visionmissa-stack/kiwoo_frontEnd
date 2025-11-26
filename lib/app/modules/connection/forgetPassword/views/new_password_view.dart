import 'package:kiwoo/app/core/utils/actions/overlay.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/forget_password_controller.dart';

class NewPasswordView extends GetView<ForgetPasswordController> {
  NewPasswordView({super.key}) {
    controller.formKeyNewPass = GlobalKey<FormState>();
  }
  void submitRegistration([_]) async {
    //Get.toNamed(otpScreen, arguments: {"email": ""});
    if (controller.formGroupPassword.valid) {
      showOverlay(asyncFunction: controller.resetPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PresentationPageHeader(pageTitle: AppStrings.CHANGE_PASSWORD),
            verticalSpaceRegular,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.ss),
              child: ReactiveForm(
                formGroup: controller.formGroupPassword,
                child: Column(
                  children: [
                    ObxValue(
                      (isHidden) => ReactiveTextField(
                        formControlName: 'password',
                        autofocus: true,
                        obscureText: isHidden.isTrue,
                        onTapOutside: (event) {
                          hideKeyboard();
                        },
                        textInputAction: TextInputAction.next,
                        decoration: textInputDecoration(
                          hintText: AppStrings.PASSWORD,
                          suffixIconColor: AppColors.PRIMARY1,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden.isTrue
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),

                            onPressed: () => isHidden.toggle(),
                          ),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              AppStrings.PLS_ENTER_PASSWORD,
                          ValidationMessage.pattern: (error) =>
                              AppStrings.PASSWORD_INVALID,
                        },
                      ),
                      true.obs,
                    ),

                    verticalSpaceRegular,
                    ObxValue(
                      (isHidden) => ReactiveTextField(
                        formControlName: "confirmPassword",
                        autofocus: true,
                        obscureText: isHidden.isTrue,
                        onTapOutside: (event) {
                          hideKeyboard();
                        },
                        textInputAction: TextInputAction.done,
                        decoration: textInputDecoration(
                          hintText: AppStrings.CONFIRM_NEW_PASSWORD,
                          suffixIconColor: AppColors.PRIMARY1,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden.isTrue
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),

                            onPressed: () => isHidden.toggle(),
                          ),
                        ),
                        onSubmitted: submitRegistration,
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              AppStrings.PLS_ENTER_CONFIRM_PASSWORD,
                          ValidationMessage.mustMatch: (error) =>
                              AppStrings.PASSWORD_NOT_MATCH,
                        },
                      ),
                      true.obs,
                    ),
                    verticalSpaceLarge,
                    customeAuthButton(
                      lableName: AppStrings.RESET,
                      onTap: submitRegistration,
                    ),
                  ],
                ),
              ),
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
    );
  }
}
