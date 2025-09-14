import 'package:KIWOO/app/controllers/app_services_controller.dart';
import 'package:KIWOO/app/controllers/def_controller.dart';
import 'package:get/get.dart';

import '../../../../core/utils/enums.dart';
import '../../../../data/models/user_profil_update.dart';
import '../providers/kyc_provider.dart';

class KycController extends GetxController with DefController {
  late KycProvider provider;

  @override
  void onInit() {
    provider = KycProvider();
    super.onInit();
  }

  sendIdentityProof(Map<IdentityType, String> response) async {
    if (response.length == 3) {
      Get.find<AppServicesController>().provider.updateUserProfile(
            profil: UserProfilUpdate(
              idDoc: response,
              name: userDetails.value?.name,
              phone: userDetails.value?.phone,
            ),
          );
      await Get.find<AppServicesController>().getUserDetails();
    }
  }
}
