import 'package:get/get.dart';

import 'package:kiwoo/app/modules/profile/KYC/controllers/identity_controller.dart';
import 'package:kiwoo/app/modules/profile/KYC/controllers/income_controller.dart';
import 'package:kiwoo/app/modules/profile/KYC/controllers/occupation_controller.dart';
import 'package:kiwoo/app/modules/profile/KYC/controllers/other_kyc_proof_controller.dart';

import '../controllers/kyc_controller.dart';

class KycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherKycProofController>(() => OtherKycProofController());
    Get.lazyPut<IncomeController>(() => IncomeController());
    Get.lazyPut<OccupationController>(() => OccupationController());
    Get.lazyPut<IdentityController>(() => IdentityController());
    Get.lazyPut<KycController>(() => KycController());
  }
}
