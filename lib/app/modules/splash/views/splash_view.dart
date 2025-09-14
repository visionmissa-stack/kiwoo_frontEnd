import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/app_string.dart';
import '../../../core/utils/image_name.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImgName.PLASH_ICON,
                width: 450.vs,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 250.ss),
                child: Text(
                  AppStrings.APP_NAME,
                  style: TextThemeHelper.appNameLarge,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ImgName.SPLASH_SCREEN,
                width: 1.sw,
              ),
            )
          ],
        ),
      ),
    );
  }
}
