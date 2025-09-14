import 'dart:async';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:KIWOO/app/core/utils/camera/overlay_painter.dart';
import 'package:KIWOO/app/core/utils/kiwoo_icons.dart';
import 'package:KIWOO/app/data/models/document_model.dart';

import '../../core/utils/actions/overlay.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/camera/image_preview.dart';
import '../../core/utils/enums.dart';

class CameraOverlayBinding implements Bindings {
  Future Function(FileData)? onPictureTaken;
  @override
  void dependencies() {
    Get.lazyPut<CameraOverlayController>(() => CameraOverlayController());
  }
}

class CameraOverlayController extends GetxController {
  final cameraStatus = Rx<CameraStatus>(CameraStatus.off);
  late CameraController? _camController;
  late final List<CameraDescription> cameras;
  final isCameraInitiated = RxBool(false);
  final listFile = RxList<FileData>.empty(growable: true);
  final isCropping = false.obs;
  final isCapturing = false.obs;
  RxString filePath = ''.obs;
  late ui.Image croppedImage;
  late Rx<OverlayPainter> painter;
  Future Function(FileData)? onPictureTaken;

  @override
  onInit() {
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
      var response = await Get.to<bool>(
          () => ImagePreviewWidget(bytes: picTake.bytes!),
          fullscreenDialog: true);

      if (response == true) {
        if (listFile.isEmpty) {
          painter.value = OverlayPainter.square(
              "Place your Back ID Card in the square to take a picture");
        } else if (listFile.length == 1) {
          lens = CameraLensDirection.front;
          painter.value =
              OverlayPainter.oval("Take a picture of yourself inside the hole");
        } else {
          Get.back(result: listFile);
          return;
        }
        onPictureTaken!(picTake);
        listFile.add(picTake);
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
      Get.log("$e", isError: true);
    } finally {}
    return null;
  }
}

class CameraOverlayWidget extends GetWidget<CameraOverlayController> {
  const CameraOverlayWidget({super.key, this.painter, this.onPictureTaken});
  final Widget? painter;
  final FutureOr<FileData> Function(FileData?)? onPictureTaken;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var camStatus = controller.cameraStatus.value;
      if (camStatus == CameraStatus.noCamAvailable) {
        return const Center(child: Text("No Camera Available"));
      }
      return camStatus == CameraStatus.off
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
              color: AppColors.PRIMARY,
              size: 30.ss,
            ))
          : Stack(
              alignment: Alignment.center,
              children: [
                if (camStatus == CameraStatus.initialized ||
                    camStatus == CameraStatus.shooting)
                  CameraPreview(
                    key: ValueKey(controller.painter.value.title),
                    controller._camController!,
                    child: painter,
                  ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: IconButton(
                    icon: const Icon(Kiwoo.close),
                    color: AppColors.WHITE,
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    child: FloatingActionButton(
                      onPressed: camStatus == CameraStatus.shooting
                          ? null
                          : controller.showCaptureOverlay,
                      child: const Icon(Icons.camera),
                    )),
              ],
            );
    });
  }
}
