import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/data/models/controller_with_future.dart';
import 'package:kiwoo/app/data/models/payment_receipt_model.dart';
import 'package:kiwoo/app/modules/transactions/providers/transactions_provider.dart';
import 'package:get/get.dart';

import '../../../data/models/transaction_model.dart';

class TransactionsController extends GetxController
    with DefController, ControllerWithFuture<List<TransactionModel>> {
  late TransactionsProvider provider;

  @override
  onInit() {
    provider = Get.put(TransactionsProvider());
    refreshFuture();
    super.onInit();
  }

  @override
  Future<List<TransactionModel>> futureRequest() async {
    var response = await provider.getTransactions(page: 0, perPage: 100);
    if (response?.isSuccess == true) {
      return TransactionModel.fromList(response!.data);
    }

    return [];
  }

  Future<PaymentReceiptData?> getTransactionDetail(int id) async {
    var response = await provider.getTransactionDetailAPI(id: id);
    if (response?.isSuccess == true) {
      return PaymentReceiptData.fromMap(response!.data);
    }
    return null;
  }
}
