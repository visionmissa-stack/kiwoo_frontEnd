import 'package:reactive_forms/reactive_forms.dart'
    show AbstractControl, Validator;
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

/// Provides a set of built-in validators that can be used by form controls.
class PhoneValidators {
  /// Gets a validator that requires the control have a non-empty value.
  static RequiredPhoneValidator get required => const RequiredPhoneValidator();

  /// Gets a validator that requires the control's value pass an phone
  /// validation test.
  static ValidPhoneValidator get valid => const ValidPhoneValidator();

  /// Gets a validator that requires the control's value pass an phone
  /// validation test.
  static CountryPhoneValidator forCountries({
    required Set<IsoCode> allowedCountries,
  }) => CountryPhoneValidator(allowedCountries: allowedCountries);

  /// Gets a validator that requires the control's value pass a fixed line phone
  /// validation test.
  static ValidPhoneValidator get validFixedLine =>
      const ValidPhoneValidator(type: PhoneNumberType.fixedLine);

  /// Gets a validator that requires the control's value pass a mobile phone
  /// validation test.
  static ValidPhoneValidator get validMobile =>
      const ValidPhoneValidator(type: PhoneNumberType.mobile);
}

class RequiredPhoneValidator extends Validator<String> {
  const RequiredPhoneValidator();

  @override
  Map<String, Object>? validate(AbstractControl<String> control) {
    final value = control.value == null
        ? null
        : PhoneNumber.parse(control.value!);

    if (value == null || value.nsn.trim().isEmpty) {
      return {PhoneValidationMessage.required: true};
    }

    return null;
  }
}

class ValidPhoneValidator extends Validator<String> {
  const ValidPhoneValidator({this.type});

  final PhoneNumberType? type;

  @override
  Map<String, Object>? validate(AbstractControl<String> control) {
    final value = control.value == null
        ? null
        : PhoneNumber.parse(control.value!);

    if (value == null || value.nsn.trim().isEmpty) return null;

    if (!value.isValid(type: type)) {
      final messageKey = switch (type) {
        PhoneNumberType.mobile =>
          PhoneValidationMessage.invalidMobilePhoneNumber,
        PhoneNumberType.fixedLine =>
          PhoneValidationMessage.invalidFixedLinePhoneNumber,
        _ => PhoneValidationMessage.invalidPhoneNumber,
      };

      return {messageKey: type ?? true};
    }

    return null;
  }
}
