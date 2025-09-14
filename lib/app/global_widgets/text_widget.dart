import 'package:flutter/widgets.dart';
import 'package:KIWOO/app/core/utils/font_family.dart';
import 'package:sizing/sizing_extension.dart';

Text notYetImplementedWidget(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30.fs,
      fontFamily: FontPoppins.SEMIBOLD,
    ),
  );
}
