import 'dart:io';

import 'package:KIWOO/app/controllers/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:sizing/sizing.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';

import 'package:KIWOO/app/controllers/app_services_controller.dart';

import 'app/core/utils/app_theme.dart';
import 'app/core/utils/image_name.dart';
import 'app/data/models/storage_box_model.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'generated/locales.g.dart';
import 'main.reflectable.dart';

void main() async {
  await _onInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(ImgName.PLASH_ICON), context);

    return FirebaseNotificationsHandler(
      messageModifier: (p0) {
        if (p0.data['type'] != 'chat') {
          return RemoteMessage(
            category: p0.category,
            senderId: p0.senderId,
            collapseKey: p0.collapseKey,
            contentAvailable: p0.contentAvailable,
            data: p0.data,
            from: p0.from,
            messageId: p0.messageId,
            messageType: p0.messageType,
            mutableContent: p0.mutableContent,
            notification: RemoteNotification.fromMap({
              ...p0.notification?.toMap() ?? {},
              'title': p0.notification?.titleLocKey?.tr,
              'body': p0.notification?.bodyLocKey
                  ?.trArgs(p0.notification?.bodyLocArgs ?? [])
            }),
            sentTime: p0.sentTime,
            threadId: p0.threadId,
            ttl: p0.ttl,
          );
        }
        return p0;
      },
      onFcmTokenInitialize: (token) {
        Get.find<FirebaseServices>().token = token;
        StorageBox.fmcToken.val = token ?? '';
      },
      onFcmTokenUpdate: (token) {
        StorageBox.fmcToken.val = token;
      },
      onTap: (notif) {
        print("on notif takk ");
        switch (notif.appState) {
          case AppState.terminated:
          case AppState.background:
            Get.find<FirebaseServices>().onMessage(notif.firebaseMessage);
            continue openNotif;
          openNotif:
          case AppState.open:
            print("notif is opend");
            Get.find<FirebaseServices>().goToPage(notif.firebaseMessage);
            break;
        }
      },
      onOpenNotificationArrive: (notif) {
        Get.find<FirebaseServices>().onMessage(notif.firebaseMessage);
      },
      child: SizingBuilder(
        baseSize: const Size(430, 932),
        builder: () => GetMaterialApp(
          title: 'Kiwoo Wallet',
          theme: theme,
          debugShowCheckedModeBanner: false,
          // locale: const Locale('en'),
          locale: const Locale('ht_HT'),
          supportedLocales: const <Locale>[Locale('ht_HT')],
          // defaultTransition: Transition.fade,
          translationsKeys: AppTranslation.translations,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,

          useInheritedMediaQuery: true,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // initialBinding: InitBinding(),
        ),
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AppServicesController());

    // Get.lazyPut<DefaultProvider>(
    //   () => DefaultProvider(),
    // );
  }
}

Future<void> _onInit() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  // Initialize GetStoragePro (call this before using any GetStoragePro functionality)
  await GetStoragePro.init();
  await GetStorage.init("appKeys");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
