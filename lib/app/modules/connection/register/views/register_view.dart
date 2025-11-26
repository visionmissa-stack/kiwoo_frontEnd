import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:sizing/sizing.dart';

import 'package:kiwoo/app/core/utils/actions/overlay.dart';
import 'package:kiwoo/app/core/utils/formatters/global_phone_formator.dart';
import 'package:kiwoo/app/data/models/register_model.dart';
import 'package:kiwoo/app/global_widgets/input_field.dart';
import 'package:kiwoo/app/modules/connection/bindings/otp_binding.dart';
import 'package:kiwoo/app/routes/app_pages.dart';

import '../../../../core/reactive_forms/phone_number/value_accesors.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../views/otp_view.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  void submitRegistration([_]) async {
    //Get.toNamed(otpScreen, arguments: {"email": ""});
    if (controller.formGroup.valid) {
      var response = await showOverlay<OTPModel?>(
        asyncFunction: controller.requestOtp,
      );
      if (response != null) {
        Get.to(
          () {
            return OTPView(onAuthentificated: controller.registerApiCall);
          },
          opaque: false,
          binding: OTPBinding(
            controller.formGroup.control("email").value,
            validity: response.otpValidity!,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        backgroundColor: AppColors.APP_BG,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const PresentationPageHeader(pageTitle: AppStrings.SIGN_UP_NOW),
              verticalSpaceRegular,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.ss),
                child: ReactiveForm(
                  formGroup: controller.formGroup,
                  child: Column(
                    children: [
                      ReactiveTextField(
                        formControlName: 'name',

                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: textInputDecoration(
                          hintText: AppStrings.NAME,
                        ),
                        onTapOutside: (event) {
                          hideKeyboard();
                        },
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              AppStrings.PLS_ENTER_NAME,
                        },
                      ),
                      verticalSpaceRegular,
                      ReactiveTextField(
                        formControlName: 'email',
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
                      ReactivePhoneFormField<String>(
                        formControlName: 'phone',
                        validationMessages: {
                          ...PhoneValidationMessage.localizedValidationMessages(
                            context,
                          ),
                        },
                        valueAccessor: MyPhoneNumberValueAccessor(),
                        countrySelectorNavigator:
                            CountrySelectorNavigator.draggableBottomSheet(),
                        decoration: textInputDecoration(
                          hintText: AppStrings.PHONE_NUMBER,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      verticalSpaceRegular,
                      ObxValue(
                        (isHidden) => ReactiveTextField(
                          formControlName: 'password',
                          obscureText: isHidden.isTrue,
                          onTapOutside: (event) {
                            hideKeyboard();
                          },
                          textInputAction: TextInputAction.done,
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
                            ValidationMessage.pattern: (error) =>
                                AppStrings.PASSWORD_INVALID,
                          },
                        ),
                        true.obs,
                      ),
                      verticalSpaceRegular,
                      ObxValue(
                        (isHidden) => ReactiveTextField(
                          formControlName: 'confirmPassword',

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
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                AppStrings.PLS_ENTER_CONFIRM_PASSWORD,
                            ValidationMessage.mustMatch: (error) =>
                                AppStrings.PASSWORD_NOT_MATCH,
                          },
                        ),
                        true.obs,
                      ),
                      // verticalSpaceTiny,
                      SizedBox(height: 40.vs),
                      controller.isLoading.value
                          ? customeAuthButtonLoading()
                          : customeAuthButton(
                              lableName: AppStrings.SIGN_UP,
                              onTap: submitRegistration,
                            ),
                    ],
                  ),
                ),
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.ALREADY_HAVE_AN_ACCOUNT,
                    textAlign: TextAlign.center,
                    style: TextThemeHelper.authTitle,
                  ),
                  horizontalSpaceTiny,
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed(Routes.LOGIN);
                    },
                    child: Text(
                      AppStrings.LOGIN,
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
      ),
    );
  }
}
