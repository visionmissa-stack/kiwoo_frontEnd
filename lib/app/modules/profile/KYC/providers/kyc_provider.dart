import 'package:get/get.dart';

import '../../../../core/api_helper/core_service.dart';
import '../../../../core/api_helper/urls.dart';
import '../../../../core/utils/actions/try_catch.dart';
import '../../../../data/default_with_auth_provider.dart';
import '../../../../data/models/document_model.dart';
import '../../../../data/models/server_response_model.dart';

class KycProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> sendProofApi(
      {required FileData file, required String endPoint}) async {
    var data = FormData({
      "file": MultipartFile(
        file.bytes,
        filename: file.name,
        contentType: file.mimeType,
      ),
    });
    var response = await tryCatch(() async {
      var response = await post<ServerResponseModel>(
        endPoint,
        data,
        contentType: 'multipart/form-data',
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> updateUserDocsApi(
      {required Map<String, dynamic> docId}) async {
    var response = await tryCatch(() async {
      var response = await patch<ServerResponseModel>(
        Url.UPDATE_USER_DOCS,
        docId,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
