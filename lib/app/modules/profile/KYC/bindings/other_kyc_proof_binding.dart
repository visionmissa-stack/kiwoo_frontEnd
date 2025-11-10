import 'package:kiwoo/app/modules/profile/KYC/controllers/other_kyc_proof_controller.dart';
import 'package:get/get.dart';

class OtherKycProofBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherKycProofController>(() => OtherKycProofController());
  }
}
