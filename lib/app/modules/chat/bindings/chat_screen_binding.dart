import 'package:get/get.dart';

import 'package:KIWOO/app/modules/chat/controllers/chat_screen_controller.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatScreenController>(
      () => ChatScreenController(),
    );
  }
}
