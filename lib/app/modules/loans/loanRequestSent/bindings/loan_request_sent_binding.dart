import 'package:get/get.dart';

import '../controllers/loan_request_sent_controller.dart';

class LoanRequestSentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanRequestSentController>(
      () => LoanRequestSentController(),
    );
  }
}
