import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/core/utils/image_name.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/modules/chat/controllers/chat_screen_controller.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/device_manager/screen_constants.dart';
import '../../../global_widgets/avatar_network_image.dart';

class ChatView extends GetView<ChatScreenController> {
  const ChatView({super.key});
  const ChatView.newChat({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic data) async {
        controller.sendTypingStatus(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [AppColors.APPBAR_PRIMARY1, AppColors.APPBAR_PRIMARY2],
                stops: const [0, 1],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              centerTitle: true,
              title: Row(
                children: [
                  SizedBox.square(
                    dimension: 48.s,
                    child: ClipOval(
                      child: avatarImage(
                        controller.avatar,
                        placeHolder: Center(
                          child: Image.asset(ImgName.ELLIPSE_1),
                        ),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.ss),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.name}'.capitalize!,
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.LBL_TITLE_NAV,
                            fontSize: 20,
                            fontFamily: FontPoppins.SEMIBOLD,
                          ),
                        ),
                        Visibility(
                          visible: controller.statusText.isNotEmpty,
                          child: Text(
                            controller.statusText.value,
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                              fontFamily: FontPoppins.MEDIUM,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              actions: <Widget>[
                Icon(Icons.more_vert_outlined, color: AppColors.WHITE),
                SizedBox(width: 20.ss),
              ],
              //    elevation: 1.0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(Kiwoo.arrow_left, size: 15.ss),
                  onPressed: () {
                    Get.back(result: "send");
                    //controller.isTyping(chat.id!, false);
                  },
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Platform.isIOS ? 20.ss : 15.ss,
            vertical: Platform.isIOS ? 20.ss : 10.ss,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: ((newtext) {
                    controller.sendTypingStatus(true);
                  }),
                  controller: controller.messageInputController,
                  onEditingComplete: controller.sendMessageToUser,
                  // textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: const Color(0xFF6D6D6D),
                      fontSize: 14.fss,
                    ),
                    hintText: "Add a message",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.ss),
              GestureDetector(
                onTap: controller.sendMessageToUser,
                child: Container(
                  height: 40.ss,
                  width: 40.ss,
                  decoration: const BoxDecoration(
                    color: Color(0xFF38901F),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Kiwoo.send, size: 15.ss)),
                ),
              ),
            ],
          ),
        ),
        body:
            // isCallingApi == true && isLoadMore == false ?
            // Center(child: loadingAnimation()) :
            Obx(() {
              var messages = controller.chatRoom.value.messages;
              return ListView.builder(
                // shrinkWrap: true,
                controller: controller.scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  // if (index < messages!.length-1) {
                  var message = messages[index];
                  bool isSender = message.senderId == controller.userID;
                  if (!isSender && message.status != MessageStatus.read) {
                    controller.setReadMessage(message, index);
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.ss,
                      vertical: 12.ss,
                    ),
                    margin: EdgeInsets.only(
                      bottom: index == 0 ? (Platform.isIOS ? 50 : 65) : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: screenWidth - 60.ss,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.ss,
                            horizontal: 20.ss,
                          ),
                          decoration: BoxDecoration(
                            color: !isSender
                                ? const Color(0xFFEEEEEE)
                                : const Color(0xFFE8FFE2),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: index % 2 == 0
                                  ? const Radius.circular(10)
                                  : const Radius.circular(0),
                              bottomRight: index % 2 == 0
                                  ? const Radius.circular(0)
                                  : const Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            message.content.toString(),
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              color: const Color(0xFF3A3A3A),
                              fontSize: 14.fss,
                              fontFamily: FontPoppins.REGULAR,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.ss),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.ss, right: 5.ss),
                              child: Text(
                                message.createdAt!.since(),
                                style: TextStyle(
                                  fontSize: 12.fss,
                                  color: const Color(0xFF7A7A7A),
                                  fontFamily: FontPoppins.REGULAR,
                                ),
                              ),
                            ),
                            if (isSender) iconByStatus(message.status),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  Widget iconByStatus(MessageStatus? status) {
    late IconData icon;
    var color = AppColors.BLACK;
    switch (status) {
      case MessageStatus.sent:
        icon = Kiwoo.check;
        break;
      case MessageStatus.read:
        color = AppColors.PRIMARY;
        continue received;
      received:
      case MessageStatus.received:
        icon = Kiwoo.double_check;
        break;
      default:
        icon = Kiwoo.clock;
        break;
    }
    return Icon(icon, color: color, size: 15);
  }
}
