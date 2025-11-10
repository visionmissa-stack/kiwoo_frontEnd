import 'package:flutter/material.dart';
import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/data/models/loan/loan_offers_model.dart';
import 'package:kiwoo/app/modules/loans/providers/loan_provider.dart';
import 'package:get/get.dart';

import '../../../../data/models/controller_with_future.dart';
import '../../../../data/models/loan/loan_request_model.dart';

class LoanRequestSentController extends GetxController
    with DefController, ControllerWithFuture<List<LoanRequestModel>?> {
  late final LoanProvider provider;
  late final Rx<SortDirection> sortDirection;
  late final Rx<LoanStatus?> loanStatus;

  @override
  void onInit() {
    provider = Get.put<LoanProvider>(LoanProvider());
    sortDirection = Rx<SortDirection>(SortDirection.desc);
    loanStatus = Rx(null);
    refreshFuture();
    super.onInit();
  }

  @override
  Future<List<LoanRequestModel>> futureRequest() async {
    try {
      var response = await provider.loanRequestListApiCall();
      if (response?.isSuccess == true) {
        debugPrint("loanRequestListApiCall>>>>>> $response");
        return listLoanRequestModelFromMap(response!.data);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("loanRequestListApiCall error>>>>>> $e");

      return [];
    }
  }

  Future<LoanRequestModel?> getMyLoanRequest(String id) async {
    try {
      var response = await provider.loanRequestApiCall(id);
      if (response?.isSuccess == true) {
        debugPrint("loanRequestListApiCall>>>>>> $response");
        return LoanRequestModel.fromMap(response!.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("loanRequestListApiCall error>>>>>> $e");

      return null;
    }
  }

  List<LoanRequestModel> sortingData(
    List<LoanRequestModel> loanList,
    SortDirection direction,
  ) {
    var newList = [...loanList];
    if (direction == SortDirection.desc) {
      //sorting in ascending order
      newList.sort((a, b) {
        return b.createdAt!.compareTo(a.createdAt!);
      });
    } else {
      //sorting in descending order
      newList.sort((a, b) {
        return a.createdAt!.compareTo(b.createdAt!);
      });
    }
    return newList;
  }

  Future<List<LoanOfferModel>> getOfferApiCall(String loanId) async {
    try {
      var response = await provider.getOfferApi(loanId);
      if (response?.isSuccess == true) {
        Get.log("getOfferApiCall>>>>>>>${response!.data}");
        return listOfferFromListMap(response.data);
      } else {
        return [];
      }
    } catch (e) {
      Get.log("Error getAllChatListApiCall ==>${e.toString()}", isError: true);
      rethrow;
    }
  }

  Future<void> postOfferResponseApiCall(
    bool accepted,
    int loanId,
    int id,
    String pin,
  ) async {
    try {
      var response = await provider.postOfferResponseAPi(
        accepted,
        loanId.toString(),
        id,
        pin,
      );

      if (response?.isSuccess == true) {
        Get.back(result: true, closeOverlays: true);
        response!.showMessage();
      } else {}
    } catch (e) {
      Get.log(
        "error postOfferResponseAPiCall ==>${e.toString()}",
        isError: true,
      );
    }
  }
}
