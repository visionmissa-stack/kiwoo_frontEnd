import 'package:KIWOO/app/data/models/controller_with_future.dart';
import 'package:KIWOO/app/modules/loans/providers/loan_provider.dart';
import 'package:get/get.dart';

import '../../../../controllers/def_controller.dart';
import '../../../../data/models/loan/loan_offers_model.dart';

class LoanGivenController extends GetxController
    with DefController, ControllerWithFuture<List<LoanOfferModel>?> {
  late final LoanProvider provider;

  @override
  void onInit() {
    provider = Get.put(LoanProvider());
    refreshFuture();
    super.onInit();
  }

  void selectedLoan(loanGivenList) {}

  @override
  Future<List<LoanOfferModel>?> futureRequest() async {
    try {
      var response = await provider.getLoanGivenApi();

      if (response?.isSuccess == true) {
        return listOfferFromListMap(response!.data);
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("getAllChatListApiCall ==>${e.toString()}", isError: true);
    }
    return null;
  }
}
