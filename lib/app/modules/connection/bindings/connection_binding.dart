import 'package:kiwoo/app/modules/connection/providers/connection_provider.dart';
import 'package:get/get.dart';

import '../controllers/connection_controller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionProvider>(() => ConnectionProvider());
    Get.lazyPut<ConnectionController>(() => ConnectionController());
  }
}
