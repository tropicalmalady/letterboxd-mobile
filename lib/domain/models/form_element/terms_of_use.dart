import 'package:formz/formz.dart';

enum TermsOfUseFormElementValidationError { unchecked }

class TermsOfUseFormElementModel
    extends FormzInput<bool, TermsOfUseFormElementValidationError> {
  const TermsOfUseFormElementModel.pure() : super.pure(false);
  const TermsOfUseFormElementModel.dirty([super.value = false]) : super.dirty();

  @override
  TermsOfUseFormElementValidationError? validator(bool? value) {
    return value == true
        ? null
        : TermsOfUseFormElementValidationError.unchecked;
  }
}

extension TermsOfUseErrorMessageExtension
    on TermsOfUseFormElementValidationError {
  String errorMessage() {
    return "Please accept the terms of use";
  }
}
