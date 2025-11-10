import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../../core/utils/app_utility.dart';
import '../../../../../core/utils/text_teme_helper.dart';
import '../../../../../global_widgets/app_button.dart';

Future submitedSuccessDaiLogBox(
  IconData icon,
  String title,
  String subTitle,
  String btnTitle, [
  GestureTapCallback? onTap,
]) {
  return Get.dialog(
    barrierDismissible: false,
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              child: Column(
                children: [
                  Icon(icon, size: 65.s),
                  const SizedBox(height: 14),
                  Text(title, style: TextThemeHelper.dailogTitle),
                  const SizedBox(height: 14),
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextThemeHelper.dailogSubTitle,
                  ),
                  verticalSpaceMedium,
                  DaiLogButton(
                    buttonText: btnTitle,
                    height: 50.vs,
                    width: 250.s,
                    onTap: () {
                      onTap?.call();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
