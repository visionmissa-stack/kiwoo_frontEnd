import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'package:kiwoo/app/core/utils/app_colors.dart';
import 'package:kiwoo/app/core/utils/font_family.dart';

import '../../../data/models/document_model.dart';

class OverlayPainter extends CustomPainter {
  bool isCropping = false;
  final bool isSquare;
  final Offset _divider;
  final String title;
  OverlayPainter.oval(this.title)
    : isSquare = false,
      _divider = const Offset(0.8, 0.6);
  OverlayPainter.square(this.title)
    : isSquare = true,
      _divider = const Offset(0.9, 0.6);

  Future<FileData?> cropImage(String filePath) async {
    final originalImage = img.decodeImage(await File(filePath).readAsBytes());
    var width = originalImage!.width * _divider.dx;
    var height = originalImage.height * _divider.dy;
    final cropRect = Rect.fromCenter(
      center: Offset(originalImage.width / 2, originalImage.height / 2),
      width: width.toDouble(),
      height: height.toDouble(),
    );
    final croppedImage = img.copyCrop(
      originalImage,
      x: cropRect.left.toInt(),
      y: cropRect.top.toInt(),
      width: cropRect.width.toInt(),
      height: cropRect.height.toInt(),
    );
    final bytes = Uint8List.fromList(img.encodePng(croppedImage));
    return FileData(
      name: 'IMG-${DateTime.now().millisecondsSinceEpoch}.png',
      hasFile: true,
      mimeType: "image/png",
      bytes: bytes,
      path: '',
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontFamily: FontPoppins.BOLD,
          color: AppColors.WHITE,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(
      maxWidth: size.width - 40, // 20 padding on each side
    );

    var rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * _divider.dx,
      height: size.height * _divider.dy,
    );
    const strokeWidth = 2.0;
    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    if (isSquare) {
      final circlePath = Path()..addRect(rect);

      final overlayPath = Path.combine(
        PathOperation.difference,
        outerPath,
        circlePath,
      );

      canvas.drawPath(overlayPath, paint);
      canvas.drawRect(rect, borderPaint);
    } else {
      final circlePath = Path()..addOval(rect);

      final overlayPath = Path.combine(
        PathOperation.difference,
        outerPath,
        circlePath,
      );

      canvas.drawPath(overlayPath, paint);
      canvas.drawOval(rect, borderPaint);
    }
    textPainter.paint(canvas, const Offset(20, 20));
  }

  @override
  bool shouldRepaint(OverlayPainter oldDelegate) {
    return oldDelegate.isSquare != isSquare || oldDelegate.title != title;
  }
}
