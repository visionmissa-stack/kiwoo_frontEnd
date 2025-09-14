import 'package:KIWOO/app/modules/connection/providers/connection_provider.dart';
import 'package:get/get.dart';

import '../../../core/utils/cache_manager.dart';

class ConnectionController extends GetxController {
  final provider = Get.find<ConnectionProvider>();
  @override
  void onInit() {
    CustomCacheManager.cleanCache();
    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;
}
