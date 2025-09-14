import 'package:get/get.dart';

import '../controllers/loan_given_controller.dart';

class LoanGivenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanGivenController>(
      () => LoanGivenController(),
    );
  }
}
