import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kiwoo/app/data/models/notifications/notification_model.dart';

import '../core/utils/enums.dart';
import '../core/utils/storage_pro.dart';
import '../data/models/chat_model.dart';
import '../data/models/contact_list_model.dart';
import '../data/models/message_model.dart' as msg_model;
import '../modules/chat/bindings/chat_screen_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/loans/loanRequestSent/bindings/loan_request_sent_binding.dart';
import '../modules/loans/loanRequestSent/views/loan_request_offers_view.dart';
import '../modules/loans/loanRequestSent/views/loan_request_sent_details_view.dart';
import '../routes/app_pages.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // FirebaseServices.addNotification(message);
}

class FirebaseServices extends GetxService with WidgetsBindingObserver {
  // static final _firebaseNotification = FirebaseMessaging.instance;
  // static final _notification = FlutterLocalNotificationsPlugin();

  String? token;
  FirebaseServices._onInit({this.token});
  late RxList<NotificationModel> notifications;

  @override
  onInit() {
    notifications = RxList<NotificationModel>.empty(growable: true);
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseNotificationsHandler.flutterLocalNotificationsPlugin
            ?.getActiveNotifications();
        break;
      default:
        break;
    }
  }

  void addnotificationStorageListener() {
    listenAllObjects<NotificationModel>(
      onData: (data) {
        notifications.assignAll([...data.reversed]);
      },
    );
  }

  void onMessage(RemoteMessage message, [bool taped = false]) {
    addNotification(message, taped);
  }

  static Future<FirebaseServices> initFirebase() async {
    return FirebaseServices._onInit(token: '');
  }

  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
    await FirebaseMessaging.instance.getToken();

    // await FirebaseServices
    //   ..reInitializeLocalNotifications();
  }

  void addNotification(RemoteMessage notification, bool taped) {
    var type = NotificationType.fromMap(notification.data['type']);
    var data = notification.data;
    switch (type) {
      case NotificationType.chat:
        var previousChat = getObjectById<ChatModel>(data['chat_id']);
        var msg = msg_model.Message.fromJson(data['message']);
        if (previousChat != null) {
          previousChat.messages.insert(0, msg);
          previousChat.count++;
        } else {
          previousChat = ChatModel.fromMap({
            'id': data['chat_id'],
            'members': [
              {"member": ContactData.fromJson(data['member']).toMap()},
            ],
            'messages': [msg.toMap()],
            'created_at': data['create_at'],
            'updated_at': data['create_at'],
            '_count': {"messages": 1},
          });
        }
        saveObject<ChatModel>(previousChat);
        if (taped) {
          goToPage(notification);
        }
        break;
      default:
        saveObject<NotificationModel>(
          NotificationModel.fromRemoteMessage(notification),
        );
        break;
    }
  }

  void goToPage(RemoteMessage notification) {
    final type = NotificationType.fromMap(notification.data['type']);
    print("the type is here $type");
    final data = notification.data;
    switch (type) {
      case NotificationType.chat:
        Get.to(
          () => const ChatView(),
          binding: ChatScreenBinding(),
          arguments: {
            "chat_id": data['chat_id'],
            "id": data['sender_id'],
            ...jsonDecode(data['member']),
          },
          routeName: "chatScreen",
        );
        // if (Get.currentRoute == Routes.HOME) {
        //   Get.find<HomeController>().selectedIndex.value = 3;
        // } else {
        //   Get.offAllNamed(Routes.HOME, arguments: {'selectedIndex': 3});
        // }
        break;
      case NotificationType.newLoanOffer:
        Get.to(
          () => LoanRequestOffersView(int.parse(data['loan_id'])),
          binding: LoanRequestSentBinding(),
          routeName: "loan_offers",
        );

      case NotificationType.loanRequest:
      case NotificationType.loanOfferAccepted:
      case NotificationType.loanOfferRejected:
        Get.toNamed(Routes.LOAN_REQUEST_RECEIVED, arguments: data);
        break;
      case NotificationType.loanAcceted:
        if (data['loan_id'] == null) return;
        Get.to(
          () => const LoanRequestSentDetailsView(),
          binding: LoanRequestSentBinding(),
          arguments: data,
          routeName: "loan_accepted",
        );

      case NotificationType.cashin:
      // TODO: Handle this case.
      case NotificationType.unKnow:
      // TODO: Handle this case.
      case NotificationType.cashout:
      // TODO: Handle this case.
    }
  }
}
