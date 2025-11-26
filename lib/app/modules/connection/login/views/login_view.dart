import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/actions/overlay.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PresentationPageHeader(pageTitle: AppStrings.LOGIN),
            verticalSpaceRegular,
            ReactiveForm(
              formGroup: controller.formGroup,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.ss),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReactiveTextField(
                      formControlName: 'email',
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: textInputDecoration(
                        hintText: AppStrings.EMAIL,
                      ),
                      onTapOutside: (event) {
                        hideKeyboard();
                      },
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            AppStrings.PLS_ENTER_EMAILID,
                        ValidationMessage.email: (error) =>
                            AppStrings.PLS_ENTER_VALID_EMAILID,
                      },
                    ),
                    verticalSpaceRegular,
                    ObxValue(
                      (isHidden) => ReactiveTextField(
                        formControlName: 'password',
                        autofocus: true,
                        obscureText: isHidden.isTrue,
                        onTapOutside: (event) {
                          hideKeyboard();
                        },
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => submitLogin(),
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
                              AppStrings.PLS_ENTER_EMAILID,
                          ValidationMessage.email: (error) =>
                              AppStrings.PLS_ENTER_VALID_EMAILID,
                        },
                      ),
                      true.obs,
                    ),
                    // verticalSpaceTiny,
                    TextButton(
                      statesController: WidgetStatesController(),
                      onPressed: () {
                        Get.offNamed(Routes.FORGET_PASSWORD);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.ss),
                        child: Text(
                          AppStrings.FORGOT_PASSWORD,
                          textAlign: TextAlign.center,
                          style: TextThemeHelper.forgotPassword,
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    customeAuthButton(
                      lableName: AppStrings.LOGIN,
                      onTap: submitLogin,
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
                  AppStrings.NEW_USER,
                  textAlign: TextAlign.center,
                  style: TextThemeHelper.authTitle,
                ),
                horizontalSpaceTiny,
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.REGISTER);
                  },
                  child: Text(
                    AppStrings.REGISTER_HERE,
                    textAlign: TextAlign.center,
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

  submitLogin() {
    if (controller.formGroup.valid) {
      showOverlay(asyncFunction: controller.logInApiCall);
    }
  }
}
