import 'package:get/get.dart';

import '../controllers/request_loan_controller.dart';

class RequestLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestLoanController>(
      () => RequestLoanController(),
    );
  }
}
