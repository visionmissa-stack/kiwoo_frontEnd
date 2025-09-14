import 'package:KIWOO/app/controllers/def_controller.dart';
import 'package:KIWOO/app/core/utils/storage_pro.dart';
import 'package:KIWOO/app/data/models/notifications/chat_notification_model.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../../data/chat_service_provider.dart';
import '../../../data/models/chat_model.dart';

class ChatController extends GetxController with DefController {
  late final RxList<ChatModel> chatList;
  late final RxList<ChatNotificationModel> notifChatList;
  late final RxList<ChatModel> filteredChatList;
  late final ChatServiceProvider chatProvider;

  @override
  void onInit() {
    chatProvider = Get.put(ChatServiceProvider());
    filteredChatList = RxList<ChatModel>.empty();
    notifChatList = RxList<ChatNotificationModel>();
    chatList = RxList<ChatModel>.empty(growable: true);
    addCurrentUserListener();
    getChatList();
    super.onInit();
  }

  void addCurrentUserListener() {
    GetStoragePro.listenAllObjects<ChatModel>(onData: (model) {
      chatList.assignAll(model);
    });
  }

  Future<void> getChatList() async {
    var response = await chatProvider.getAllChatListApiCall();
    if (response?.isSuccess == true) {
      var listMessage = listChatModelFromMap(response?.data);
      if (listMessage.isEmpty) {
        try {
          deleteAllObjects<ChatModel>();
        } catch (_) {}
        chatList.clear();
      } else {
        GetStoragePro.saveObjectsList<ChatModel>(listMessage);
      }
    } else {}
  }

  sendMessageToUser(String message, String id) async {
    chatProvider.sendMessage(content: message, chatID: id);
  }

  void search(String value) {
    if (value.isEmpty) {
      filteredChatList
          .assignAll(chatList); // Show all items if search text is empty
    } else {
      filteredChatList.assignAll(chatList.where((data) {
        return data.members
            .any((val) => val.name?.toLowerCase() == value.toLowerCase());
      }).toList());
    }
  }
}
