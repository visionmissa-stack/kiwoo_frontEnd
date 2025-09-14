import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/app_colors.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';
import 'package:KIWOO/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../../../global_widgets/app_button.dart';
import '../controllers/connection_controller.dart';

class ConnectionView extends GetView<ConnectionController> {
  const ConnectionView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.provider;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Kiwoo.logo,
              size: 150.ss,
              color: AppColors.PRIMARY2,
            ),
            verticalSpaceRegular,
            Text(
              AppStrings.WELCOME_TO_KIWOO_WALLET,
              textAlign: TextAlign.center,
              style: TextThemeHelper.welcomeTitle,
            ),
            verticalSpaceMedium,
            customeAuthButton(
              lableName: AppStrings.LOG_IN,
              onTap: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            verticalSpaceRegular,
            customeAuthButton2(
              lableName: AppStrings.REGISTER,
              onTap: () {
                Get.toNamed(Routes.REGISTER);
              },
            ),
          ],
        ),
      ),
    );
  }
}
