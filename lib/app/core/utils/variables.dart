import 'package:flutter/widgets.dart';
import 'package:reactive_pinput/reactive_pinput.dart' show PinTheme;

import 'app_colors.dart' show AppColors;

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(191, 196, 200, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.PRIMARY, width: 1.5),
  borderRadius: BorderRadius.circular(15),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: AppColors.WHITE,
    border: Border.all(color: AppColors.PRIMARY),
  ),
);
