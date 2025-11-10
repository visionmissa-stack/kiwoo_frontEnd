import 'package:flutter/widgets.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:get/get.dart';

import '../../providers/loan_provider.dart';
import '../model/request_loan_model.dart';

class RequestLoanController extends GetxController {
  late final LoanProvider provider;
  late final GlobalKey<FormState> formKey;
  late RequestLoanModel loanRequest;
  final RxString searchContact = RxString('');

  @override
  void onInit() {
    provider = Get.put<LoanProvider>(LoanProvider());
    formKey = GlobalKey<FormState>();
    loanRequest = RequestLoanModel();
    super.onInit();
  }

  Future<bool> loanLenderApiCall() async {
    try {
      var response = await provider.loanLenderApi(
        amount: loanRequest.amount,
        interest: loanRequest.interest,
        tenure: loanRequest.tenure,
        lender: loanRequest.lender.name.snakeCase!,
        contacts: loanRequest.contacts,
      );

      if (response?.isSuccess == true) {
        return true;
      } else {
        var item = <String>[];
        if (response?.message[0] != null) {
          item.add(response!.message[0]);
        }
        response?.showMessage(message: item);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
