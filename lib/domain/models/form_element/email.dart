import 'package:formz/formz.dart';

enum EmailFormElementValidationError { empty, invalid }

class EmailFormElementModel
    extends FormzInput<String, EmailFormElementValidationError> {
  const EmailFormElementModel.pure() : super.pure('');
  const EmailFormElementModel.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailFormElementValidationError? validator(String value) {
    if (value.isEmpty) return EmailFormElementValidationError.empty;
    return _emailRegex.hasMatch(value)
        ? null
        : EmailFormElementValidationError.invalid;
  }
}

extension EmailErrorMessageExtension on EmailFormElementValidationError {
  String errorMessage() {
    switch (this) {
      case EmailFormElementValidationError.empty:
        return "Please enter your email address";
      default:
        return "Please enter a valid email";
    }
  }
}
