import 'package:KIWOO/app/controllers/def_controller.dart';
import 'package:KIWOO/app/data/models/controller_with_future.dart';
import 'package:KIWOO/app/modules/loans/providers/loan_provider.dart';
import 'package:get/get.dart';

import '../../../../data/models/loan/loan_request_model.dart';

class MarketController extends GetxController
    with DefController, ControllerWithFuture<List<LoanRequestModel>> {
  late final LoanProvider provider;

  @override
  onInit() {
    provider = Get.put(LoanProvider());
    refreshFuture();
    super.onInit();
  }

  @override
  Future<List<LoanRequestModel>?> futureRequest() async {
    var params = {
      "type": "market",
    };

    try {
      var response = await provider.loanRequestListApiCall(query: params);

      if (response?.isSuccess == true) {
        return listLoanRequestModelFromMap(response!.data);
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("getLoanRequestListApiCall ==>${e.toString()}", isError: true);
    }
    return null;
  }
}
