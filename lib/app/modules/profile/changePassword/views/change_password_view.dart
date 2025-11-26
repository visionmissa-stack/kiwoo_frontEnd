import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_colors.dart' show AppColors;
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  void submitData([_]) {
    if (controller.formGroup.valid) {
      showOverlay(asyncFunction: () => controller.changePassword());
    } else {
      controller.formGroup.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: AppStrings.CHANGE_PASSWORD),
      body: ReactiveForm(
        formGroup: controller.formGroup,
        child: ListView(
          padding: const EdgeInsets.only(top: 35, right: 25, left: 25),
          children: [
            passwordInput(
              formControlName: 'oldPassword',
              hintText: AppStrings.ENTER_OLD_PASSWORD,
              textInputAction: TextInputAction.next,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    AppStrings.PLEASE_ENTER_OLD_PASSWORD,
              },
            ),

            verticalSpaceMedium,
            passwordInput(
              formControlName: 'newPassword',
              hintText: AppStrings.ENTER_NEW_PASSWORD,
              textInputAction: TextInputAction.next,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    AppStrings.PLEASE_ENTER_NEW_PASSWORD,
                ValidationMessage.pattern: (error) =>
                    AppStrings.PASSWORD_INVALID,
                ValidationMessage.mustMatch: (error) =>
                    AppStrings.PASSWORD_NOT_MATCH,
              },
            ),

            verticalSpaceMedium,
            passwordInput(
              formControlName: 'confirmNewPassword',
              hintText: AppStrings.ENTER_CONFIRM_NEW_PASSWORD,
              onSubmitted: submitData,
              textInputAction: TextInputAction.done,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    AppStrings.PLEASE_ENTER_CONFIRM_NEW_PASSWORD,
                ValidationMessage.mustMatch: (error) =>
                    AppStrings.PASSWORD_NOT_MATCH,
              },
            ),
            verticalSpaceMedium,
            AppButton(buttonText: "Submit", onTap: submitData),
          ],
        ),
      ),
    );
  }

  Widget passwordInput({
    required String formControlName,
    required String? hintText,
    TextInputAction? textInputAction,
    Map<String, String Function(Object)>? validationMessages,
    void Function(FormControl)? onSubmitted,
  }) {
    return ObxValue(
      (isHidden) => ReactiveTextField(
        formControlName: formControlName,
        decoration: textInputDecoration(
          hintText: hintText,
          suffixIconColor: AppColors.PRIMARY1,
          suffixIcon: IconButton(
            icon: Icon(
              isHidden.isTrue ? Icons.visibility : Icons.visibility_off,
            ),

            onPressed: () => isHidden.toggle(),
          ),
        ),
        onTapOutside: (event) => hideKeyboard(),
        obscureText: isHidden.isTrue,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        validationMessages: validationMessages,
      ),
      true.obs,
    );
  }
}
