import 'package:get/get.dart';

import 'package:KIWOO/app/modules/profile/KYC/controllers/identity_controller.dart';

class IdentityKycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdentityController>(() => IdentityController());
  }
}
