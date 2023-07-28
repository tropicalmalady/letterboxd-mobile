import 'package:formz/formz.dart';

enum PrivacyPolicyFormElementValidationError { unchecked }

class PrivacyPolicyFormElementModel
    extends FormzInput<bool, PrivacyPolicyFormElementValidationError> {
  const PrivacyPolicyFormElementModel.pure() : super.pure(false);
  const PrivacyPolicyFormElementModel.dirty([super.value = false])
      : super.dirty();

  @override
  PrivacyPolicyFormElementValidationError? validator(bool? value) {
    return value == true
        ? null
        : PrivacyPolicyFormElementValidationError.unchecked;
  }
}

extension PrivacyPolicyErrorMessageExtension
    on PrivacyPolicyFormElementValidationError {
  String errorMessage() {
    return "Please accept the privacy policy";
  }
}
