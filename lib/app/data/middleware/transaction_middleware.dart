import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/transactions/views/transaction_cash_detail_view.dart';

class TransactionMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    if (page == null) return null;
    var transactionId = int.tryParse(page.parameters?['transactionId'] ?? '');
    bool isDetails = transactionId != null;

    if (isDetails) {
      print("the get[age] ${Get.arguments} ${page.parameters}");

      return page.copy(
        // name: "Transaction_details",
        page: () => TransactionCashDetailView(
          id: transactionId,
        ),
      );
    }
    return page;
  }
}
