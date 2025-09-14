import 'package:get/get.dart';

import '../controllers/loan_received_controller.dart';

class LoanReceivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanReceivedController>(
      () => LoanReceivedController(),
    );
  }
}
