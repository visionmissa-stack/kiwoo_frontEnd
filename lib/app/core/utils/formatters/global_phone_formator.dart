import 'package:flutter/services.dart';
import 'package:phone_numbers_parser/metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

String getCountryCode(IsoCode code) {
  return metadataByIsoCode[code]!.countryCode;
}

class GlobalPhoneNumberFormatter extends TextInputFormatter {
  final IsoCode regionCode;

  GlobalPhoneNumberFormatter({required this.regionCode});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    String oldText = oldValue.text;

    String cleanText = newText.replaceAll(RegExp(r'[^\d]'), '');
    String oldCleanText = oldText.replaceAll(RegExp(r'[^\d]'), '');

    // Get the current cursor position
    int cursorPosition = newValue.selection.baseOffset;
    // Count how many non-digit characters are before the cursor
    int nonDigitCount = 0;
    for (int i = 0; i < cursorPosition; i++) {
      if (int.tryParse(newText[i]) == null) {
        nonDigitCount++;
      }
    }

    // The position of the cursor in the clean text
    int cleanCursorPosition = cursorPosition - nonDigitCount;

    // Handle deletion
    if (cleanText.length < oldCleanText.length) {
      // When deleting, we just format the cleaned text.
      // The parser will handle incomplete numbers.
    }
    if (cleanText.length > oldCleanText.length &&
        metadataLenghtsByIsoCode[regionCode]!.mobile[0] < cleanText.length) {
      return TextEditingValue(
        text: oldText,
        selection: TextSelection.collapsed(
          offset: oldText.length,
        ), // coverage:ignore-line
      );
    }

    // Format the number
    String formattedText = PhoneNumber(
      isoCode: regionCode,
      nsn: cleanText,
    ).formatNsn();
    print("the formated tedt $formattedText");
    // If formatting results in an empty string and the user was deleting,
    // we should respect that.
    if (formattedText.isEmpty && newText.length < oldText.length) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0), // coverage:ignore-line
      );
    }

    // Calculate the new cursor position
    int newCursorPosition = 0;
    int cleanCharacterCount = 0;
    for (int i = 0; i < formattedText.length; i++) {
      if (int.tryParse(formattedText[i]) != null) {
        cleanCharacterCount++;
      }
      if (cleanCharacterCount == cleanCursorPosition) {
        newCursorPosition = i + 1;
        break;
      }
    }

    if (cleanCharacterCount < cleanCursorPosition) {
      newCursorPosition = formattedText.length;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}
