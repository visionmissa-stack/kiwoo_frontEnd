import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import 'app_colors.dart';
import 'app_string.dart';
import 'app_utility.dart';
import 'kiwoo_icons.dart';
import 'text_teme_helper.dart';

class PresentationPageHeader extends GetWidget {
  const PresentationPageHeader({super.key, required this.pageTitle});
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 90.ss),
        Center(
          child: Column(
            children: [
              Icon(
                Kiwoo.logo,
                size: 130.ss,
                color: AppColors.PRIMARY2,
              ),
              verticalSpaceSmall,
              Text(
                AppStrings.EASY_AFFORDABLE_BANKING,
                textAlign: TextAlign.center,
                style: TextThemeHelper.authTitle,
              ),
            ],
          ),
        ),
        verticalSpaceRegular,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.ss,
          ),
          child: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: TextThemeHelper.authHeadlineSmall,
          ),
        ),
      ],
    );
  }
}
