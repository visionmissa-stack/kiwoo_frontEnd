import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/image_name.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';
import 'package:kiwoo/app/global_widgets/list_builder_widget.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/account_balance_widget.dart';
import '../../../../global_widgets/modal/bottom_sheet.dart';
import '../../../../global_widgets/score_widgets.dart';
import '../../../../global_widgets/scrollview_with_scrolling_child.dart';
import '../controllers/loan_received_controller.dart';

class LoanReceivedView extends GetView<LoanReceivedController> {
  const LoanReceivedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(title: AppStrings.LOAN_RECEIVED, actions: []),
      body: Padding(
        padding: EdgeInsets.only(left: 15.ss, right: 15.ss, bottom: 15.ss),
        child: ScrollviewWithScrollingChild(
          header: Padding(
            padding: EdgeInsets.only(top: 15.ss),
            child: creditDataWidget(
              controller.userDetails.value?.extraInfo?.score,
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
          body: loanReceivedListWidget(),
        ),
      ),
    );
  }

  Widget loanReceivedListWidget() {
    return ListBuilderWidget.future(
      future: controller.getLoanReceivedApiCall,
      physics: const NeverScrollableScrollPhysics(),
      onEmptyText: "You didnt received any loan for now",
      itemBuilder: (context, item, _, [__]) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(3, 8, 3, 5),
          child: GestureDetector(
            onTap: () {
              loanDetailsBottomSHet(
                title: "Loan Received Details",
                name: item.offer?.contact?.name,
                amount: item.amount,
                offeredInterest: item.offer?.offeredInterest,
                offeredTenure: item.offer?.offeredTenure,
                updatedAt: item.updatedAt,
                nextDue: item.nextDue,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 1,
                    offset: const Offset(0.0, 1.5),
                  ),
                ],
                color: AppColors.CARD_PRIMARY,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(ImgName.ELLIPSE_1, height: 45.ss),
                        horizontalSpaceRegular,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.offer?.contact?.name ?? "",
                              style: TextThemeHelper.titleLR,
                            ),
                            verticalSpaceTiny,
                            Text(
                              "${item.amount} exfa",
                              style: TextThemeHelper.subTitleGreyLR,
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Divider(color: Colors.grey.shade300),
                    verticalSpaceTiny,
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        children: [
                          Text(
                            "Interest",
                            style: TextThemeHelper.subTitleGreyLR,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "${item.offer?.offeredInterest} %",
                            style: TextThemeHelper.subTitleLR,
                          ),
                          const Spacer(),
                          Text(
                            "Duration",
                            style: TextThemeHelper.subTitleGreyLR,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "${item.offer?.offeredTenure} month",
                            style: TextThemeHelper.subTitleLR,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
