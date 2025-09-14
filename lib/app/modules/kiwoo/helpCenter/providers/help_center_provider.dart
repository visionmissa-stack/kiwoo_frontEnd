import 'package:KIWOO/app/data/default_with_auth_provider.dart';

import '../../../../core/api_helper/core_service.dart';
import '../../../../core/api_helper/urls.dart';
import '../../../../core/utils/actions/try_catch.dart';
import '../../../../data/models/server_response_model.dart';

class HelpCenterProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> createHelpCenterCase({
    required String message,
    required String name,
    required String email,
  }) async {
    var response = await tryCatch(() async {
      var response = await post<ServerResponseModel>(
        Url.HELP_CENTER,
        {
          'contact_name': name,
          'contact_email': email,
          'message': message,
        },
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
