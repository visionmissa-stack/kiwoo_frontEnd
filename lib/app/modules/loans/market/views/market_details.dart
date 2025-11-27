// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/global_widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/image_name.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../controllers/loans_controller.dart';

class MarketDetails extends GetWidget<LoansController> {
  String? amount;
  String? interest;
  String? duration;
  int? id, loanId;
  String? name;
  MarketDetails({
    super.key,
    this.amount,
    this.duration,
    this.interest,
    this.id,
    this.name,
    this.loanId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: AppStrings.LOAN_MARKET_DETAILS),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.ss, vertical: 30.ss),
        child: AppButton(
          buttonText: AppStrings.GIVE_LOAN,
          onTap: () {
            sendLoanDaiLogBox();
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.ss),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.ss),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImgName.CARD_MEDIUM_IMG),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.ss,
                  vertical: 15.ss,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImgName.ELLIPSE_2,
                          height: 40.ss,
                          fit: BoxFit.cover,
                        ),
                        verticalSpaceSmall,
                        Text(
                          "Leslie Credit Score",
                          style: TextStyle(
                            fontSize: 17.fss,
                            color: FontColors.BLACK,
                            fontFamily: FontPoppins.MEDIUM,
                          ),
                        ),
                        verticalSpaceTiny,
                        Text(
                          "Last updated: February 1, 2024",
                          style: TextStyle(
                            fontSize: 12.fss,
                            color: FontColors.GREY,
                            fontFamily: FontPoppins.REGULAR,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          ImgName.CREDIT_SCORE_IMG,
                          height: 85.ss,
                          width: 100.ss,
                          fit: BoxFit.contain,
                        ),
                        verticalSpaceSmall,
                        Row(
                          children: [
                            Text(
                              "300",
                              style: TextStyle(
                                fontSize: 12.fss,
                                color: FontColors.GREY,
                                fontFamily: FontPoppins.REGULAR,
                              ),
                            ),
                            SizedBox(width: 40.ss),
                            Text(
                              "300",
                              style: TextStyle(
                                fontSize: 12.fss,
                                color: FontColors.GREY,
                                fontFamily: FontPoppins.REGULAR,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.ss),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.ss),
            child: Text(
              "Requested loan Details",
              style: TextStyle(
                fontSize: 17.fss,
                color: const Color(0xFF1A1A1A),
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
          ),
          SizedBox(height: 15.ss),
          requestLoanDetailWidget(lbl: "Amount", val: "$amount EXFA "),
          SizedBox(height: 10.ss),
          requestLoanDetailWidget(lbl: "Interest", val: "$interest%"),
          SizedBox(height: 10.ss),
          requestLoanDetailWidget(lbl: "Duration", val: "$duration Months"),
        ],
      ),
    );
  }

  Widget requestLoanDetailWidget({String? lbl, String? val}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.ss),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lbl ?? "",
            style: TextStyle(
              fontSize: 16.fss,
              color: const Color(0xFF787878),
              fontFamily: FontPoppins.MEDIUM,
            ),
          ),
          Text(
            val ?? "",
            style: TextStyle(
              fontSize: 16.fss,
              color: const Color(0xFF4A4A4A),
              fontFamily: FontPoppins.MEDIUM,
            ),
          ),
        ],
      ),
    );
  }

  Future sendLoanDaiLogBox() {
    var amount = this.amount ?? "";
    var duration = this.duration ?? "";
    var interest = this.interest ?? "";

    return Get.dialog(
      barrierDismissible: true,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Text(
                        "Send Loan",
                        style: TextStyle(
                          fontSize: 20.fss,
                          fontFamily: FontPoppins.SEMIBOLD,
                        ),
                      ),
                      verticalSpaceSmall,
                      inputWidget(
                        initialValue: amount,
                        title: AppStrings.ENTER_LOAN_AMOUNT,
                        hintText: AppStrings.AMOUNT,
                        enable: false,
                        validator: (value) {
                          return isEmptyValidator(
                            value,
                            AppStrings.PLS_ENTER_LOAN_AMOUNT,
                          );
                        },
                      ),
                      verticalSpaceSmall,
                      inputWidget(
                        initialValue: interest,
                        title: AppStrings.ENTER_LOAN_INTEREST,
                        hintText: AppStrings.LOAN_INTEREST,
                        validator: (value) {
                          return isEmptyValidator(
                            value,
                            AppStrings.PLS_ENTER_LOAN_INTEREST,
                          );
                        },
                        onSaved: (p0) {
                          interest = p0!;
                        },
                      ),
                      verticalSpaceSmall,
                      inputWidget(
                        initialValue: duration,
                        title: AppStrings.ENTER_DURATION,
                        hintText: AppStrings.LOAN_DURATION,
                        validator: (value) {
                          return isEmptyValidator(
                            value,
                            AppStrings.PLS_ENTER_LOAN_MONTHS,
                          );
                        },
                        onSaved: (p0) {
                          duration = p0!;
                        },
                      ),
                      verticalSpaceMedium,
                      DaiLogButtonPrimary(
                        buttonText: "Payment Request",
                        height: 50.ss,
                        width: 220.ss,
                        onTap: () {
                          if (controller.formKey.currentState?.validate() ==
                              true) {
                            controller.formKey.currentState!.save();
                            controller
                                .postOfferApi(
                                  loanId.toString(),
                                  int.parse(duration),
                                  double.parse(interest),
                                )
                                .then((val) => Get.back(result: val));
                            // //if (validation()) {
                            // Get.back();
                          }

                          //}
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputWidget({
    required String title,
    required String initialValue,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    String hintText = '',
    bool enable = true,
  }) {
    return SizedBox(
      width: 250.ss,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextThemeHelper.sendTextFieldTitle),
          verticalSpaceSmall,
          CustomInputFormField(
            validator: validator,
            onSaved: onSaved,
            initialValue: initialValue,
            style: TextThemeHelper.sendLoantTextFormField,
            enabled: enable,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [decimalNumberFormatter],
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextThemeHelper.sendLoanTextFormFieldHintStyle,
            contentPadding: EdgeInsets.fromLTRB(10.ss, 5.ss, 10.ss, 5.ss),
            fillColor: const Color.fromARGB(255, 243, 243, 243),
            suffixIcon: suffixIcon,
          ),
        ],
      ),
    );
  }
}
