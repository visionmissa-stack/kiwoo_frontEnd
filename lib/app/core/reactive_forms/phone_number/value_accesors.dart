import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class MyPhoneNumberValueAccessor
    extends ControlValueAccessor<String, PhoneNumber> {
  @override
  PhoneNumber? modelToViewValue(String? modelValue) {
    return modelValue != null ? PhoneNumber.parse(modelValue) : null;
  }

  @override
  String? viewToModelValue(PhoneNumber? viewValue) {
    return (viewValue?.nsn == '' || viewValue == null)
        ? null
        : viewValue.international;
  }
}
