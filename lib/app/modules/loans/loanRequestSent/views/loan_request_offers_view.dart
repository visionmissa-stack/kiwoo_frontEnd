import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import 'package:KIWOO/app/core/utils/actions/overlay.dart';
import 'package:KIWOO/app/core/utils/enums.dart';
import 'package:KIWOO/app/global_widgets/app_bar.dart';
import 'package:KIWOO/app/global_widgets/list_builder_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../global_widgets/modal/dialogs.dart';
import '../../../../global_widgets/modal/loan_card.dart';
import '../controllers/loan_request_sent_controller.dart';

class LoanRequestOffersView extends GetView<LoanRequestSentController> {
  const LoanRequestOffersView(this.loanId, {super.key});
  final int loanId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: "Loan Offers",
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            listWidget(),
          ],
        ),
      ),
    );
  }

  Widget listWidget() {
    return Flexible(
      child: ListBuilderWidget.future(
        future: () => controller.getOfferApiCall(loanId.toString()),
        onEmptyText: "No Offers Available",
        itemBuilder: (context, item, _, [__]) {
          return Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 8),
              child: LoanCard(
                token: controller.token,
                user: item.contact,
                amount: item.loan?.amount,
                interest: item.offeredInterest,
                tenure: item.offeredTenure,
                approvalStatus: item.approvalStatus?.name,
                date: item.updatedAt,
                onLoanStatus: (status) {
                  if (status == LoanApprovalStatus.offered.name) {
                    return Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 45.ss,
                            onPressed: () async {
                              var pin = await showPinDialog();
                              if (pin != null) {
                                showOverlay(
                                  asyncFunction: () =>
                                      controller.postOfferResponseApiCall(
                                    true,
                                    item.loanId!,
                                    item.id!,
                                    pin,
                                  ),
                                );
                              }
                            },
                            color: AppColors.PRIMARY1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(AppStrings.ACCEPT,
                                  style: TextStyle(
                                    fontSize: 14.fss,
                                    fontFamily: FontPoppins.SEMIBOLD,
                                    color: FontColors.WHITE,
                                  )),
                            ),
                          ),
                        ),
                        horizontalSpaceRegular,
                        Expanded(
                          child: MaterialButton(
                            height: 45.ss,
                            onPressed: () async {
                              var pin = await showPinDialog();
                              if (pin != null) {
                                showOverlay(
                                  asyncFunction: () =>
                                      controller.postOfferResponseApiCall(
                                    false,
                                    item.loanId!,
                                    item.id!,
                                    pin,
                                  ),
                                );
                              }
                            },
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(AppStrings.REJECT,
                                  style: TextStyle(
                                    fontSize: 14.fss,
                                    fontFamily: FontPoppins.SEMIBOLD,
                                    color: FontColors.WHITE,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                  // const SizedBox(height: 6)
                },
              ));
        },
      ),
    );
  }
}
