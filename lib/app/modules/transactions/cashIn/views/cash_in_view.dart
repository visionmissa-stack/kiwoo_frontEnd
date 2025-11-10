import 'package:kiwoo/app/core/utils/app_utility.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/modules/transactions/cashIn/views/mtn_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global_widgets/custom_appbar.dart';
import '../controllers/cash_in_controller.dart';

class CashInView extends GetView<CashInController> {
  const CashInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, "Cash In", true, true, const [], () {}),
      body: bodyWidet(),
    );
  }

  Widget bodyWidet() {
    switch (controller.method) {
      case LedgerMethod.MTN:
        return const MTNView();

      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text("This Method is unvailable for now"),
            verticalSpaceRegular,
            Center(
              child: FilledButton(
                onPressed: Get.back,
                child: const Text("Back"),
              ),
            ),
          ],
        );
    }
  }
}
