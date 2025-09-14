import 'package:flutter/widgets.dart';
import 'package:KIWOO/app/controllers/app_services_controller.dart';
import 'package:KIWOO/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../data/models/load_management_model.dart';
import '../../../data/models/user_detail_model.dart';
import '../providers/loan_provider.dart';

class LoansController extends GetxController {
  final provider = Get.put(LoanProvider());
  late final RxList loanRequestList;
  final formKey = GlobalKey<FormState>();
  final appServiceController = Get.find<AppServicesController>();

  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;
  int? get userID => Get.find<AppServicesController>().userDetails.value?.id;

  List<LoanManagementModel> loanManagementListTmp = [
    LoanManagementModel(
      id: 0,
      title: AppStrings.REQUEST_LOAN,
      subTitle: AppStrings.SUBMIT_THE_FORM_TO_GET_LOAN,
      leadingIcon: Kiwoo.request_loan,
      trailingIcon: Kiwoo.arrow_right,
      isSelected: false,
      onTap: () => Get.toNamed(Routes.REQUEST_LOAN),
    ),
    LoanManagementModel(
      id: 1,
      title: AppStrings.RECEIVED_REQUEST,
      subTitle: AppStrings.LOAN_REQUEST_FROM_OTHERS,
      leadingIcon: Kiwoo.received_request,
      trailingIcon: Kiwoo.arrow_right,
      isSelected: false,
      onTap: () => Get.toNamed(Routes.LOAN_REQUEST_RECEIVED),
    ),
    LoanManagementModel(
      id: 2,
      title: AppStrings.LOAN_RECEIVED,
      subTitle: AppStrings.MONEY_THAT_YOU_HAVE_BORROWED_FROM_OTHERS,
      leadingIcon: Kiwoo.loan_received,
      trailingIcon: Kiwoo.arrow_right,
      isSelected: false,
      onTap: () => Get.toNamed(Routes.LOAN_RECEIVED),
    ),
    LoanManagementModel(
      id: 3,
      title: AppStrings.LOAN_GIVEN,
      subTitle: AppStrings.MONEY_THAT_YOU_HAVE_LET_OTHER_PEOPLE_BORROW,
      leadingIcon: Kiwoo.loan_given,
      trailingIcon: Kiwoo.arrow_right,
      isSelected: false,
      onTap: () => Get.toNamed(Routes.LOAN_GIVEN),
    ),
    LoanManagementModel(
      id: 4,
      title: AppStrings.MY_LOAN_REQUEST,
      subTitle: AppStrings.LOAN_REQUEST_STATUS_TO_KNOW,
      leadingIcon: Kiwoo.loan_request,
      trailingIcon: Kiwoo.arrow_right,
      isSelected: false,
      onTap: () => Get.toNamed(Routes.LOAN_REQUEST_SENT),
    ),
  ];

  @override
  onInit() {
    loanRequestList = RxList.empty();
    super.onInit();
  }

  Future<bool> postOfferApi(
      String loanId, int offeredTenure, num offeredInterest) async {
    var result =
        await provider.postOfferApi(loanId, offeredTenure, offeredInterest);
    if (result?.isSuccess == true) {
      showMsg("Payment Request Successful", color: AppColors.PRIMARY);
      return true;
    }
    return false;
  }
}
