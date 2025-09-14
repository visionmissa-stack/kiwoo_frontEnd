// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/font_family.dart';
import '../core/utils/image_name.dart';

class AccountBalanceCardWidget extends StatelessWidget {
  String? lable1;
  String? val1;
  String? lable2;
  String? val2;
  AccountBalanceCardWidget({
    super.key,
    this.lable1,
    this.val1,
    this.lable2,
    this.val2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgName.CARD_IMG),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.ss, vertical: 20.ss),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Balance",
              style: TextStyle(
                  fontSize: 17.fss,
                  color: const Color.fromARGB(255, 122, 122, 122)),
            ),
            SizedBox(height: 5.ss),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  val1 ?? "",
                  style: TextStyle(
                    fontSize: 25.fss,
                    fontFamily: FontPoppins.BOLD,
                    color: FontColors.BLACK,
                  ),
                ),
                Text(
                  lable1 ?? "",
                  style: TextStyle(
                    fontSize: 16.fss,
                    fontFamily: FontPoppins.MEDIUM,
                    color: FontColors.BLACK,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.vs),
            Center(
              child: Container(
                height: 1,
                width: .4.sw,
                color: AppColors.PRIMARY1,
              ),
            ),
            SizedBox(height: 15.ss),
            Text(
              "Account Balance",
              style: TextStyle(
                  fontSize: 17.fss,
                  color: const Color.fromARGB(255, 122, 122, 122)),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  val2 ?? "",
                  style: TextStyle(
                    fontSize: 25.fss,
                    fontFamily: FontPoppins.BOLD,
                    color: FontColors.BLACK,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
