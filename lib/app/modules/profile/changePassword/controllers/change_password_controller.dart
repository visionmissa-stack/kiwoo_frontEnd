import 'package:kiwoo/app/controllers/def_controller.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../controllers/app_services_controller.dart';
import '../../../../data/models/user_profil_update.dart';

class ChangePasswordController extends GetxController with DefController {
  late final FormGroup formGroup;

  @override
  onInit() {
    formGroup = FormGroup(
      {
        "oldPassword": FormControl<String>(validators: [Validators.required]),
        "newPassword": FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(8),
            Validators.pattern(
              r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$!%*?&])[A-Za-z\d@#$!%*?&]{8,}$)',
            ),
          ],
        ),
        "confirmNewPassword": FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [Validators.mustMatch('newPassword', 'confirmNewPassword')],
    );
    super.onInit();
  }

  Future<void> changePassword() async {
    var response = await Get.find<AppServicesController>().provider
        .updateUserProfile(
          profil: UserProfilUpdate(
            oldPassword: formGroup.control('oldPassword').value,
            password: formGroup.control('newPassword').value,
            name: userDetails.value?.name,
            phone: userDetails.value?.phone,
          ),
        );
    if (response?.isSuccess == true) {
      await Get.find<AppServicesController>().getUserDetails();
      Get.back(closeOverlays: true);
      response!.showMessage();
    }
  }
}
