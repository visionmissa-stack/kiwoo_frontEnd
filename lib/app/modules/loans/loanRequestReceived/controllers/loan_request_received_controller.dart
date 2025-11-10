import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/data/models/loan/loan_offers_model.dart';
import 'package:get/get.dart';

import '../../providers/loan_provider.dart';

class LoanRequestReceivedController extends GetxController with DefController {
  late final LoanProvider provider;

  @override
  void onInit() {
    provider = Get.put<LoanProvider>(LoanProvider());
    super.onInit();
  }

  Future<List<LoanOfferModel>?> futureRequest() async {
    var params = {"type": "contacts"};
    try {
      var response = await provider.loanRequestListApiCall(query: params);
      // Get.log("getRecievedRequestApiCall >>>>>>> $response");

      if (response?.isSuccess == true) {
        var data = listOfferFromListMap(response!.data);
        return data;
      } else {}
    } catch (e) {
      Get.log("contactListApiCall ==>${e.toString()}", isError: true);
    }
    return null;
  }

  Future<bool> postOfferApiCall({
    String loadId = "",
    required int duration,
    required double interest,
  }) async {
    try {
      var response = await provider.postOfferApi(loadId, duration, interest);

      if (response?.isSuccess == true) {
        Get.back(result: true);
        response?.showMessage();
        return true;
        // LoanRequestModel updatedLoan = LoanRequestModel.fromMap(response!.data);
      }
    } catch (e) {
      Get.log("getAllChatListApiCall ==>${e.toString()}", isError: true);
    }
    return false;
  }

  Future<bool> postAcceptLoanAPiCall({
    required int loadId,
    required String pin,
  }) async {
    try {
      var response = await provider.postAcceptLoanAPi(loadId.toString(), pin);
      if (response?.isSuccess == true) {
        response?.showMessage();
        return true;
      }
    } catch (e) {
      Get.log("getAllChatListApiCall ==>${e.toString()}", isError: true);
    }
    return false;
  }
}
