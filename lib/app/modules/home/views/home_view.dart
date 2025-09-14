import 'package:KIWOO/app/global_widgets/notification_icon_count.dart';
import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/font_family.dart';
import '../../loans/market/views/market_view.dart';
import '../../profile/views/profil_view.dart';
import '../controllers/home_controller.dart';
import '../../chat/views/list_chat_view.dart';
import 'home_widget_view.dart';
import '../../loans/views/loans_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  List<Widget> get screenList => const <Widget>[
        HomeWidgetView(),
        MarketView(),
        LoansView(),
        ListChatView(),
        ProfilView()
      ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.WHITE,
            primaryColor: AppColors.PRIMARY2,
            scaffoldBackgroundColor: Colors.red,
            unselectedWidgetColor: Colors.red,
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            height: 70,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: BottomNavigationBar(
                backgroundColor: AppColors.WHITE,
                elevation: 5,
                type: BottomNavigationBarType.fixed,
                iconSize: 26.ss,
                selectedLabelStyle: TextStyle(
                  fontFamily: FontPoppins.REGULAR,
                  fontSize: 12.fss,
                  color: const Color.fromARGB(255, 26, 26, 26),
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: FontPoppins.REGULAR,
                  fontSize: 12.fss,
                  color: const Color.fromARGB(255, 151, 151, 151),
                  fontWeight: FontWeight.w400,
                ),
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Kiwoo.home,
                    ),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Kiwoo.loan_market,
                    ),
                    label: 'Loan Market',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Kiwoo.loans_bag,
                    ),
                    label: 'Loans',
                  ),
                  BottomNavigationBarItem(
                    icon: Obx(() {
                      var count = controller
                          .appServiceController.totalUnReadMessage.value;
                      return NotificationIconCount(
                        icon: const Icon(
                          Kiwoo.chat,
                        ),
                        count: count,
                      );
                    }),
                    label: 'Chat',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Kiwoo.person,
                    ),
                    label: 'Profile',
                  ),
                ],
                unselectedItemColor: const Color.fromARGB(255, 151, 151, 151),
                selectedItemColor: Colors.black,
                selectedIconTheme: IconThemeData(color: AppColors.PRIMARY2),
                showUnselectedLabels: true,
                currentIndex: controller.selectedIndex.value,
                onTap: controller.selectedIndex.call,
              ),
            ),
          ),
        ),
        body: screenList[controller.selectedIndex.value],
      );
    });
  }
}
