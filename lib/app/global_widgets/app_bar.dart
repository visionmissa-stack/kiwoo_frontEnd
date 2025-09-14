import 'package:KIWOO/app/global_widgets/notification_icon_count.dart';
import 'package:KIWOO/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:KIWOO/app/controllers/app_services_controller.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import '../core/utils/cache_manager.dart';
import '../core/utils/font_family.dart';
import '../core/utils/kiwoo_icons.dart';
import 'avatar_network_image.dart';
import 'box_decoration.dart';

class AppBarWidget extends GetWidget<AppServicesController>
    implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 2, 15),
        child: Row(
          children: [
            Obx(
              () {
                var avatar = controller.userDetails.value?.avatar;
                // avatar = "18tCBcK1_BjZpu_vXdhoRJXzr3KwNvy_C";
                return Container(
                  height: 55.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: avatarImage(
                    avatar,
                    cacheManager: CustomCacheManager.profilCacheManager,
                    placeHolder: const Center(
                      child: Icon(
                        Kiwoo.person,
                        size: 40,
                        color: Colors.green,
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
                );
              },
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270.s,
                  child: Text(
                    "Welcome",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.fss,
                      color: FontColors.WHITE,
                      fontFamily: FontPoppins.LIGHT,
                    ),
                  ),
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: 270.s,
                  child: Obx(() {
                    var userDetails = controller.userDetails.value;

                    return Text(
                      "${userDetails?.name!}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 17.fss,
                        color: FontColors.WHITE,
                        fontFamily: FontPoppins.MEDIUM,
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
            child: Obx(() {
              var newNotifCount = controller.notifications
                  .fold(0, (value, element) => value + (!element.read ? 1 : 0));
              return NotificationIconCount(
                icon: Icon(Kiwoo.bell, size: 30.ss, color: Colors.white),
                count: newNotifCount,
              );
            }),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.square(90.ss);
}

class AppBarWidgetTitle extends GetWidget<AppServicesController>
    implements PreferredSizeWidget {
  const AppBarWidgetTitle({
    super.key,
    required this.title,
    this.actions,
    this.height,
    this.predicate,
    this.homeIfCantPop = false,
  });
  final String title;
  final List<Widget>? actions;
  final double? height;
  final bool Function(Route<dynamic>)? predicate;
  final bool homeIfCantPop;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      titleSpacing: 0,
      leading: Navigator.canPop(context) || homeIfCantPop
          ? IconButton(
              icon: const Icon(Kiwoo.arrow_left),
              onPressed: () {
                if (!Navigator.canPop(context) && homeIfCantPop) {
                  Get.offAndToNamed(Routes.HOME);
                  return;
                } else {
                  if (predicate != null) {
                    print("the roote bck");
                    Get.until(predicate!);
                  } else {
                    Get.back();
                  }
                }
              },
            )
          : null,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.LBL_TITLE_NAV,
          fontSize: 20,
          fontFamily: FontPoppins.SEMIBOLD,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.square(height ?? 90.ss);
}
