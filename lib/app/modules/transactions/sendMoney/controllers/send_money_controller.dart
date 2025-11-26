import 'package:kiwoo/app/modules/transactions/bindings/transactions_binding.dart';
import 'package:kiwoo/app/modules/transactions/providers/transactions_provider.dart';
import 'package:get/get.dart';
import 'package:kiwoo/app/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/reactive_forms/phone_number/validators.dart'
    show PhoneValidators;
import '../../../../data/models/payment_receipt_model.dart';
import '../../../../data/models/validation_info_model.dart';
import '../../views/transaction_detail_view.dart';
import '../views/payment_receipt.dart';

class SendMoneyController extends GetxController {
  late final TransactionsProvider provider;
  late final FormGroup formGroup;
  final canNext = false.obs;
  @override
  void onInit() {
    formGroup = FormGroup({
      "phone": FormControl<String>(
        validators: [PhoneValidators.required, PhoneValidators.valid],
      ),
      'amount': FormControl<double>(
        validators: [Validators.required, Validators.min(100)],
      ),
    });
    provider = Get.put<TransactionsProvider>(TransactionsProvider());
    super.onInit();
  }

  Future<ValidationData?> getValidationInfo(
    String number,
    double amount,
  ) async {
    try {
      var response = await provider.getvalidationInfo(
        phone: number,
        amount: amount,
      );
      if (response?.isSuccess == true) {
        return ValidationData.fromMap(response!.data);
      } else {
        response?.showMessage();
        return null;
      }
    } catch (e) {
      Get.log("getValidationInfoApiCall ==>${e.toString()}", isError: true);
      return null;
    }
  }

  Future<void> sendMoney({
    required int transactionID,
    required String pin,
  }) async {
    try {
      var response = await provider.sendMoney(
        transactionID: transactionID,
        pin: pin,
      );
      if (response?.isSuccess == true) {
        Get.offUntil(
          GetPageRoute(
            page: () => TransactionDetailView(id: response!.data['id']),
            binding: TransactionsBinding(),
          ),
          (route) {
            return route.settings.name == Routes.HOME;
          },
        );
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("transferMoneyRequestApiCall ==> ${e.toString()}", isError: true);
    }
  }
}
