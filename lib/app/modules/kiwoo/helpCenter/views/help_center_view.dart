import 'package:kiwoo/app/core/utils/app_utility.dart';
import 'package:kiwoo/app/core/utils/formatters/validation.dart';
import 'package:kiwoo/app/global_widgets/input_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  const HelpCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: AppStrings.HELP_CENTER),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
          children: [
            inputWithLabel(
              label: AppStrings.NAME,
              onSaved: (value) => controller.fullName = value,
              validator: (value) =>
                  isEmptyValidator(value, AppStrings.PLS_ENTER_NAME),
            ),
            verticalSpaceSmall,
            inputWithLabel(
              label: AppStrings.EMAIL,
              onSaved: (value) => controller.emailSender = value,
              validator: (value) {
                var isEmpty = isEmptyValidator(
                  value,
                  AppStrings.PLS_ENTER_EMAIL,
                );
                if (isEmpty == null && !value!.isEmail) {
                  return AppStrings.PLS_ENTER_VALID_EMAIL;
                }
                return isEmpty;
              },
            ),
            verticalSpaceSmall,
            inputWithLabel(
              label: AppStrings.MESSAGE,
              hintText: AppStrings.ENTER_MESSAGE,
              minLines: 6,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              onSaved: (value) => controller.message = value,
              validator: (value) {
                if ((value ?? '').trim().length < 50) {
                  return AppStrings.PLS_ENTER_MESSAGE;
                }
                return null;
              },
            ),
            verticalSpaceMedium,
            AppButton(
              buttonText: AppStrings.SEND,
              onTap: () {
                if (controller.formKey.currentState?.validate() == true) {
                  controller.formKey.currentState!.save();
                  showOverlay(
                    asyncFunction: () => controller.callCreateCaseApi(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
