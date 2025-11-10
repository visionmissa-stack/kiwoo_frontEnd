import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/text_style.dart';
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
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        AppButton(
          buttonText: "Next",
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              controller.formKey.currentState!.save();
              Get.showOverlay(
                asyncFunction: () => controller.getValidationInfo(
                  '509${controller.phoneNumberformatter.getUnmaskedText()}',
                  controller.amount,
                ),
                loadingWidget: LoadingAnimationWidget.fourRotatingDots(
                  color: AppColors.PRIMARY1,
                  size: 30.0, // Adjust size as needed
                ),
              ).then((val) {
                if (val == null) return;
                getValidationSheet(
                  context: context,
                  amount: controller.amount,
                  val: val,
                );
              });
            } else {}
          },
        ),
      ],
      body: Container(
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    inputWithLabel(
                      required: true,
                      label: AppStrings.PHONE_NUMBER,
                      hintText: "xxx xx xx xx xx",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [controller.phoneNumberformatter],
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return AppStrings.PLS_ENTER_PHONE_NUMBER;
                        }
                        if (!controller.phoneNumberformatter.isFill()) {
                          return AppStrings.PLS_ENTER_VALID_PHONE_NUMBER;
                        }
                        return null;
                      },
                    ),
                    verticalSpaceMedium,
                    inputWithLabel(
                      required: true,
                      label: AppStrings.ENTER_AMOUNT,
                      hintText: AppStrings.AMOUNT,
                      inputFormatters: [decimalNumberFormatter],
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        controller.amount = double.parse(val!);
                      },
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return AppStrings.PLS_ENTER_AMOUNT;
                        }
                        if (double.parse(value!) < 100) {
                          return AppStrings.PLS_MIN_AMOUNT;
                        }
                        controller.canNext.value = true;

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getValidationSheet({
    required BuildContext context,
    required double amount,
    required ValidationData val,
  }) {
    final pin = ''.obs;
    Get.bottomSheet(
      Column(
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
                      style: _titleStile.copyWith(fontFamily: FontPoppins.BOLD),
                    ),
                  ),
                  verticalSpaceSmall,
                  PinCodeTextField(
                    showCursor: false,
                    appContext: context,
                    mainAxisAlignment: MainAxisAlignment.center,
                    separatorBuilder: (context, index) => horizontalSpaceTiny,
                    pastedTextStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      fontFamily: FontPoppins.REGULAR,
                      color: const Color.fromARGB(255, 1, 1, 1),
                      fontSize: 16.fss,
                    ),
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: "*",
                    // backgroundColor: AppColors.WHITE,
                    hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                    useHapticFeedback: true,
                    pinTheme: PinTheme(
                      activeColor: AppColors.PRIMARY1,
                      selectedFillColor: AppColors.WHITE,
                      selectedColor: AppColors.PRIMARY,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 1.5,
                      inactiveColor: Colors.grey.shade400,
                      fieldHeight: 40,
                      fieldWidth: 35,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    enablePinAutofill: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [numberFormatter],
                    onChanged: (value) {
                      pin.value = value;
                    },
                  ),
                  verticalSpaceMedium,
                  //footer
                  Obx(
                    () => AppButton(
                      buttonText: "Verify PIN",
                      onTap: pin.isEmpty || pin.value.length < 4
                          ? null
                          : () {
                              Get.showOverlay(
                                asyncFunction: () => controller.sendMoney(
                                  transactionID: val.id,
                                  pin: pin.value,
                                ),
                                loadingWidget:
                                    LoadingAnimationWidget.fourRotatingDots(
                                      color: AppColors.PRIMARY1,
                                      size: 30.0, // Adjust size as needed
                                    ),
                              );
                            },
                    ),
                  ),
                  verticalSpaceSmall,
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.APP_BG,
      ignoreSafeArea: true,
      clipBehavior: Clip.antiAlias,
    );
  }
}
