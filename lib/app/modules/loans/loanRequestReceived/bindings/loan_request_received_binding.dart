import 'package:get/get.dart';

import '../controllers/loan_request_received_controller.dart';

class LoanRequestReceivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanRequestReceivedController>(
      () => LoanRequestReceivedController(),
    );
  }
}
