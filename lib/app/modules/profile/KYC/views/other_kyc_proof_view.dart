import 'package:KIWOO/app/core/api_helper/urls.dart';
import 'package:KIWOO/app/core/utils/app_string.dart';
import 'package:KIWOO/app/global_widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../controllers/other_kyc_proof_controller.dart';

class OtherKycProofView extends GetView<OtherKycProofController> {
  OtherKycProofView.address({super.key})
      : _pageTitle = AppStrings.ADDRESS,
        _label = AppStrings.ADDRESS,
        _hintText = AppStrings.ENTER_ADDRESS,
        _emptyValidator = AppStrings.ADDRESS,
        _inputFormatters = null,
        _keyboardType = TextInputType.text,
        _textInputAction = TextInputAction.next,
        _url = Url.UPLOAD_ADDRESS {
    controller.kycData['value'] = {};
  }

  const OtherKycProofView.occupation({super.key})
      : _pageTitle = AppStrings.OCCUPATION_VERIFICATION,
        _label = AppStrings.OCCUPATION,
        _hintText = AppStrings.ENTER_OCCUPATION,
        _emptyValidator = AppStrings.PLS_ENTER_OCCUPATION,
        _inputFormatters = null,
        _keyboardType = TextInputType.text,
        _textInputAction = TextInputAction.done,
        _url = Url.UPLOAD_OCCUPATION;

  OtherKycProofView.income({super.key})
      : _pageTitle = AppStrings.INCOME_VERIFICATION,
        _label = AppStrings.INCOME,
        _hintText = AppStrings.ENTER_INCOME,
        _emptyValidator = AppStrings.PLS_ENTER_INCOME,
        _inputFormatters = [decimalNumberFormatter],
        _keyboardType = TextInputType.number,
        _textInputAction = TextInputAction.done,
        _url = Url.UPLOAD_INCOME;

  final String _pageTitle;
  final String _label;
  final String _hintText;
  final String _emptyValidator;
  final List<TextInputFormatter>? _inputFormatters;
  final TextInputType _keyboardType;
  final String _url;
  final TextInputAction _textInputAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidgetTitle(
          title: _pageTitle,
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
            children: [
              if (_pageTitle == AppStrings.ADDRESS) ...[
                //address
                inputWithLabel(
                  required: true,
                  label: _label,
                  hintText: _hintText,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: _textInputAction,
                  onSaved: (value) {
                    controller.kycData['value']["address"] = value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    _emptyValidator,
                  ),
                ),
                verticalSpaceMedium,
                //city
                inputWithLabel(
                  required: true,
                  label: AppStrings.CITY,
                  hintText: AppStrings.ENTER_CITY,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: _textInputAction,
                  onSaved: (value) {
                    controller.kycData['value']['city'] = value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    AppStrings.PLS_ENTER_ZIPCODE,
                  ),
                ),
                verticalSpaceMedium,
                //state
                inputWithLabel(
                  required: true,
                  label: AppStrings.STATE,
                  hintText: AppStrings.ENTER_STATE,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: _textInputAction,
                  onSaved: (value) {
                    controller.kycData['value']['state'] = value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    AppStrings.PLS_ENTER_STATE,
                  ),
                ),
                verticalSpaceMedium,
                //country
                inputWithLabel(
                  required: true,
                  label: AppStrings.COUNTRY,
                  hintText: AppStrings.ENTER_COUNTRY,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: _textInputAction,
                  onSaved: (value) {
                    controller.kycData['value']['country'] = value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    AppStrings.PLS_ENTER_COUNTRY,
                  ),
                ),
                verticalSpaceMedium,
                //zipcode
                inputWithLabel(
                  required: true,
                  label: AppStrings.ZIPCODE,
                  hintText: AppStrings.ENTER_ZIPCODE,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: TextInputAction.done,
                  onSaved: (value) {
                    controller.kycData['value']['zipcode'] = value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    AppStrings.PLS_ENTER_ZIPCODE,
                  ),
                ),
                verticalSpaceMedium,
              ] else
                inputWithLabel(
                  required: true,
                  label: _label,
                  hintText: _hintText,
                  style: TextStyle(
                    color: const Color(0xFF111A24),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.SEMIBOLD,
                  ),
                  keyboardType: _keyboardType,
                  inputFormatters: _inputFormatters,
                  textInputAction: _textInputAction,
                  onSaved: (value) {
                    controller.kycData['value'] = _label == AppStrings.INCOME
                        ? double.parse(value!)
                        : value;
                  },
                  validator: (value) => isEmptyValidator(
                    value,
                    _emptyValidator,
                  ),
                ),
              verticalSpaceMedium,
              labelWidget(
                label: "$_label Proof",
                required: true,
                style: TextStyle(
                  color: const Color(0xFF111A24),
                  fontSize: 14.fss,
                  fontFamily: FontPoppins.SEMIBOLD,
                ),
                child: FileInputFormField(
                  onSaved: (p0) => controller.kycData['proof'] = p0,
                  validator: (p0) {
                    if (p0 == null) {
                      return "Please add $_label Documents";
                    }
                    return null;
                  },
                ),
              ),
              verticalSpaceMedium,
              AppButton(
                buttonText: "Submit",
                onTap: () {
                  if (controller.formKey.currentState?.validate() == true) {
                    controller.formKey.currentState!.save();
                    showOverlay(
                        asyncFunction: () => controller.updateDocuments(
                            _label.toLowerCase(), _url));
                  }
                },
              )
            ],
          ),
        ));
  }
}
