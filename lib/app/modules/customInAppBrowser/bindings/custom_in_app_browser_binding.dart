import 'package:get/get.dart';

import '../controllers/custom_in_app_browser_controller.dart';

class CustomInAppBrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomInAppBrowserController>(
      () => CustomInAppBrowserController(),
    );
  }
}
