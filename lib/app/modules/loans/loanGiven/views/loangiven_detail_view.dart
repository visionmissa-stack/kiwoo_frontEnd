import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/formatters/extension.dart';
import 'package:KIWOO/app/global_widgets/app_bar.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../data/models/loan/loan_offers_model.dart';
import '../../../../data/models/loan/loan_request_model.dart';
import '../../../../global_widgets/label_widget.dart';

class LoangivenDetailView extends GetView {
  const LoangivenDetailView({super.key, required this.loanGiven});
  final LoanOfferModel loanGiven;
  LoanRequestModel? get loan => loanGiven.loan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: const AppBarWidgetTitle(title: AppStrings.LOAN_GIVEN_DETAILS),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.ss),
          child: Column(
            children: [
              lableWidget(lbl: "Name", val: loan?.user?.name),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Amount",
                val: "${loan?.amount} EHTG",
              ),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Tenure",
                val: "${loanGiven.offeredTenure} Months",
              ),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Interest",
                val: "${loanGiven.offeredInterest} %",
              ),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Loan Given On",
                val: loanGiven.updatedAt?.since(),
              ),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Next EMI Receive Date",
                val: loan?.nextDue?.afterSince('dd, MMM yyyy'),
              ),
              SizedBox(height: 8.ss),
              lableWidget(
                lbl: "Loan Complete Date",
                val: loan?.updatedAt
                    ?.calculateLoanCompletionDate(loanGiven.offeredTenure ?? 0)
                    .format('dd, MMM yyyy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
