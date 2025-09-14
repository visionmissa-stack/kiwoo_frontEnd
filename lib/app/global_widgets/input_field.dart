// ignore_for_file: must_be_immutable

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_string.dart';
import '../core/utils/app_utility.dart';
import '../core/utils/device_manager/screen_constants.dart';
import '../core/utils/kiwoo_icons.dart';
import '../core/utils/pick_files.dart/pick_image.dart';
import '../core/utils/text_teme_helper.dart';
import '../data/models/document_model.dart';
import 'modal/bottom_sheet.dart';

class CustomInputFormField extends StatelessWidget {
  double? height;
  double? width;
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? counter;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool isDense;
  final bool isCollapsed;
  final TextInputAction textInputAction;
  final void Function()? suffixIconTapped;
  final void Function(String value)? onChanged;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  final void Function()? onTap;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextInputType keyboardType;
  final circularBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final TextStyle? hintStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  void Function(String)? onFieldSubmitted;
  int? errorMaxLines;
  BoxConstraints? suffixIconConstraints;

  CustomInputFormField({
    super.key,
    this.height,
    this.width,
    this.controller,
    this.hintText = '',
    this.label = '',
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.counter,
    this.counterText,
    this.suffixIconTapped,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.isDense = false,
    this.isCollapsed = false,
    this.textInputAction = TextInputAction.done,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.onTap,
    this.inputFormatters,
    this.style,
    this.contentPadding,
    this.initialValue,
    this.hintStyle,
    this.floatingLabelBehavior,
    this.errorMaxLines,
    this.suffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    print("the data is s initial $initialValue");
    return TextFormField(
        cursorColor: AppColors.PRIMARY1,
        controller: controller,
        initialValue: initialValue,
        style: style ?? TextThemeHelper.textFormField,
        obscureText: obscureText,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        maxLines: maxLines > minLines ? maxLines : minLines,
        minLines: minLines,
        maxLength: maxLength,
        onTapOutside: (event) {
          hideKeyboard();
        },
        keyboardType: keyboardType,
        readOnly: readOnly,
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          errorMaxLines: errorMaxLines,
          counter: counter,
          counterText: counterText,
          errorText: errorText,
          hintText: hintText,
          labelText: label,
          isDense: isDense,
          contentPadding:
              contentPadding ?? EdgeInsets.all(ScreenConstant.sizeMedium),
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.always,
          hintStyle: hintStyle ?? TextThemeHelper.textFormFieldHintStyle,
          isCollapsed: isCollapsed,
          labelStyle: TextThemeHelper.lableTextFormField,
          filled: true,
          fillColor: fillColor ?? const Color.fromARGB(255, 243, 243, 243),
          prefixIcon: prefixIcon,
          suffixIconConstraints: suffixIconConstraints,
          suffixIcon: suffixIcon,
          border: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.TEXT_FORM_FIELD),
          ),
          errorBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.PRIMARY1),
          ),
          enabledBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.TEXT_FORM_FIELD),
          ),
        ));
  }
}

class CustomInputFormField2 extends StatelessWidget {
  double? height;
  double? width;
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? counter;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool isDense;
  final bool isCollapsed;
  final TextInputAction textInputAction;
  final void Function()? suffixIconTapped;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String?)? onSaved;
  final circularBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? hintStyle;
  final String? initialValue;

  CustomInputFormField2({
    super.key,
    this.height,
    this.style,
    this.contentPadding,
    this.width,
    this.controller,
    this.hintText = '',
    this.label = '',
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.counter,
    this.counterText,
    this.suffixIconTapped,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.isDense = false,
    this.isCollapsed = false,
    this.textInputAction = TextInputAction.done,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.autovalidateMode,
    this.floatingLabelBehavior,
    this.hintStyle,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        cursorColor: AppColors.PRIMARY1,
        controller: controller,
        style: style ?? TextThemeHelper.textFormField,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
        autovalidateMode: autovalidateMode,
        maxLines: maxLines > minLines ? maxLines : minLines,
        minLines: minLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        readOnly: readOnly,
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          counter: counter,
          counterText: counterText,
          errorText: errorText,
          hintText: hintText,
          labelText: label,
          isDense: isDense,
          contentPadding:
              contentPadding ?? EdgeInsets.all(ScreenConstant.sizeMedium),
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.never,
          hintStyle: hintStyle ?? TextThemeHelper.textFormFieldHintStyle,
          alignLabelWithHint: false,
          isCollapsed: isCollapsed,
          labelStyle: TextThemeHelper.lableTextFormField,
          filled: true,
          fillColor: fillColor ?? const Color.fromARGB(255, 243, 243, 243),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? suffixIconTapped != null
                  ? GestureDetector(
                      onTap: suffixIconTapped,
                      child: suffixIcon,
                    )
                  : suffixIcon
              : null,
          border: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.TEXT_FORM_FIELD),
          ),
          errorBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.PRIMARY1),
          ),
          enabledBorder: circularBorder.copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.TEXT_FORM_FIELD),
          ),
        ));
  }
}

class SearchCustomInputFormField extends StatelessWidget {
  double? height;
  double? width;
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final String? errorText;
  final Widget? prefixIcon;

  final Widget? counter;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool isDense;
  final bool isCollapsed;
  final TextInputAction textInputAction;
  final void Function()? suffixIconTapped;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextInputType keyboardType;
  final circularBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;

  SearchCustomInputFormField(
      {super.key,
      this.height,
      this.width,
      this.controller,
      this.hintText = '',
      this.label = '',
      this.errorText,
      this.prefixIcon,
      this.counter,
      this.counterText,
      this.suffixIconTapped,
      this.obscureText = false,
      this.readOnly = false,
      this.enabled = true,
      this.isDense = false,
      this.isCollapsed = false,
      this.textInputAction = TextInputAction.done,
      this.minLines = 1,
      this.maxLines = 1,
      this.maxLength,
      this.fillColor,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.onTap,
      this.inputFormatters,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.ss,
      width: width ?? 335.ss,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColor ?? Colors.white)),
      child: TextFormField(
          cursorColor: AppColors.PRIMARY1,
          controller: controller,
          style: TextThemeHelper.textFormField,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onTap,
          onTap: null,
          cursorHeight: 23.ss,
          maxLines: maxLines > minLines ? maxLines : minLines,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          readOnly: readOnly,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            counter: counter,
            counterText: counterText,
            errorText: errorText,
            hintText: hintText,
            labelText: label,
            isDense: isDense,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextThemeHelper.textFormFieldHintStyle,
            isCollapsed: isCollapsed,
            labelStyle: TextThemeHelper.lableTextFormField,
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 15),
            filled: false,
            fillColor: fillColor ?? const Color.fromARGB(255, 243, 243, 243),
            prefixIcon: prefixIcon,
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 18),
              child: GestureDetector(
                onTap: suffixIconTapped,
                child: const Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ),
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          )),
    );
  }
}

class SearchCustomInputField extends StatelessWidget {
  double? height;
  double? width;
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final String? errorText;
  final Widget? prefixIcon;

  final Widget? counter;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool isDense;
  final bool isCollapsed;
  final TextInputAction textInputAction;
  final void Function()? suffixIconTapped;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  void Function(String)? onSubmitted;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextInputType keyboardType;
  final circularBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  List<TextInputFormatter>? inputFormatters;

  SearchCustomInputField({
    super.key,
    this.height,
    this.width,
    this.controller,
    this.hintText = '',
    this.label = '',
    this.errorText,
    this.prefixIcon,
    this.counter,
    this.counterText,
    this.suffixIconTapped,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.isDense = false,
    this.isCollapsed = false,
    this.textInputAction = TextInputAction.search,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.ss,
      width: width ?? 335.ss,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(25)),
      child: TextField(
          cursorColor: AppColors.PRIMARY1,
          controller: controller,
          style: TextThemeHelper.textFormField,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onTap,
          onSubmitted: onSubmitted,
          onTap: null,
          cursorHeight: 23.ss,
          maxLines: maxLines > minLines ? maxLines : minLines,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          readOnly: readOnly,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            counter: counter,
            counterText: counterText,
            errorText: errorText,
            hintText: hintText,
            labelText: label,
            isDense: isDense,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextThemeHelper.textFormFieldHintStyle,
            isCollapsed: isCollapsed,
            labelStyle: TextThemeHelper.lableTextFormField,
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 5, 15),
            filled: false,
            fillColor: fillColor ?? const Color.fromARGB(255, 243, 243, 243),
            prefixIcon: prefixIcon,
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 18),
              child: GestureDetector(
                onTap: suffixIconTapped,
                child: const Icon(
                  Icons.search,
                  size: 1.4,
                ),
              ),
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          )),
    );
  }
}

Widget labelWidget({
  bool required = false,
  required String label,
  required Widget child,
  TextStyle? style,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          if (required)
            Text(
              AppStrings.STAR_SIGN,
              style: TextThemeHelper.textFieldStar,
            ),
          Text(
            label,
            style: style ?? TextThemeHelper.textFieldTitle,
          ),
        ],
      ),
      verticalSpaceSmall,
      child
    ],
  );
}

Widget inputWithLabel(
    {bool required = false,
    required String label,
    String hintText = '',
    TextStyle? hintStyle,
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    TextInputAction textInputAction = TextInputAction.done,
    TextStyle? style,
    EdgeInsets? contentPadding,
    FloatingLabelBehavior? floatingLabelBehavior,
    bool enabled = true,
    String? initialValue,
    Widget? sufixIcon,
    int maxLines = 1,
    int minLines = 1,
    bool? obscureText,
    bool initValueWithController = false,
    void Function(String)? onFieldSubmitted,
    TextEditingController? controller,
    BoxConstraints? suffixIconConstraints}) {
  if (initValueWithController) {
    controller = TextEditingController(text: initialValue);
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          if (required)
            Text(
              AppStrings.STAR_SIGN,
              style: TextThemeHelper.textFieldStar,
            ),
          Text(
            label,
            style: style ?? TextThemeHelper.textFieldTitle,
          ),
        ],
      ),
      verticalSpaceSmall,
      CustomInputFormField(
        initialValue: controller == null ? initialValue : null,
        hintText: hintText,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        contentPadding: contentPadding,
        hintStyle: hintStyle,
        enabled: enabled,
        suffixIcon: sufixIcon,
        suffixIconConstraints: suffixIconConstraints,
        obscureText: obscureText ?? false,
        errorMaxLines: 2,
      ),
    ],
  );
}

Widget inputWithLabelForm<T>({
  bool required = false,
  required String label,
  void Function(T?)? onSaved,
  String? Function(T?)? validator,
  required Widget Function(FormFieldState<T>) child,
  T? initialValue,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          if (required)
            Text(
              AppStrings.STAR_SIGN,
              style: TextThemeHelper.textFieldStar,
            ),
          Text(
            label,
            style: TextThemeHelper.textFieldTitle,
          ),
        ],
      ),
      verticalSpaceSmall,
      FormField<T>(
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
        builder: (state) {
          return child(state);
        },
      ),
    ],
  );
}

class FileInputFormField extends StatelessWidget {
  void Function(FileData?)? onSaved;
  String? forceErrorText;
  String? Function(FileData?)? validator;
  FileData? initialValue;
  bool enabled = true;
  AutovalidateMode? autovalidateMode;
  String? restorationId;

  FileInputFormField({
    super.key,
    this.onSaved,
    this.forceErrorText,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.autovalidateMode,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<FileData>(
        initialValue: initialValue,
        onSaved: onSaved,
        forceErrorText: forceErrorText,
        validator: validator,
        enabled: enabled,
        autovalidateMode: autovalidateMode,
        restorationId: restorationId,
        builder: (state) {
          var fileData = state.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  var imagesource =
                      await boomSheetOptions<ImageSources>(options: [
                    BottomSheetOption(
                        label: 'Upload from Gallery',
                        icon: Kiwoo.image,
                        onPressed: () {
                          return ImageSources.gallery;
                        }),
                    BottomSheetOption(
                        label: 'Upload from File',
                        icon: Kiwoo.image,
                        onPressed: () {
                          return ImageSources.file;
                        }),
                    BottomSheetOption(
                        label: 'Take a Photo',
                        icon: Kiwoo.image,
                        onPressed: () {
                          return ImageSources.camera;
                        })
                  ]);
                  if (imagesource != null) {
                    var data = await PickFile.imageFile(
                      imageQuality: 20,
                      maxFileSizeInMb: 2,
                      source: imagesource,
                      type: FileType.custom,
                      allowedExtensions: [
                        'pdf',
                        'jpg',
                        'jpeg',
                        'png',
                        'docx',
                      ],
                      crop: true,
                      cropperToolbarTitle: "Crop Profil Picture",
                    ).onError((error, s) {
                      showMsg(error as String, type: TypeMessage.error);
                      return null;
                    });

                    if (data == null) return;
                    state.didChange(data);
                    // showOverlay(
                    //   asyncFunction: () => controller.uploadFile(data),
                    // );
                  }
                },
                child: Container(
                  height: 170.ss,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.APPBAR_PRIMARY1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: fileData == null
                      ? Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.APPBAR_PRIMARY1,
                        )
                      : isDocument(fileData)
                          ? Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy_sharp,
                                  size: 60,
                                  color: AppColors.APPBAR_PRIMARY1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  fileData.baseName,
                                  style: TextStyle(
                                      color: AppColors.APPBAR_PRIMARY1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ))
                          : Image.memory(fileData.bytes!),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${state.errorText}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                )
            ],
          );
        });
  }

  bool isDocument(FileData data) {
    if (data.mimeType.startsWith('application')) return true;
    return false;
  }
}
