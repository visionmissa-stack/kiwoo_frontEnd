import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/image_name.dart';
import '../controllers/loans_controller.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../../../global_widgets/progress_indicator.dart';

class LoansView extends GetView<LoansController> {
  const LoansView({super.key});
  @override
  Widget build(BuildContext context) {
    //  profileController.getValuefromLocal();
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              searchBar(),
              verticalSpaceRegular,
              accountDetailsCardWidget(),
              verticalSpaceRegular,
              loanManagementListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Card(
      color: AppColors.WHITE,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        height: 55.vs,
        width: 400.s,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search... ",
              style: TextStyle(
                fontSize: 17.fss,
                color: const Color.fromARGB(255, 140, 140, 140),
              ),
            ),
            Icon(Kiwoo.search, color: FontColors.GREY_140),
          ],
        ),
      ),
    );
  }

  Widget accountDetailsCardWidget() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgName.CARD_MEDIUM_IMG),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.ss, vertical: 16.ss),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(
                //   ImgName.AMERICA_BANK_IMG,
                //   height: 40.ss,
                //   fit: BoxFit.cover,
                // ),
                SizedBox(height: 5.ss),
                Text(
                  "My Credit Score",
                  style: TextStyle(
                    fontSize: 17.fss,
                    color: FontColors.BLACK,
                    fontFamily: FontPoppins.MEDIUM,
                  ),
                ),
                SizedBox(height: 4.ss),
                Text(
                  "Last updated: February 1, 2024",
                  style: TextStyle(
                    fontSize: 12.fss,
                    color: FontColors.GREY,
                    fontFamily: FontPoppins.REGULAR,
                  ),
                ),
              ],
            ),
            Center(
              child: RadialGaugeProgressBar2(
                scoreTextSize: 12,
                scoreStatusTextSize: 6,
                progress:
                    (controller.userDetails.value?.extraInfo?.score ?? 0) /
                    850, // Progress based on credit score
                creditScore: controller.userDetails.value?.extraInfo?.score,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loanManagementListWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "Loan Management",
              style: TextThemeHelper.headerLineListLable,
            ),
          ),
          ListView.builder(
            itemCount: controller.loanManagementListTmp.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                color: AppColors.PRIMARY_BG,
                margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: controller.loanManagementListTmp[index].onTap,
                  leading: Icon(
                    controller.loanManagementListTmp[index].leadingIcon,
                    size: 45.s,
                  ),
                  title: Text(
                    controller.loanManagementListTmp[index].title ?? "",
                    style: TextStyle(
                      fontSize: 16.fss,
                      fontFamily: FontPoppins.SEMIBOLD,
                    ),
                  ),
                  subtitle: Text(
                    controller.loanManagementListTmp[index].subTitle ?? "",
                    style: TextStyle(
                      fontSize: 12.fss,
                      fontFamily: FontPoppins.MEDIUM,
                    ),
                  ),
                  trailing: Icon(Kiwoo.angle_right, size: 35.vs),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
