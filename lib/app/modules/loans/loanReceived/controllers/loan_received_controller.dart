import 'package:get/get.dart';

import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/modules/loans/providers/loan_provider.dart';

import '../../../../data/models/loan/loan_request_model.dart';

class LoanReceivedController extends GetxController with DefController {
  late final LoanProvider provider;

  @override
  onInit() {
    provider = Get.put(LoanProvider());
    super.onInit();
  }

  Future<List<LoanRequestModel>?> getLoanReceivedApiCall() async {
    try {
      var response = await provider.getLoanReceivedApi();
      if (response?.isSuccess == true) {
        Get.log("getRecievedRequestApiCall>>>>>>>${response!.data}");
        return listLoanRequestModelFromMap(response.data);
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("getAllChatListApiCall ==>${e.toString()}", isError: true);
    }
    return null;
  }
}
