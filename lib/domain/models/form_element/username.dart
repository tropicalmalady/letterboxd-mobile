import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum UsernameFormElementValidationError { empty, invalid, exists }

enum UsernameFormElementExists { notChecked, exists, doesNotExist }

class UsernameFormElementModel
    extends FormzInput<String, UsernameFormElementValidationError> {
  final UsernameFormElementExists _exists;
  UsernameFormElementExists get exists => _exists;
  const UsernameFormElementModel.pure()
      : _exists = UsernameFormElementExists.notChecked,
        super.pure("");
  const UsernameFormElementModel.dirty(
      [super.value = "", this._exists = UsernameFormElementExists.notChecked])
      : super.dirty();

  static final _usernameRegex = RegExp(r'^[a-zA-Z_]\w{0,14}$');

  @override
  UsernameFormElementValidationError? validator(String value) {
    if (value.isEmpty) return UsernameFormElementValidationError.empty;
    if (_exists == UsernameFormElementExists.exists) {
      return UsernameFormElementValidationError.exists;
    }
    return _usernameRegex.hasMatch(value)
        ? null
        : UsernameFormElementValidationError.invalid;
  }

  List<Object?> get props => [_exists];
}

extension UsernameErrorMessageExtension on UsernameFormElementValidationError {
  String errorMessage() {
    switch (this) {
      case UsernameFormElementValidationError.empty:
        return "Please enter a username";
      case UsernameFormElementValidationError.exists:
        return "Your username is not available";
      default:
        return "Usernames may only contain letters, numbers and underscores";
    }
  }
}
