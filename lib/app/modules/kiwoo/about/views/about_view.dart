import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_string.dart';
import '../../../../global_widgets/app_bar.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: AppStrings.ABOUT_US,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.ss),
        child: Center(
            child: Text(
          AppStrings.ABOUT_US,
          style: TextStyle(fontSize: 20.ss),
        )),
      ),
    );
  }
}
