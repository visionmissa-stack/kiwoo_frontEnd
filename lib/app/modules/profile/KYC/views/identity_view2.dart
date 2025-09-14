// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:camerawesome/pigeon.dart';
// import 'package:flutter/material.dart';
// import 'package:KIWOO/app/core/utils/enums.dart';

// import 'package:get/get.dart';
// import 'package:sizing/sizing_extension.dart';

// import '../../../../core/utils/app_utility.dart';
// import '../controllers/identity_controller.dart';

// class IdentityView2 extends GetView<IdentityController> {
//   const IdentityView2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       height: 1.sh,
//       child: CameraAwesomeBuilder.custom(
//         previewFit: CameraPreviewFit.fitWidth,
//         theme: AwesomeTheme(bottomActionsBackgroundColor: Colors.black54),
//         progressIndicator: loadingAnimation(),
//         saveConfig: SaveConfig.photo(),
//         onMediaCaptureEvent: (event) {
//           controller.cameraStatus.value = CameraStatus.shooting;
//           switch ((event.status, event.isPicture)) {
//             case (MediaCaptureStatus.capturing, true):
//               debugPrint('Capturing picture...');
//             case (MediaCaptureStatus.success, true):
//               event.captureRequest.when(
//                 single: (single) async {
//                   await controller.onCapturedImage(single.file?.path);
//                   controller.cameraStatus.value = CameraStatus.off;
//                   debugPrint('Picture saved: ${single.file?.path}');
//                 },
//                 multiple: (multiple) {
//                   multiple.fileBySensor.forEach((key, value) {
//                     debugPrint('multiple image taken: $key ${value?.path}');
//                   });
//                 },
//               );
//             case (MediaCaptureStatus.failure, true):
//               debugPrint('Failed to capture picture: ${event.exception}');

//             default:
//               debugPrint('Unknown event: $event');
//           }
//         },
//         builder: (state, preview) {
//           return CustomPaint(
//               child: state.when(
//             onPreparingCamera: (state) =>
//                 const Center(child: CircularProgressIndicator()),
//             onPhotoMode: (state) {
//               return AwesomeCameraLayout(
//                 state: state,
//                 topActions: Container(
//                   color: Colors.black54,
//                   child: AwesomeTopActions(
//                     // CameraState is required
//                     state: state,
//                     // Override default padding
//                     padding: EdgeInsets.zero,
//                     // Add your own children
//                     children: const [],
//                   ),
//                 ),
//                 middleContent: SizedBox.fromSize(
//                   size: preview.previewSize,
//                   child: Container(
//                     color: Colors.black54,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [],
//                     ),
//                   ),
//                 ),
//                 bottomActions: AwesomeBottomActions(
//                   // CameraState is required
//                   state: state,
//                   // You can set your own capture button
//                   captureButton: AwesomeCaptureButton(
//                     state: state,
//                   ),
//                   // Padding around the bottom actions
//                   padding: const EdgeInsets.only(
//                     bottom: 16,
//                     left: 8,
//                     right: 8,
//                   ),
//                   // Widget to the left of the captureButton
//                   left: AwesomeFlashButton(
//                     state: state,
//                   ),
//                   // Widget to the right of the captureButton
//                   right: AwesomeCameraSwitchButton(
//                     state: state,
//                     onSwitchTap: (state) {
//                       state.switchCameraSensor(
//                         aspectRatio: state.sensorConfig.aspectRatio,
//                       );
//                     },
//                   ),
//                   // Callback used by default values. Don't specify it if you override left and right widgets.
//                   onMediaTap: null,
//                 ),
//               );
//             },
//           ));
//         },
//       ),
//     );
//   }
// }
