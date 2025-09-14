import 'package:KIWOO/app/controllers/app_services_controller.dart';
import 'package:KIWOO/app/data/default_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'models/storage_box_model.dart';

class DefaultWithAuthProvider extends DefaultProvider {
  String? get token => StorageBox.token.val;
  @override
  void onInit() {
    httpClient.addRequestModifier(_autoeh);

    super.onInit();
  }

  Request _autoeh(Request request) {
    request.headers['Authorization'] = "Bearer $token";
    return request;
  }
}
