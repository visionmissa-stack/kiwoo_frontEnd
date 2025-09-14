import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_services_controller.dart';
import '../providers/kyc_provider.dart';

class OtherKycProofController extends GetxController {
  late final KycProvider provider;
  final GlobalKey<FormState> formKey = GlobalKey();

  Map<String, dynamic> kycData = {'value': null, 'proof': null};

  final count = 0.obs;
  @override
  void onInit() {
    provider = Get.put(KycProvider());
    super.onInit();
  }

  Future<void> updateDocuments(String label, String url) async {
    var docId = await _uploadOcupationFile(url);
    if (docId != null) {
      var dataUpload = label == "address"
          ? {...kycData['value'], "${label}_doc": docId}
          : {label: kycData['value'], "${label}_doc": docId};
      var response =
          await provider.updateUserDocsApi(docId: {label: dataUpload});
      if (response?.isSuccess == true) {
        await Get.find<AppServicesController>().getUserDetails();
        response?.showMessage();
        Get.back(closeOverlays: true);
      }
    }
  }

  Future<String?> _uploadOcupationFile(String url) async {
    var result =
        await provider.sendProofApi(file: kycData['proof'], endPoint: url);
    if (result?.isSuccess == true) {
      return result!.data["file_id"]['id'];
    }
    return null;
  }
}
