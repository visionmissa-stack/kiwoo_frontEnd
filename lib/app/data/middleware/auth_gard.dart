import 'package:flutter/widgets.dart';
import 'package:KIWOO/app/controllers/app_services_controller.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../models/storage_box_model.dart';

class AuthGard extends GetMiddleware {
  @override
  int? get priority => 0;
  AppServicesController get appService => Get.find<AppServicesController>();

  @override
  RouteSettings? redirect(String? route) {
    if (route == null) return null;
    bool isConnections = route.contains(Routes.CONNECTION);

    if (StorageBox.token.val.isNotEmpty) {
      if (isConnections) {
        return const RouteSettings(name: Routes.HOME);
      }
    } else if (!isConnections) {
      return const RouteSettings(name: Routes.CONNECTION);
    }
    return null;
  }
}
