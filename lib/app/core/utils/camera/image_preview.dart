import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kiwoo/app/core/utils/app_colors.dart';
import 'package:kiwoo/app/core/utils/app_utility.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

class ImagePreviewWidget extends GetView {
  const ImagePreviewWidget({super.key, required this.bytes});
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.memory(bytes),
        Positioned(
          bottom: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.back(result: true);
                },
                icon: const Icon(Kiwoo.check),
                iconSize: 40.ss,
                color: AppColors.PRIMARY2,
              ),
              horizontalSpaceRegular,
              IconButton(
                iconSize: 40.ss,
                onPressed: () {
                  Get.back(result: false);
                },
                icon: const Icon(Kiwoo.close, color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
