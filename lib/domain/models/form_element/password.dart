import 'package:formz/formz.dart';

enum PasswordFormElementValidationError { empty, invalid }

class PasswordFormElementModel
    extends FormzInput<String, PasswordFormElementValidationError> {
  const PasswordFormElementModel.pure() : super.pure("");
  const PasswordFormElementModel.dirty([super.value = ""]) : super.dirty();

  static final _passwordRegex = RegExp(r'^.{6,32}$');

  @override
  PasswordFormElementValidationError? validator(String value) {
    if (value.isEmpty) return PasswordFormElementValidationError.empty;
    return _passwordRegex.hasMatch(value)
        ? null
        : PasswordFormElementValidationError.invalid;
  }
}

extension PasswordErrorMessageExtension on PasswordFormElementValidationError {
  String errorMessage() {
    switch (this) {
      case PasswordFormElementValidationError.empty:
        return "Please enter a password";
      default:
        return "Your password must be between 6 and 32 characters";
    }
  }
}
