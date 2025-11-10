import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_services_controller.dart';
import '../../../../core/api_helper/urls.dart';
import '../providers/kyc_provider.dart';

class IncomeController extends GetxController with DefController {
  late final KycProvider provider;
  final GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> incomeValue = {'income': '', 'proof': null};

  @override
  onInit() {
    provider = Get.put(KycProvider());
    super.onInit();
  }

  Future<void> updateDocuments() async {
    var docId = await _uploadOcupationFile();
    if (docId != null) {
      var response = await provider.updateUserDocsApi(
        docId: {"income": incomeValue['income'], "income_doc": docId},
      );
      if (response?.isSuccess == true) {
        await Get.find<AppServicesController>().getUserDetails();
        response?.showMessage();
        Get.back(closeOverlays: true);
      }
    }
  }

  Future<String?> _uploadOcupationFile() async {
    var result = await provider.sendProofApi(
      file: incomeValue['proof'],
      endPoint: Url.UPLOAD_INCOME,
    );
    if (result?.isSuccess == true) {
      return result!.data["file_id"]['id'];
    }
    return null;
  }
}
