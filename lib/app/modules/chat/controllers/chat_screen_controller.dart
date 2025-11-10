// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:kiwoo/app/core/utils/actions/try_catch.dart';
import 'package:kiwoo/app/core/utils/app_string.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/storage_pro.dart';
import 'package:kiwoo/app/data/models/contact_list_model.dart';
import 'package:flutter/material.dart';
import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../controllers/chat_socket_service.dart';
import '../../../core/api_helper/app_exception.dart';
import '../../../core/utils/app_utility.dart';
import '../../../data/models/message_model.dart';
import '../../../data/models/chat_model.dart';

class ChatScreenController extends GetxController with DefController {
  late String? chatId;
  late String? name;
  late final int? userId;
  late ChatSocketService socketService;
  final RxList<Message> messages = RxList<Message>.empty(growable: true);
  final RxBool isTyping = false.obs;
  Timer? isTypingDelayed;
  late final TextEditingController messageInputController;
  late final ScrollController scrollController;
  late Rx<ChatModel> chatRoom;
  late final String? avatar;
  Worker? chatRoomWorker;

  final statusText = ''.obs;

  @override
  void onInit() {
    messageInputController = TextEditingController();
    scrollController = ScrollController();
    socketService = Get.put(ChatSocketService(), permanent: false);
    chatRoom = Rx<ChatModel>(
      (Get.arguments['chat_id'] != null
              ? getObjectById<ChatModel>(Get.arguments['chat_id'])
              : null) ??
          ChatModel(
            id: Get.arguments['chat_id'] ?? '',
            messages: [],
            members: [
              ContactData(
                name: Get.arguments['name'],
                id: Get.arguments['id'],
                avatar: Get.arguments['avatar'],
              ),
            ],
          ),
    );
    chatId = Get.arguments['chat_id'];
    userId = int.tryParse('${Get.arguments['id']}');
    name = Get.arguments['name'];
    avatar = Get.arguments['avatar'];
    statusText.value = socketService.socketStatus.value.text;
    chatRoomWorker = everAll([chatRoom, socketService.socketStatus], (value) {
      if (value is ChatModel) {
        if (value.id != '') {
          appServiceController.saveMessage(value);
        }
      } else if (value is SocketStatus) {
        print("status update");
        statusText.value = value.text;
      }
    });
    conectSocket();
    super.onInit();
  }

  @override
  onClose() {
    isTypingDelayed?.cancel();
    chatRoomWorker?.dispose();
    socketService.dispose();
    super.onClose();
  }

  conectSocket() async {
    socketService.initializeSocket().then((socket) {
      socket?.onConnect((data) {
        socketService.emitWithSocket("joinRoom", {"member": userId});
        intListenSocket();
      });
    });
  }

  intListenSocket() {
    socketService.listenWithSocket("joinRoom", onJoinRoom);
    socketService.listenWithSocket("newMessage", onNewMessage);
    socketService.listenWithSocket("typingStatus", onTypingStatus);
    socketService.listenWithSocket("messageStatus", onMessageStatus);

    // socketService.listenWithSocket("readMessage", onReadMessage);
    socketService.listenWithSocket("error", onError);
  }

  void onJoinRoom(data) {
    statusText.value = '';
    chatId = data["id"];
    chatRoom.update((dataRoom) {
      if (dataRoom!.id.isEmpty) {
        var room = ChatModel.fromMap({...data, 'messages': []});
        dataRoom.id = room.id;
        dataRoom.members = room.members;
        dataRoom.createdAt = room.createdAt;
        dataRoom.updatedAt = room.updatedAt;
      }
    });
    Get.log("GETLOG====> user join Room chatID:::$chatId");
    getALLMessage(chatId!);
  }

  void onNewMessage(data) {
    if ((data as List).length == 2) {
      data.last(userID);
      var message = Message.fromMap(data.first);
      if (message.senderId != userID) {
        addNewMessages(message);
      }
    }
  }

  void addNewMessages(Message message) {
    chatRoom.update((data) {
      data?.messages.insert(0, message);
    });
  }

  void updateMessage(Message message) {
    chatRoom.update((data) {
      var index = data?.messages.indexWhere((el) => el.id == message.id) ?? -1;
      if (index > -1 && data?.messages[index] != message) {
        data?.messages[index] = message;
      }
    });
  }

  void onMessageStatus(data) {
    var statusInfo = data['statusInfo'];

    var msgStatus = MessageStatus.fromMap(statusInfo?['status']);
    if (msgStatus != MessageStatus.sending && data['by'] != userID) {
      var msg = chatRoom.value.messages.firstWhereOrNull(
        (el) => el.id == statusInfo['message_id'],
      );
      if (msg != null && msg.status.index < msgStatus.index) {
        updateMessage(msg.copyWith(status: msgStatus));
      }
    }
  }

  void onTypingStatus(data) {
    if (data['userId'] != userID) {
      statusText.value = data['isTyping'] ? AppStrings.IS_TYPING : '';
    }
  }

  void onError(error) {
    tryCatch(() {
      if (error is Map && error['message'] == 'Not authenticated') {
        socketService.cleanUpSocket();
        throw UnauthorisedException.userNotLogin();
      }
      showMsg('Error Occured!!', color: Colors.red);
    });
  }

  Future<void> getALLMessage(String chatID) async {
    try {
      var response = await socketService.chatProvider.getAllMessageApiCall(
        chatID,
      );
      if (response?.isSuccess == true) {
        var listMessage = listMessageFromMap(response?.data);
        chatRoom.update((data) {
          data?.messages.assignAll(listMessage);
        });
        // messages.addAll(listMessage);

        Get.log("getAllMessageApiCall>>>>>>>$messages");
      } else {
        var message = <String>[];
        if (response?.message[0] != null) {
          message.add(response!.message[0]);
        }
        response?.showMessage(message: message);
      }
    } catch (e) {
      Get.log(e.toString(), isError: true);
    }
  }

  sendMessageToUser() async {
    if (messageInputController.text.trim() != "") {
      socketService.emitWithSocket(
        "newMessage",
        {"content": messageInputController.text, "chat_id": chatId},
        ack: (data) {
          if (data != null) {
            addNewMessages(Message.fromMap(data));
          }
        },
      );
      sendTypingStatus(false);
      messageInputController.clear();
    }
  }

  void sendTypingStatus(bool isTyping) {
    isTypingDelayed?.cancel();
    socketService.emitWithSocket("typingStatus", {
      "chat_id": chatId,
      'isTyping': isTyping,
    });

    if (isTyping) {
      isTypingDelayed = Timer(
        const Duration(seconds: 5),
        () => sendTypingStatus(false),
      );
    }
  }

  void setReadMessage(Message msg, index) {
    socketService.emitWithSocket(
      "updateMessageStatus",
      {"chat_id": msg.chatId, "message_id": msg.id, 'status': "read"},
      ack: (data) {
        if (data != null) {
          msg.status = MessageStatus.read;
          chatRoom.update((val) {
            val?.count = 0;
          });
        }
      },
    );
  }
}
