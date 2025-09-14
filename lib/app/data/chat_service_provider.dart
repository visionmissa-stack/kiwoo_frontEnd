// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:KIWOO/app/data/default_with_auth_provider.dart';

import '../core/api_helper/core_service.dart';
import '../core/api_helper/urls.dart';
import '../core/utils/actions/try_catch.dart';
import 'models/server_response_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatServiceProvider extends DefaultWithAuthProvider {
  ChatServiceProvider();

  Future<ServerResponseModel?> getAllMessageApiCall(String chatID) async {
    var params = {
      "page": '0',
    };
    var response = await tryCatch(() async {
      var result = await get<ServerResponseModel>("${Url.GET_MESSAGE}$chatID",
          query: params);
      return CoreService.returnResponse(result);
    });
    return response;
  }

  Future<ServerResponseModel?> getAllChatListApiCall() async {
    var params = {
      "page": '0',
    };
    var response = await tryCatch(() async {
      var result = await get<ServerResponseModel>(Url.CHAT_LIST, query: params);
      return CoreService.returnResponse(result);
    });
    return response;
  }

  sendMessage({required String content, required String chatID}) {}

  Socket getSocket() {
    return io(
      Url.SOCKET_URL,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNewConnection()
          .setReconnectionDelay(Duration.millisecondsPerSecond * 5)
          .setExtraHeaders({'Authorization': "Bearer $token"})
          .build(),
    );
  }
}
