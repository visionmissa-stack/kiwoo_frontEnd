import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/text_style.dart';

Widget columnItems({List<Widget> children = const []}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: .03.sw, vertical: 15),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15 / 2,
      children: children,
    ),
  );
}

Widget rowItem({
  required String title,
  required String value,
  TextStyle? valueStyle,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, textAlign: TextAlign.start, style: titleDetailStyle),
      Text(value, style: valueStyle ?? titleDetailStyle),
    ],
  );
}
