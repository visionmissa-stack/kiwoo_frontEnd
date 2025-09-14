import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/kiwoo_icons.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/contact_list.dart';
import '../../../../global_widgets/input_field.dart';
import '../controllers/request_loan_controller.dart';
import '../controllers/submit_box/custom_info_box.dart';

class RequestLoanView extends GetView<RequestLoanController> {
  const RequestLoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: AppStrings.LOAN_GIVEN,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.ss),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    AppStrings.ENTER_LOAN_REQUEST_TITLE_MSG,
                    style: TextThemeHelper.textFieldTitle,
                  ),
                ),
                verticalSpaceRegular,
                inputWithLabel(
                  label: AppStrings.ENTER_LOAN_AMOUNT,
                  inputFormatters: [decimalNumberFormatter],
                  hintText: AppStrings.AMOUNT,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (p0) {
                    return isEmptyValidator(
                        p0, AppStrings.PLS_ENTER_LOAN_AMOUNT);
                  },
                  onSaved: (p0) {
                    controller.loanRequest.amount = double.parse(p0!);
                  },
                ),
                verticalSpaceRegular,
                inputWithLabel(
                  label: AppStrings.ENTER_LOAN_INTEREST,
                  hintText: AppStrings.E_G_8_OR_12,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [decimalNumberFormatter],
                  validator: (p0) {
                    return isEmptyValidator(
                        p0, AppStrings.PLS_ENTER_LOAN_INTEREST);
                  },
                  onSaved: (p0) {
                    controller.loanRequest.interest = double.parse(p0!);
                  },
                ),
                verticalSpaceRegular,
                inputWithLabel(
                  label: AppStrings.ENTER_LOAN_MONTHS,
                  hintText: AppStrings.E_G_12_OR_24,
                  keyboardType: TextInputType.number,
                  inputFormatters: [numberFormatter],
                  textInputAction: TextInputAction.done,
                  validator: (p0) {
                    return isEmptyValidator(
                        p0, AppStrings.PLS_ENTER_LOAN_MONTHS);
                  },
                  onSaved: (p0) {
                    controller.loanRequest.tenure = int.parse(p0!);
                  },
                ),
                verticalSpaceRegular,
                inputWithLabelForm<LoanLenderOptions>(
                  initialValue: LoanLenderOptions.loanMarket,
                  label: AppStrings.SELECT_LOAN_LENDER_STR,
                  onSaved: (p0) {
                    controller.loanRequest.lender = p0!;
                  },
                  child: (state) {
                    return Row(
                      children: LoanLenderOptions.values.map((entry) {
                        return SizedBox(
                          width: 145.ss,
                          child: RadioListTile<LoanLenderOptions>(
                            splashRadius: 0,
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              entry.value,
                              style: TextThemeHelper.loanLender,
                            ),
                            value: entry,
                            groupValue: state.value,
                            onChanged: (value) {
                              state.didChange(value);
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                verticalSpaceLarge,
                AppButton(
                  buttonText: AppStrings.SUBMIT,
                  onTap: () async {
                    debugPrint("Request Loan Submit Tap1");
                    if (controller.formKey.currentState?.validate() == true) {
                      controller.formKey.currentState?.save();
                      if (controller.loanRequest.lender ==
                          LoanLenderOptions.contacts) {
                        var contacts = await selectContacts();
                        if ((contacts ?? []).isEmpty) {
                          showMsg("Please choose at least 1 Contact first",
                              type: TypeMessage.error);
                          return;
                        } else {
                          controller.loanRequest.contacts = contacts!;
                        }
                      }
                      var success = await showOverlay(
                        asyncFunction: controller.loanLenderApiCall,
                      );
                      if (success) {
                        var msg = AppStrings
                            .THANK_YOU_FOR_SUBMITTING_YOUR_LOAN_APPLICATION_2;
                        if (controller.loanRequest.lender ==
                            LoanLenderOptions.loanMarket) {
                          msg = AppStrings
                              .THANK_YOU_FOR_SUBMITTING_YOUR_LOAN_APPLICATION;
                        }
                        await submitedSuccessDaiLogBox(
                          Kiwoo.ok_circled2,
                          AppStrings.SUBMITTED_SUCCESSFULLY,
                          msg,
                          AppStrings.CONTINUE,
                        );
                        Get.back();
                      }
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

  Future<List<String>?> selectContacts() async {
    var contacts = await Get.bottomSheet<List<String>>(
      SizedBox(
        height: .7.sh,
        child: ContactListView.searchable(
          onSubmit: (contacts) {
            Get.back<List<String>>(
                result: contacts
                    .where((item) => item.isSelected.isTrue)
                    .map((el) => el.phone!)
                    .toList());
          },
          onContactClick: (contact) => contact.isSelected.toggle(),
        ),
      ),
      backgroundColor: AppColors.APP_BG,
      isScrollControlled: true,
    );
    return contacts;
  }
}
