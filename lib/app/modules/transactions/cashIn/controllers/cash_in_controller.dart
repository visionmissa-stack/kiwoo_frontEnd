import 'package:kiwoo/app/core/utils/app_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/enums.dart';
import '../../providers/cash_provider.dart';

class CashInController extends GetxController {
  late final LedgerMethod? method;
  late final CashProvider provider;
  late final GlobalKey<FormState> formKey;
  double amount = 0;
  @override
  onInit() {
    method = LedgerMethod.fromMap(Get.parameters['methods']);
    provider = Get.put(CashProvider());
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  Future<Map<String, dynamic>> getFee({required double amount}) async {
    if (amount == 0) return {};
    var response = await provider.getFeeApi(
      amount: amount,
      type: 'cashin',
      method: method!.name,
    );
    if (response?.isSuccess == true) {
      return response!.data;
    }
    return {};
  }

  Future<bool> cashIn([currency = "EUR"]) async {
    var response = await provider.cashInApi(
      amount: amount,
      currency: currency,
      method: method!.name,
    );
    if (response?.isSuccess == true) {
      return true;
    }
    return false;
  }
}
