import 'package:KIWOO/app/core/utils/app_string.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';
import 'package:KIWOO/app/core/utils/text_teme_helper.dart';
import 'package:KIWOO/app/global_widgets/app_bar.dart';
import 'package:KIWOO/app/global_widgets/avatar_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: AppStrings.NOTIFICATION,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Obx(() {
        var notifications = controller.notificationList;
        return ListView.separated(
            padding: const EdgeInsets.only(top: 2),
            itemBuilder: (context, index) {
              var item = notifications[index];
              return Container(
                color: !item.read ? AppColors.PRIMARY3 : null,
                child: ListTile(
                  dense: true,
                  leading: ClipRRect(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: avatarImageExternal(
                        item.icon,
                        placeHolder: CircleAvatar(
                          backgroundColor: AppColors.PRIMARY2,
                          child: const Icon(
                            Kiwoo.person,
                            size: 40,
                            color: Colors.white,
                          ),
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
                    item.getTitle(),
                    style: TextThemeHelper.titleLR,
                  ),
                  subtitle: Text(item.getBody()),
                  titleTextStyle: TextThemeHelper.titleLR,
                  subtitleTextStyle: TextThemeHelper.subTitleGreyLR,
                  onTap: () {
                    controller.callaction(index);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1.5,
                thickness: 1.5,
                color: AppColors.PRIMARY,
              );
            },
            itemCount: notifications.length);
      }),
    );
  }
}
