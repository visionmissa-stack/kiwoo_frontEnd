import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';
import 'package:KIWOO/app/global_widgets/list_builder_widget.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/account_balance_widget.dart';
import '../../../../global_widgets/custom_appbar.dart';
import '../../../../global_widgets/modal/bottom_sheet.dart';
import '../../../../global_widgets/modal/loan_card.dart';
import '../../../../global_widgets/score_widgets.dart';
import '../controllers/loan_given_controller.dart';

class LoanGivenView extends GetView<LoanGivenController> {
  const LoanGivenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          context,
          AppStrings.LOAN_GIVEN,
          true,
          true,
          const [],
          () {},
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                  left: 18.ss, right: 18.ss, top: 18.ss, bottom: 18.ss),
              child: Column(
                children: [
                  creditDataWidget(
                      controller.userDetails.value?.extraInfo?.score),
                  verticalSpaceRegular,
                  accountDetailsCardWidget(
                    future: controller.appServiceController.getUserBalance,
                  ),
                  loanReceivedListWidget(),
                ],
              )),
        ));
  }

  Widget loanReceivedListWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Row(
            children: [
              Text(
                "",
                style: TextThemeHelper.titleLR,
              ),
              horizontalSpaceTiny,
              const Icon(
                Kiwoo.down_open,
              ),
              const Spacer(),
              Text(
                "",
                style: TextThemeHelper.EHTGTextStyle,
              ),
            ],
          ),
        ),
        ListBuilderWidget.future(
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
        )
      ],
    );
  }
}
