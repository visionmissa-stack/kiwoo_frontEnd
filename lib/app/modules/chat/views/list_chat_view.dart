import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:kiwoo/app/core/utils/font_family.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/core/utils/image_name.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';
import 'package:kiwoo/app/modules/chat/bindings/chat_screen_binding.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../global_widgets/avatar_network_image.dart';
import '../../../global_widgets/input_field.dart';
import '../controllers/chat_controller.dart';
import 'chat_view.dart';

class ListChatView extends GetView<ChatController> {
  const ListChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: const AppBarWidgetTitle(title: AppStrings.GENERAL_CHAT),
      body: RefreshIndicator(
        onRefresh: controller.getChatList,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              searchTFF(),
              Expanded(child: chatListWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTFF() {
    return Card(
      color: AppColors.WHITE,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SearchCustomInputFormField(
        hintText: AppStrings.SEARCH,
        keyboardType: TextInputType.streetAddress,
        textInputAction: TextInputAction.search,
        onChanged: controller.search,
      ),
    );
  }

  Widget chatListWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Obx(() {
        var chatList = controller.filteredChatList.isEmpty
            ? controller.chatList
            : controller.filteredChatList;
        return ListView.builder(
          itemCount: chatList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var data = chatList[index];
            return Card(
              child: ListTile(
                onTap: () async {
                  await Get.to(
                    () => const ChatView(),
                    binding: ChatScreenBinding(),
                    arguments: {
                      "chat_id": data.id,
                      ...data.members.first.toMap(),
                    },
                    routeName: "chatScreen",
                  );
                },
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                    child: avatarImage(
                      data.members.firstOrNull?.avatar,
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
                title: Text(
                  data.members.first.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.fss,
                    color: const Color(0xFF1A1A1A),
                    fontFamily: FontPoppins.MEDIUM,
                  ),
                ),
                subtitle: Text(
                  data.messages.isEmpty
                      ? ''
                      : data.messages[0].content.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.fss,
                    color: const Color(0xFF7A7A7A),
                    fontFamily: FontPoppins.REGULAR,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    verticalSpaceTiny,
                    Text(
                      (data.messages.firstOrNull?.createdAt ?? data.updatedAt!)
                          .since(),
                      style: TextStyle(
                        fontSize: 13.fss,
                        color: const Color(0xFF7A7A7A),
                        fontFamily: FontPoppins.REGULAR,
                      ),
                    ),
                    if (data.count != 0)
                      Padding(
                        padding: EdgeInsets.only(top: 5.ss),
                        child: Container(
                          height: 16.ss,
                          width: 16.ss,
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              data.count.toString(),
                              style: TextStyle(
                                fontSize: 11.fss,
                                color: AppColors.WHITE,
                                fontFamily: FontPoppins.REGULAR,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      }),
    );
  }
}
