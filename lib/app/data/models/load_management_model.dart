import 'package:flutter/widgets.dart';

class LoanManagementModel {
  int? id;
  String? title;
  String? subTitle;
  IconData? leadingIcon;
  IconData? trailingIcon;
  bool isSelected;
  void Function()? onTap;
  LoanManagementModel(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.isSelected,
      this.onTap});
}
