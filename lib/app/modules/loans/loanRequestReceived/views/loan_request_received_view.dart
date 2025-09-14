import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:KIWOO/app/core/utils/actions/overlay.dart';
import 'package:KIWOO/app/core/utils/enums.dart';
import 'package:KIWOO/app/core/utils/font_family.dart';
import 'package:KIWOO/app/modules/chat/bindings/chat_screen_binding.dart';
import 'package:KIWOO/app/modules/chat/views/chat_view.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../data/models/storage_box_model.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../global_widgets/modal/bottom_sheet.dart';
import '../../../../global_widgets/modal/dialogs.dart';
import '../../../../global_widgets/modal/loan_card.dart';
import '../../../../global_widgets/score_widgets.dart';
import '../../../../global_widgets/scrollview_with_scrolling_child.dart';
import '../controllers/loan_request_received_controller.dart';

/* class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}*/

class LoanRequestReceivedView extends GetView<LoanRequestReceivedController> {
  const LoanRequestReceivedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: AppStrings.RECEIVED_REQUEST,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 18.ss,
          right: 18.ss,
          bottom: 18.ss,
        ),
        child: ScrollviewWithScrollingChild(
          header: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: creditDataWidget(
                controller.userDetails.value?.extraInfo?.score ?? 0),
          ),
          maxExtent: 40,
          minExtent: 40,
          fixHeader: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            color: AppColors.APP_BG,
            child: Row(
              children: [
                Text(
                  "Today",
                  style: TextThemeHelper.titleLR,
                ),
                horizontalSpaceTiny,
                const Spacer(),
                Text(
                  "\$40,000",
                  style: TextThemeHelper.EHTGTextStyle,
                ),
                // horizontalSpaceTiny,
              ],
            ),
          ),
          body: loanReceivedListWidget(),
        ),
      ),
    );
  }

  Widget loanReceivedListWidget() {
    return ListBuilderWidget.future(
      future: controller.futureRequest,
      itemBuilder: (context, item, onRefresh, [_]) {
        var rLoan = item.loan;
        var rApprouval = item.approvalStatus;

        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 5),
          child: LoanCard(
              token: StorageBox.token.val,
              user: rLoan?.user,
              amount: rLoan?.amount,
              interest: rLoan?.interest,
              tenure: rLoan?.tenure,
              approvalStatus: rApprouval?.name,
              date: rLoan?.createdAt,
              onLoanStatus: (status) {
                if (status == LoanApprovalStatus.pending.name) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      recRoundedButton(
                        title: "Accept",
                        color: AppColors.SUCCESS,
                        onPressed: () async {
                          var pin = await showPinDialog();
                          if (pin != null) {
                            showOverlay(
                              asyncFunction: () =>
                                  controller.postAcceptLoanAPiCall(
                                loadId: item.loanId!,
                                pin: pin,
                              ),
                            ).then((val) {
                              if (val) onRefresh!();
                            });
                          }
                        },
                      ),
                      recRoundedButton(
                        title: "Chat",
                        color: Colors.orange,
                        onPressed: () {
                          Get.to(
                            () => const ChatView(),
                            binding: ChatScreenBinding(),
                            arguments: {
                              ...rLoan!.user!.toMap(),
                              "id": rLoan.userId
                            },
                            routeName: "chatScreen",
                          );
                        },
                      ),
                      recRoundedButton(
                        title: "Offer",
                        color: Colors.redAccent,
                        onPressed: () {
                          sendLoanDaiLogBox(
                            loadId: rLoan?.id,
                            interest: rLoan?.interest,
                            amount: rLoan?.amount,
                            duration: rLoan?.tenure,
                          ).then((value) {
                            print("the value is here $value");
                            return value == true ? onRefresh?.call() : null;
                          });
                        },
                      )
                    ],
                  );
                }
                return Text(
                  "Loan has been $status",
                  style: TextThemeHelper.titleLR,
                );
              }),
        );
      },
    );
  }

  FilledButton recRoundedButton({
    required color,
    required String title,
    required void Function() onPressed,
  }) {
    return FilledButton(
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: FontPoppins.REGULAR,
              color: AppColors.WHITE,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ));
  }

  Future<bool?> sendLoanDaiLogBox(
      {double? interest, double? amount, int? duration, int? loadId}) {
    String amountBox = amount?.toString() ?? "";
    String durationBox = duration?.toString() ?? "";
    String interestBox = interest?.toString() ?? "";
    GlobalKey<FormState> formKey = GlobalKey();

    return boomSheetWidget<bool>(
      child: Container(
        width: 1.sw,
        height: 0.7.sh,
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Make Offer",
              style: TextStyle(
                fontSize: 20.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            verticalSpaceSmall,
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      inputField(
                        initialValue: amountBox,
                        label: AppStrings.ENTER_LOAN_AMOUNT,
                        enabled: false,
                        hintText: AppStrings.AMOUNT,
                      ),
                      verticalSpaceSmall,
                      inputField(
                        initialValue: interestBox,
                        label: AppStrings.ENTER_LOAN_INTEREST,
                        hintText: AppStrings.LOAN_INTEREST,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [decimalNumberFormatter],
                        validator: (value) => isEmptyValidator(
                          value,
                          AppStrings.PLS_ENTER_LOAN_INTEREST,
                        ),
                        onSaved: (val) {
                          interestBox = val!;
                        },
                      ),
                      verticalSpaceSmall,
                      inputField(
                        initialValue: durationBox,
                        label: AppStrings.ENTER_DURATION,
                        hintText: AppStrings.LOAN_DURATION,
                        inputFormatters: [decimalNumberFormatter],
                        sufixIcon: Container(
                          width: 120.ss,
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7)),
                          ),
                          child: Text(
                            "Months",
                            style: TextStyle(fontSize: 14.ss),
                          ),
                        ),
                        validator: (value) => isEmptyValidator(
                          value,
                          AppStrings.PLS_ENTER_LOAN_MONTHS,
                        ),
                        onSaved: (val) {
                          durationBox = val!;
                        },
                      ),
                      verticalSpaceMedium,
                      DaiLogButtonPrimary(
                        buttonText: "Send Offer",
                        height: 50.ss,
                        width: 220.ss,
                        onTap: () {
                          if (formKey.currentState?.validate() == true) {
                            formKey.currentState!.save();
                            showOverlay(
                              asyncFunction: () => controller.postOfferApiCall(
                                loadId: loadId.toString(),
                                duration: int.parse(durationBox.trim()),
                                interest: double.parse(
                                  interestBox.trim(),
                                ),
                              ),
                            ).then((val) {
                              return val;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget inputField({
    String initialValue = '',
    required String label,
    String hintText = '',
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    TextInputAction textInputAction = TextInputAction.done,
    Widget? sufixIcon,
  }) {
    return SizedBox(
      width: 250.ss,
      child: inputWithLabel(
        initialValue: initialValue,
        label: label,
        style: TextThemeHelper.sendTextFieldTitle,
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextThemeHelper.sendLoanTextFormFieldHintStyle,
        onSaved: onSaved,
        validator: validator,
        enabled: enabled,
        sufixIcon: sufixIcon,
      ),
    );
  }
}
