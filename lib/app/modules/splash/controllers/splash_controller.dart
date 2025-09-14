import 'package:get/get.dart';

import '../../../controllers/app_services_controller.dart';
import '../../../controllers/firebase_services.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  onInit() {
    _onInit().then((_) => Get.offAndToNamed(Routes.HOME));
    super.onInit();
  }

  Future<void> _onInit() async {
    await Get.putAsync<FirebaseServices>(
        () async => await FirebaseServices.initFirebase());
    await Get.putAsync<AppServicesController>(
        () async => AppServicesController());
  }

  final count = 0.obs;

  void increment() => count.value++;
}
