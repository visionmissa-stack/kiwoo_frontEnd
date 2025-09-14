import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_string.dart';
import '../../../../global_widgets/app_bar.dart';
import '../controllers/terms_of_use_controller.dart';

class TermsOfUseView extends GetView<TermsOfUseController> {
  const TermsOfUseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: AppStrings.TERMS_OF_USE,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.ss),
        child: Center(
            child: Text(
          AppStrings.TERMS_OF_USE,
          style: TextStyle(fontSize: 20.ss),
        )),
      ),
    );
  }
}
