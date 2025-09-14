import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_string.dart';
import '../../../../global_widgets/app_bar.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(
        title: AppStrings.PRIVACY_POLICY,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.ss),
        child: Center(
            child: Text(
          AppStrings.PRIVACY_POLICY,
          style: TextStyle(fontSize: 20.ss),
        )),
      ),
    );
  }
}
