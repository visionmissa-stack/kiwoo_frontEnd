import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/modules/loans/loanRequestSent/views/loan_request_sent_details_view.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/account_balance_widget.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../global_widgets/scrollview_with_scrolling_child.dart';
import '../controllers/loan_request_sent_controller.dart';

final TextStyle selectedStyle = TextStyle(
  fontFamily: FontPoppins.MEDIUM,
  color: AppColors.PRIMARY,
);
final TextStyle unselectedStyle = selectedStyle.copyWith(color: Colors.black);

class LoanRequestSentView extends GetView<LoanRequestSentController> {
  const LoanRequestSentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(title: AppStrings.MY_LOAN_REQUEST, actions: []),
      body: Padding(
        padding: EdgeInsets.only(left: 15.ss, right: 15.ss, bottom: 15.ss),
        child: ScrollviewWithScrollingChild(
          header: Padding(
            padding: EdgeInsets.only(top: 15.ss),
            child: accountDetailsCardWidget(
              future: controller.appServiceController.getUserBalance,
            ),
          ),
          fixHeader: Container(
            color: AppColors.APP_BG,
            padding: EdgeInsets.only(left: 5.ss, bottom: 5.ss, top: 5.ss),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  final current = controller.sortDirection.value;

                  return PopupMenuButton<SortDirection>(
                    icon: const Icon(Icons.sort),
                    onSelected: (item) {
                      PopupMenuItemState();
                      controller.sortDirection(item);
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<SortDirection>(
                          value: SortDirection.asc,
                          child: Text(
                            'Asc',
                            style: current == SortDirection.asc
                                ? selectedStyle
                                : unselectedStyle,
                          ),
                        ),
                        PopupMenuItem<SortDirection>(
                          value: SortDirection.desc,
                          child: Text(
                            'Desc',
                            style: current == SortDirection.desc
                                ? selectedStyle
                                : unselectedStyle,
                          ),
                        ),
                      ];
                    },
                  );
                }),
                Obx(() {
                  final current = controller.sortDirection.value;

                  return PopupMenuButton<LoanStatus>(
                    icon: const Icon(Icons.start_sharp),
                    onSelected: (item) {
                      // controller.sortDirection(item);
                    },
                    itemBuilder: (context) {
                      return [
                        ...LoanStatus.values.map(
                          (val) => PopupMenuItem<LoanStatus>(
                            value: val,
                            child: Text(
                              '${val.name.capitalize}',
                              style: current == val
                                  ? selectedStyle
                                  : unselectedStyle,
                            ),
                          ),
                        ),
                      ];
                    },
                  );
                }),
              ],
            ),
          ),
          maxExtent: 40,
          minExtent: 40,
          body: sentRequestList(),
        ),
      ),
    );
  }

  Widget sentRequestList() {
    return ListBuilderWidget.future(
      future: controller.futureRequest,
      futureBuilder: (p0, item, childFunction) {
        return Obx(() {
          var data = controller.sortingData(
            item,
            controller.sortDirection.value,
          );
          return childFunction(data);
        });
      },
      itemBuilder: (context, item, _, [__]) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Get.to(
                LoanRequestSentDetailsView(loan: item),
                arguments: {"id": item.id},
              );
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: AppColors.CARD_PRIMARY,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // "20, Mar 2024",
                              item.createdAt!.since(),
                              style: TextThemeHelper.titleLR,
                            ),
                            const Spacer(),
                            Text(
                              textAlign: TextAlign.right,
                              item.amount!.toEGTH,
                              style: TextThemeHelper.EHTGTextStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text.rich(
                            TextSpan(
                              text: 'Loan Status : ',
                              style: TextStyle(
                                fontSize: 13.fss,
                                color: FontColors.BLACK,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text:
                                      (item.status?.name ?? "").capitalizeFirst,
                                  style: TextStyle(
                                    fontSize: 13.fss,
                                    color: FontColors.RED,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            "${(item.interest ?? 0)}%",
                            style: TextThemeHelper.subTitleLR,
                          ),
                          const Spacer(),
                          Text(
                            "Duration",
                            style: TextThemeHelper.subTitleGreyLR,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "${(item.tenure ?? 0)} month",
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
