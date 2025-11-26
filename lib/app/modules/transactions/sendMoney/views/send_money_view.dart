import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:reactive_pinput/reactive_pinput.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/reactive_forms/phone_number/value_accesors.dart'
    show MyPhoneNumberValueAccessor;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/utils/variables.dart';
import '../../../../data/models/validation_info_model.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/custom_appbar.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../global_widgets/mini_widgets.dart';
import '../controllers/send_money_controller.dart';

final _titleStile = TextStyle(
  fontSize: 12.fss,
  color: FontColors.BLUE_FADE,
  fontWeight: FontWeight.w300,
);

class SendMoneyView extends GetView<SendMoneyController> {
  const SendMoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        "Sending Money",
        true,
        true,
        const [],
        () {},
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: controller.formGroup,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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

                verticalSpaceMedium,
                ReactiveTextField<double>(
                  formControlName: "amount",
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration(hintText: AppStrings.AMOUNT),
                  onTapOutside: (event) => hideKeyboard(),
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        AppStrings.PLS_ENTER_AMOUNT,
                    ValidationMessage.minLength: (error) =>
                        AppStrings.PLS_MIN_AMOUNT,
                  },
                ),

                verticalSpaceMedium,
                AppButton(
                  buttonText: "Next",
                  onTap: () {
                    if (controller.formGroup.valid) {
                      Get.showOverlay(
                        asyncFunction: () => controller.getValidationInfo(
                          controller.formGroup.control('phone').value,
                          controller.formGroup.control('amount').value,
                        ),
                        loadingWidget: LoadingAnimationWidget.fourRotatingDots(
                          color: AppColors.PRIMARY1,
                          size: 30.0, // Adjust size as needed
                        ),
                      ).then((val) {
                        if (val == null) return;
                        getValidationSheet(
                          context: context,
                          amount: controller.formGroup.control('amount').value,
                          val: val,
                        );
                      });
                    } else {
                      controller.formGroup.markAllAsTouched();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getValidationSheet({
    required BuildContext context,
    required double amount,
    required ValidationData val,
  }) {
    final FormGroup formGroup = FormGroup({
      'pin': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(4),
          Validators.maxLength(4),
        ],
      ),
    });
    Get.bottomSheet(
      SizedBox(
        height: 0.70.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //header
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                title: Text(
                  "Confirmation Information",
                  textAlign: TextAlign.center,
                  style: _titleStile.copyWith(
                    fontSize: 20.fss,
                    fontFamily: FontPoppins.BOLD,
                  ),
                ),
                subtitle: Text(
                  "Transfer P2P",
                  textAlign: TextAlign.center,
                  style: _titleStile.copyWith(
                    fontSize: 15.fss,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: columnItems(
                        children: [
                          Text(
                            "Transaction Details".toUpperCase(),
                            style: titleDetailStyle.copyWith(
                              fontSize: 18.fss,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          rowItem(
                            title: "directionTypeName_outbound".trArgs([
                              "name".tr,
                            ]),
                            value: val.receiverInfo.name ?? '',
                          ),
                          rowItem(
                            title: "directionTypeName_outbound".trArgs([
                              "phone".tr,
                            ]),
                            value: val.receiverInfo.phone ?? '',
                          ),
                          Divider(color: Colors.grey, height: 20),
                          Text(
                            "Payment Details".toUpperCase(),
                            style: titleDetailStyle.copyWith(
                              fontSize: 18.fss,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          rowItem(title: "Amount", value: amount.toEGTH),
                          rowItem(title: "Fees & tax", value: val.fees.toEGTH),
                        ],
                      ),
                    ),
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                      child: Text(
                        AppStrings.PLS_ENTER_PIN,
                        textAlign: TextAlign.center,
                        style: _titleStile.copyWith(
                          fontFamily: FontPoppins.BOLD,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    ReactiveForm(
                      formGroup: formGroup,
                      child: Column(
                        children: [
                          ReactivePinPut<String>(
                            formControlName: 'pin',
                            autofocus: true,
                            length: 4,
                            obscureText: true,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                          ),
                          verticalSpaceMedium,
                          //footer
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return AppButton(
                                buttonText: "Verify PIN",
                                onTap: form.control('pin').invalid
                                    ? null
                                    : () {
                                        Get.showOverlay(
                                          asyncFunction: () =>
                                              controller.sendMoney(
                                                transactionID: val.id,
                                                pin: formGroup
                                                    .control("pin")
                                                    .value,
                                              ),
                                          loadingWidget:
                                              LoadingAnimationWidget.fourRotatingDots(
                                                color: AppColors.PRIMARY1,
                                                size:
                                                    30.0, // Adjust size as needed
                                              ),
                                        );
                                      },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.APP_BG,
      ignoreSafeArea: true,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
    );
  }
}
