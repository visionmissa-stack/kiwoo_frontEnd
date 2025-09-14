import '../controllers/occupation_controller.dart';
import 'package:get/get.dart';

class OccupationKycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OccupationController>(() => OccupationController());
  }
}
