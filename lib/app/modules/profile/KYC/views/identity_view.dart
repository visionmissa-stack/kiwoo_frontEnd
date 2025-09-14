import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/kiwoo_icons.dart';
import '../controllers/identity_controller.dart';

class IdentityView extends GetView<IdentityController> {
  const IdentityView({super.key});

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
                    controller.cameraController!,
                    child: CustomPaint(
                      painter: controller.painter.value,
                    ),
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
