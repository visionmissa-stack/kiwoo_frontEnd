import 'package:get/get.dart';

import '../controllers/cashout_controller.dart';

class CashoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashoutController>(
      () => CashoutController(),
    );
  }
}
