import 'package:kiwoo/app/global_widgets/list_builder_widget.dart';
import 'package:kiwoo/app/modules/loans/loanRequestSent/controllers/loan_request_sent_controller.dart';
import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';
import 'package:kiwoo/app/modules/loans/loanRequestSent/views/loan_request_offers_view.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../data/models/loan/loan_request_model.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/contact_list.dart';
import '../../../../global_widgets/label_widget.dart';
import '../../../chat/bindings/chat_screen_binding.dart';
import '../../../chat/views/chat_view.dart';

class LoanRequestSentDetailsView extends GetView {
  const LoanRequestSentDetailsView({this.loan, super.key});
  final LoanRequestModel? loan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: AppStrings.LOAN_REQUEST_DETAIL),
      body: FutureDataBuilder<LoanRequestModel>(
        future: () async {
          if (loan != null) {
            return loan;
          }
          if (Get.arguments['loan_id'] != null) {
            return Get.find<LoanRequestSentController>().getMyLoanRequest(
              Get.arguments['loan_id'],
            );
          }
          return null;
        },
        futureBuilder: (context, data, refresh) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.ss),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Requested Loan Details",
                    style: TextStyle(
                      fontSize: 16.fss,
                      color: const Color(0xFF1A1A1A),
                      fontFamily: FontPoppins.SEMIBOLD,
                    ),
                  ),
                  SizedBox(height: 12.ss),
                  lableWidget(
                    lbl: "Request Date",
                    val: data.createdAt!.format('dd, MMM yyyy'),
                  ),
                  SizedBox(height: 8.ss),
                  lableWidget(lbl: "Amount", val: "${(data.amount ?? 0)} EFCA"),
                  //     val:
                  //         "${(myLoanRequestDetailController.myLoanRequestDetail.amount ?? 0)} EFCA"),
                  SizedBox(height: 8.ss),
                  lableWidget(
                    lbl: "Interest Offered",
                    val: "${(data.interest ?? 0)} %",
                  ),
                  SizedBox(height: 8.ss),
                  lableWidget(
                    lbl: "Tenure Offered",
                    val: "${(data.tenure ?? 0)} Months",
                  ),
                  SizedBox(height: 8.ss),
                  lableWidget(
                    lbl: "Loan Status",
                    val: (data.status?.name ?? "").capitalizeFirst,
                  ),
                  SizedBox(height: 8.ss),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.35.sw,
                        child: Text(
                          "Loan requested",
                          style: TextStyle(
                            fontSize: 15.fss,
                            color: const Color(0xFF787878),
                            fontFamily: FontPoppins.MEDIUM,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet<List<int>>(
                            SizedBox(
                              height: .7.sh,
                              child: ContactListView(
                                onSubmit: (contacts) {
                                  Get.back();
                                },
                                loanId: data.id,
                                hidePhoneNumber: true,
                                onContactClick: (contact) => Get.to(
                                  () => const ChatView.newChat(),
                                  arguments: {...contact.toMap()},
                                  binding: ChatScreenBinding(),
                                ),
                              ),
                            ),
                            backgroundColor: AppColors.APP_BG,
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          width: 0.52.sw,
                          child: Text(
                            "click here to see\n your contacts",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.fss,
                              color: FontColors.RED,
                              fontFamily: FontPoppins.MEDIUM,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (data.status == LoanStatus.requested) ...[
                    SizedBox(height: 15.ss),
                    Center(
                      child: DaiLogButtonPrimary(
                        height: 50.ss,
                        buttonText: "Loan Offers",
                        onTap: () {
                          Get.to<bool>(
                            LoanRequestOffersView(data.id!),
                          )?.then((val) => val == true ? refresh() : null);
                        },
                      ),
                    ),
                  ],
                  SizedBox(height: 20.ss),
                ],
              ),
            ),
          );
        },
        isEmpty: (p0) => p0 == null,
        autoAddScroll: true,
      ),
    );
  }
}
