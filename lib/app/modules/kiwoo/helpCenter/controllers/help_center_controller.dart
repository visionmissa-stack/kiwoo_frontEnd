import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/modules/kiwoo/helpCenter/providers/help_center_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HelpCenterController extends GetxController with DefController {
  final GlobalKey<FormState> formKey = GlobalKey();
  late final HelpCenterProvider provider;
  String? fullName;

  String? emailSender;
  String? message;

  @override
  void onInit() {
    provider = Get.put(HelpCenterProvider());
    super.onInit();
  }

  Future<void> callCreateCaseApi() async {
    var response = await provider.createHelpCenterCase(
      message: message!,
      name: fullName!,
      email: emailSender!,
    );
    if (response?.isSuccess == true) {
      Get.back(closeOverlays: true);
      response!.showMessage();
    }
  }
}
