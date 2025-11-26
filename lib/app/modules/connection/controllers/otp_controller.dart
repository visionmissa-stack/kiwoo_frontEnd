import 'dart:async';

import 'package:kiwoo/app/core/utils/actions/overlay.dart';
import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/enums.dart';
import '../../../data/models/register_model.dart';
import '../providers/connection_provider.dart';

class OTPController extends GetxController {
  OTPController({
    required this.otpContacted,
    this.type = OTPType.register,
    double? validity,
  }) : duration = Duration(
         milliseconds: ((validity ?? 1) * Duration.millisecondsPerMinute)
             .toInt(),
       ).obs;

  late final FormGroup formGroup;

  factory OTPController.forgotPassword({
    required String otpContacted,
    double? validity,
  }) {
    return OTPController(
      otpContacted: otpContacted,
      type: OTPType.forgotPassword,
      validity: validity,
    );
  }
  late final ConnectionProvider provider;
  late final RxString pin;
  late final Rx<int> secondsRemaining;
  bool get enableResend => duration.value == Duration.zero;
  Timer? timer;
  // late final StreamController<ErrorAnimationType> pinErrorController;
  final OTPType type;
  final String otpContacted;
  final Rx<Duration> duration;

  @override
  onInit() {
    formGroup = FormGroup({
      "pin": FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(4),
          Validators.maxLength(4),
        ],
      ),
    });
    provider = Get.find<ConnectionProvider>();
    // pinErrorController = StreamController<ErrorAnimationType>();

    secondsRemaining = 0.obs;
    // requestOtp();
    super.onInit();
  }

  @override
  onClose() {
    // pinErrorController.close();
    super.onClose();
  }

  Future<bool> verifyOtpApi() async {
    try {
      var response = await provider.verifyOTP(
        otpContacted,
        formGroup.control("pin").value,
        type.name,
      );
      if (response?.isSuccess == true) {
        await response!.showMessage()?.future;
        return true;
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log('$e', isError: true);
    }
    return false;
  }

  Future<void> requestOtp() async {
    try {
      var response = await provider.askForOtpApi(
        otpContacted.trim(),
        type.name,
      );
      if (response?.isSuccess == true) {
        var registerData = OTPModel.fromMap(response!.data!);
        updateDuration(registerData.otpValidity!);
        showMsg(
          registerData.message ?? "Otp sent to successfully",
          color: AppColors.SUCCESS,
        );
      } else {
        if ((response?.error ?? '').isNotEmpty) {
          updateDuration(double.parse(response!.error!));
        }
      }
    } catch (e) {
      Get.log("$e", isError: true);
      Get.back();
    }
  }

  void updateDuration(double value) {
    duration.value = Duration(
      milliseconds: (value * Duration.millisecondsPerMinute).toInt(),
    );
  }

  resendOtpApiCall() async {
    //isLoading.value = true;
    formGroup.reset();
    showOverlay(asyncFunction: requestOtp);
  }
}
