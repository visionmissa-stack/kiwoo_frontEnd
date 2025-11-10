import 'package:kiwoo/app/controllers/app_services_controller.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_colors.dart';
import '../../../data/models/account_balance.dart';
import '../../../data/models/user_detail_model.dart';
import '../../../global_widgets/modal/bottom_sheet.dart';

class HomeController extends GetxController {
  final appServiceController = Get.find<AppServicesController>();
  final isLoading = false.obs;

  late final RxInt selectedIndex;

  List<Map<String, dynamic>> serviceListTmp = [
    {
      "id": 1,
      "label": "Cash In",
      "icon": Kiwoo.cash_in,
      "MaterialIcon": "",
      "onTap": () {
        boomSheetOptions<LedgerMethod>(
          options: [
            BottomSheetOption(
              label: "MTN MoMo",
              iconColor: Color(0xff0c507c),
              value: LedgerMethod.MTN,
              // icon: Kiwoo.mtn_momo,
              iconWidget: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(Kiwoo.mtn_momo, size: 30),
              ),
            ),
            BottomSheetOption(
              label: "AIRTEL Money",
              value: LedgerMethod.Airtel,
              icon: Kiwoo.credit_card,
            ),
            BottomSheetOption(
              label: "M-Pesa Money",
              value: LedgerMethod.M_Pesa,
              icon: Kiwoo.credit_card,
            ),
          ],
        ).then((resp) {
          if (resp == null) return;
          Get.toNamed(Routes.CASH_IN, parameters: {'methods': resp.name});
        });
      },
    },
    {
      "id": 2,
      "label": "Send/Receive money",
      "icon": Kiwoo.send_rece_money,
      "MaterialIcon": "",
      "onTap": () {
        boomSheetOptions<String>(
          options: [
            BottomSheetOption(
              label: "Send Money",
              value: Routes.SEND_MONEY,
              icon: Kiwoo.cash_out,
            ),
            BottomSheetOption(
              label: "Receive Money",
              value: Routes.RECEIVE_MONEY,
              icon: Kiwoo.cash_in,
            ),
          ],
        ).then((resp) {
          if (resp == null) return;
          Get.toNamed(resp);
        });
      },
    },
    {
      "id": 3,
      "label": "Cash-out",
      "icon": Kiwoo.cash_out,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.CASH_OUT),
    },
    {
      "id": 4,
      "label": "Transaction History",
      "icon": Kiwoo.loan_market,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.TRANSACTIONS),
    },
    {"id": 5, "label": "Payments", "icon": Kiwoo.cash_in, "MaterialIcon": ""},
    {
      "id": 6,
      "label": "Address Market",
      "icon": Kiwoo.market_address,
      "MaterialIcon": "",
    },
  ];

  int? get userID => Get.find<AppServicesController>().userDetails.value?.id;
  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;

  String categorizeCreditScore(int creditScore) {
    if (creditScore >= 750) {
      return "Excellent";
    } else if (creditScore >= 700) {
      return "Good";
    } else if (creditScore >= 650) {
      return "Fair";
    } else if (creditScore >= 600) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }

  void getUserDetails() async {
    isLoading.value = true;
    var response = await appServiceController.provider.getUserDetails();
    if (response?.isSuccess == true) {
      appServiceController.saveUserData(
        UserDetailModel.fromMap(response!.data!),
      );
    }
    isLoading.value = false;
  }

  Future<List<AccountBalanceModel>?> getUserBalance() async {
    var response = await appServiceController.provider.getUserBalance();
    if (response?.isSuccess == true) {
      return listAccountModelFromMap(response!.data);
    }
    return null;
  }

  @override
  void onInit() {
    int value = Get.arguments?['selectedIndex'] ?? 0;
    print("the int $value");
    selectedIndex = value.obs;
    super.onInit();
  }
}
