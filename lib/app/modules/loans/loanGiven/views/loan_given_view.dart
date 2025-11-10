import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/global_widgets/list_builder_widget.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/account_balance_widget.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/custom_appbar.dart';
import '../../../../global_widgets/modal/bottom_sheet.dart';
import '../../../../global_widgets/modal/loan_card.dart';
import '../../../../global_widgets/score_widgets.dart';
import '../../../../global_widgets/scrollview_with_scrolling_child.dart';
import '../controllers/loan_given_controller.dart';

class LoanGivenView extends GetView<LoanGivenController> {
  const LoanGivenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(title: AppStrings.LOAN_GIVEN, actions: []),
      body: Padding(
        padding: EdgeInsets.only(left: 15.ss, right: 15.ss, bottom: 15.ss),
        child: ScrollviewWithScrollingChild(
          header: Padding(
            padding: EdgeInsets.only(top: 15.ss),
            child: Column(
              children: [
                creditDataWidget(
                  controller.userDetails.value?.extraInfo?.score,
                ),
                accountDetailsCardWidget(
                  future: controller.appServiceController.getUserBalance,
                ),
              ],
            ),
          ),

          // fixHeader: Container(
          //   color: AppColors.APP_BG,
          //   padding: EdgeInsets.only(left: 5.ss, bottom: 5.ss, top: 5.ss),
          //   child: Row(
          //     children: [
          //       Text("", style: TextThemeHelper.titleLR),
          //       horizontalSpaceTiny,
          //       const Icon(Kiwoo.down_open),
          //       const Spacer(),
          //       Text("", style: TextThemeHelper.EHTGTextStyle),
          //     ],
          //   ),
          // ),
          maxExtent: 40,
          minExtent: 40,
          body: loanGivenListWidget(),
        ),
      ),
    );
  }

  Widget loanGivenListWidget() {
    return ListBuilderWidget.future(
      future: controller.futureRequest,
      onEmptyText: "No Loan Found",
      itemBuilder: (context, item, _, [__]) {
        var loan = item.loan;
        return Padding(
          padding: const EdgeInsets.fromLTRB(3, 8, 3, 5),
          child: GestureDetector(
            onTap: () {
              loanDetailsBottomSHet(
                title: "Loan Given",
                name: loan.user?.name,
                amount: loan.amount,
                offeredInterest: item.offeredInterest,
                offeredTenure: item.offeredTenure,
                updatedAt: item.updatedAt,
                nextDue: loan.nextDue,
              );
            },
            child: LoanCard(
              token: controller.token,
              user: loan!.user,
              amount: loan.amount,
              interest: item.offeredInterest,
              tenure: item.offeredTenure,
              date: loan.updatedAt,
            ),
          ),
        );
      },
    );
  }
}
