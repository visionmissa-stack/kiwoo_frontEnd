import 'package:KIWOO/app/core/api_helper/urls.dart';
import 'package:KIWOO/app/core/utils/actions/try_catch.dart';
import 'package:KIWOO/app/data/default_with_auth_provider.dart';
import 'package:KIWOO/app/data/models/server_response_model.dart';
import 'package:get/get.dart';

import '../../../core/api_helper/core_service.dart';

class LoanProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> postOfferApi(
    String loanID,
    int offeredTenure,
    num offeredInterest,
  ) async {
    var response = await tryCatch(() async {
      var response = await patch(
        Url.LOAN_OFFER + loanID,
        {"offered_tenure": offeredTenure, "offered_interest": offeredInterest},
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> loanLenderApi({
    required double amount,
    required double interest,
    required int tenure,
    required List contacts,
    required String lender,
  }) async {
    var body = {
      "amount": amount,
      "interest": interest,
      "tenure": tenure,
      "lender": lender,
      "contacts": contacts.isEmpty ? [] : contacts,
    };
    var response = await tryCatch(() async {
      var response = await post(Url.LOAN_REQUEST, body);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> loanRequestListApiCall(
      {Map<String, String>? query}) async {
    await 1.delay();
    var response = await tryCatch(() async {
      var response = await get(Url.LOAN_REQUEST, query: query);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> loanRequestApiCall(String loanId) async {
    await 1.delay();
    var response = await tryCatch(() async {
      var response = await get('${Url.LOAN_REQUEST}/$loanId');
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getOfferApi(String loanId) async {
    var response = await tryCatch(() async {
      var response = await get(Url.LOAN_OFFER + loanId);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> postOfferResponseAPi(
      bool accepted, String loanId, int offerId, String pin) async {
    var response = await tryCatch(() async {
      var response = await post(
        (accepted ? Url.LOAN_ACCEPT_OFFER : Url.LOAN_REJECT_OFFER) + loanId,
        {"offer_id": offerId, 'pin': pin},
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> postAcceptLoanAPi(String loanId, pin) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.LOAN_ACCEPT + loanId,
        {'pin': pin},
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> contactListApi(List<String> contact) async {
    var response = await tryCatch(() async {
      var response = await get(Url.USER_LIST, query: {
        'contacts': contact,
      });
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<void> contactListSAVEApi(Map data) async {
    try {
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<ServerResponseModel?> loantactListApi(String id) async {
    var response = await tryCatch(() async {
      var response = await get(Url.LOAN_CONTACTS + id);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getLoanReceivedApi() async {
    var response = await tryCatch(() async {
      var response = await get(Url.LOAN_RECEIVED);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getLoanGivenApi() async {
    var response = await tryCatch(() async {
      var response = await get(Url.LOAN_GIVEN);
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
