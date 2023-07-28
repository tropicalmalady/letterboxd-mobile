import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:letterboxd/domain/models/form_element/form_element.dart';

class SignInFormModel extends Equatable {
  final UsernameFormElementModel usernameOrEmail;
  final PasswordFormElementModel password;
  final FormzSubmissionStatus status;

  const SignInFormModel({
    this.usernameOrEmail = const UsernameFormElementModel.pure(),
    this.password = const PasswordFormElementModel.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  SignInFormModel copyWith(
      {UsernameFormElementModel? usernameOrEmail,
      PasswordFormElementModel? password,
      FormzSubmissionStatus? status}) {
    return SignInFormModel(
        usernameOrEmail: usernameOrEmail ?? this.usernameOrEmail,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [usernameOrEmail, password, status];
}
