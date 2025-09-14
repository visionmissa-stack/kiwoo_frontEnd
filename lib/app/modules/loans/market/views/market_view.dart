import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/font_family.dart';
import 'package:KIWOO/app/global_widgets/app_bar.dart';
import 'package:KIWOO/app/global_widgets/list_builder_widget.dart';
import 'package:KIWOO/app/modules/loans/market/controllers/market_controller.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/image_name.dart';
import '../../../../core/utils/text_teme_helper.dart';
import 'market_details.dart';

class MarketView extends GetView<MarketController> {
  const MarketView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: const AppBarWidgetTitle(title: AppStrings.LOAN_MARKET),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceSmall,
            creditBalanceCardWidget(),
            verticalSpaceSmall,
            Expanded(child: loanRequestsListWidget()),
          ],
        ),
      ),
    );
  }

  Widget creditBalanceCardWidget() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgName.CARD_SMALL_2_IMG),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.ss, vertical: 20.ss),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Credit Balance",
                  style: TextStyle(
                    fontSize: 17.fss,
                    color: FontColors.BLACK,
                    fontFamily: FontPoppins.MEDIUM,
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  "\$ 50, 000, 500",
                  style: TextStyle(
                    fontSize: 22.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                ImgName.AMERICA_BANK_IMG,
                height: 40.ss,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loanRequestsListWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(AppStrings.LOAN_REQUESTS,
                style: TextThemeHelper.headerLineListLable),
          ),
          Flexible(
            child: ListBuilderWidget.future(
                future: controller.futureRequest,
                onEmptyText: "Loan Market Empty for Now",
                itemBuilder: (context, item, _, [__]) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(MarketDetails(
                        loanId: item.id,
                        name: item.user!.name,
                        id: item.userId,
                        amount: item.amount.toString(),
                        interest: item.interest.toString(),
                        duration: item.tenure.toString(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 5),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            color: controller.userID == item.userId
                                ? AppColors.CARD_PRIMARY
                                : AppColors.YELLOW_CARD,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImgName.ELLIPSE_1,
                                    height: 40.ss,
                                    width: 40.ss,
                                  ),
                                  horizontalSpaceSmall,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 245.ss,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              // color: Colors.amber,
                                              width: 145.ss,
                                              child: Text("${item.user!.name}",
                                                  style:
                                                      TextThemeHelper.titleLR),
                                            ),
                                            // const Spacer(),
                                            SizedBox(
                                              //  color: Colors.blue,
                                              width: 100.ss,
                                              child: Text(
                                                  textAlign: TextAlign.right,
                                                  "${item.amount.toString()} EHTG",
                                                  style: TextThemeHelper
                                                      .EHTGTextStyle),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 245.ss,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text.rich(TextSpan(
                                              text: 'Credit Score ',
                                              style: TextThemeHelper
                                                  .subTitleGreyLR,
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: '650 Good',
                                                  style: TextThemeHelper
                                                      .subTitleLR,
                                                )
                                              ])),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              verticalSpaceSmall,
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              verticalSpaceTiny,
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  children: [
                                    Text("Interest",
                                        style: TextThemeHelper.subTitleGreyLR),
                                    horizontalSpaceSmall,
                                    Text("${item.interest}%",
                                        style: TextThemeHelper.subTitleLR),
                                    const Spacer(),
                                    Text("Duration",
                                        style: TextThemeHelper.subTitleGreyLR),
                                    horizontalSpaceSmall,
                                    Text("${item.tenure} month",
                                        style: TextThemeHelper.subTitleLR),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
