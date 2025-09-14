import 'package:KIWOO/app/data/models/server_response_model.dart';
import 'package:get/get.dart';

import '../core/api_helper/urls.dart';

class DefaultProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Url.BASE_URL;
    httpClient.defaultDecoder = (body) {
      return ServerResponseModel.fromMap(body);
    };
    httpClient.timeout = const Duration(seconds: 15);
  }
}
