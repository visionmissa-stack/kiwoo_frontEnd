import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:KIWOO/app/core/api_helper/urls.dart';
import 'package:KIWOO/app/modules/profile/KYC/providers/kyc_provider.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_services_controller.dart';
import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/camera/image_preview.dart';
import '../../../../core/utils/camera/square_overlay.dart';
import '../../../../core/utils/enums.dart';
import '../../../../data/models/document_model.dart';

class IdentityController extends GetxController {
  final cameraStatus = Rx<CameraStatus>(CameraStatus.off);
  CameraController? get cameraController => _camController;
  late CameraController? _camController;
  late final List<CameraDescription> cameras;
  final isCameraInitiated = RxBool(false);
  final listFile = RxList<FileData>.empty(growable: true);
  IdentityType _identityType = IdentityType.front;
  final Map<IdentityType, String> _identityData = {};
  final isCropping = false.obs;
  final isCapturing = false.obs;
  RxString filePath = ''.obs;
  late ui.Image croppedImage;
  late Rx<OverlayPainter> painter;
  late final KycProvider provider;

  Future<bool> sendIdentityProofApiCall(FileData file) async {
    var response =
        await provider.sendProofApi(file: file, endPoint: Url.UPLOAD_IDENTITY);

    if (response?.isSuccess == true) {
      _identityData[_identityType] = response!.data["file_id"]['id'];
      return true;
    }
    return false;
  }

  @override
  onInit() {
    provider = Get.put(KycProvider());
    painter = OverlayPainter.square(
            "Place your Front ID Card in the square to take a picture")
        .obs;
    availableCameras().then((value) {
      cameras = value;
      if (cameras.isEmpty) {
        cameraStatus.value = CameraStatus.noCamAvailable;
        return null;
      }
      initCamera(getCameraLense(CameraLensDirection.back));
    });
    super.onInit();
  }

  getCameraLense(CameraLensDirection lenseDirection) {
    var camera = cameras
        .firstWhereOrNull((value) => value.lensDirection == lenseDirection);
    return camera ?? cameras.first;
  }

  @override
  void onClose() async {
    await _camController?.dispose();

    super.onClose();
  }

  Future<void> initCamera(CameraDescription camDescription) async {
    _camController = CameraController(
      camDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _camController?.initialize();
    // cameraStatus.value = CameraStatus.initialized;
    cameraStatus.value = CameraStatus.initialized;
    isCameraInitiated.value = true;
  }

  showCaptureOverlay() async {
    if (cameraStatus.value == CameraStatus.shooting) {
      return;
    }
    cameraStatus.value = CameraStatus.shooting;
    var picTake = await showOverlay(asyncFunction: _captureAndCropImage);
    CameraLensDirection lens = _camController!.description.lensDirection;
    if (picTake != null) {
      cameraStatus.value = CameraStatus.previewing;
      await _camController?.dispose();
      var response = await Get.to<bool>(
          () => ImagePreviewWidget(bytes: picTake.bytes!),
          fullscreenDialog: true);

      if (response == true && await sendIdentityProofApiCall(picTake)) {
        if (_identityType == IdentityType.front) {
          painter.value = OverlayPainter.square(
              "Place your Back ID Card in the square to take a picture");
          _identityType = IdentityType.back;
        } else if (_identityType == IdentityType.back) {
          lens = CameraLensDirection.front;
          painter.value =
              OverlayPainter.oval("Take a picture of yourself inside the hole");
          _identityType = IdentityType.face;
        } else {
          await showOverlay(asyncFunction: updateDocuments);
        }
      }
    }
    cameraStatus.value = CameraStatus.off;
    initCamera(getCameraLense(lens));
  }

  Future<FileData?> _captureAndCropImage() async {
    try {
      isCapturing.value = true;
      await _camController?.pausePreview();
      XFile file = await _camController!.takePicture();

      filePath.value = file.path;
      // isCameraInitiated.value = false;

      FileData? croppedImg = await painter.value.cropImage(file.path);
      return croppedImg;
    } catch (e) {
      Get.log("error $e", isError: true);
    } finally {}
    return null;
  }

  Future<void> updateDocuments() async {
    var docId = _identityData;
    var response = await provider.updateUserDocsApi(docId: {
      'id_doc': docId.map(
        (key, value) => MapEntry(key.name, value),
      )
    });
    if (response?.isSuccess == true) {
      await Get.find<AppServicesController>().getUserDetails();
      response?.showMessage();
    }
    Get.back(closeOverlays: true);
  }
}
