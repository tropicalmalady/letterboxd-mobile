import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:letterboxd/domain/models/_models.dart';

class SignUpFormModel extends Equatable {
  final UsernameFormElementModel username;
  final EmailFormElementModel email;
  final PasswordFormElementModel password;
  final FormzSubmissionStatus status;
  final TermsOfUseFormElementModel termsOfUse;
  final PrivacyPolicyFormElementModel privacyPolicy;
  final bool isValid;

  const SignUpFormModel(
      {this.username = const UsernameFormElementModel.pure(),
      this.email = const EmailFormElementModel.pure(),
      this.password = const PasswordFormElementModel.pure(),
      this.isValid = false,
      this.status = FormzSubmissionStatus.initial,
      this.termsOfUse = const TermsOfUseFormElementModel.pure(),
      this.privacyPolicy = const PrivacyPolicyFormElementModel.pure()});

  static String generateErrorMessage(dynamic error) {
    switch (error) {
      case EmailFormElementValidationError.empty:
        return EmailFormElementValidationError.empty.errorMessage();
      case EmailFormElementValidationError.invalid:
        return EmailFormElementValidationError.invalid.errorMessage();
      case UsernameFormElementValidationError.empty:
        return UsernameFormElementValidationError.empty.errorMessage();
      case UsernameFormElementValidationError.exists:
        return UsernameFormElementValidationError.exists.errorMessage();
      case UsernameFormElementValidationError.invalid:
        return UsernameFormElementValidationError.invalid.errorMessage();
      case PasswordFormElementValidationError.empty:
        return PasswordFormElementValidationError.empty.errorMessage();
      case PasswordFormElementValidationError.invalid:
        return PasswordFormElementValidationError.invalid.errorMessage();
      case TermsOfUseFormElementValidationError.unchecked:
        return TermsOfUseFormElementValidationError.unchecked.errorMessage();
      case PrivacyPolicyFormElementValidationError.unchecked:
        return PrivacyPolicyFormElementValidationError.unchecked.errorMessage();
      default:
        return "Something went wrong";
    }
  }

  SignUpFormModel copyWith(
      {UsernameFormElementModel? username,
      EmailFormElementModel? email,
      PasswordFormElementModel? password,
      bool? isValid,
      FormzSubmissionStatus? status,
      TermsOfUseFormElementModel? termsOfUse,
      PrivacyPolicyFormElementModel? privacyPolicy}) {
    return SignUpFormModel(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
        termsOfUse: termsOfUse ?? this.termsOfUse,
        privacyPolicy: privacyPolicy ?? this.privacyPolicy);
  }

  @override
  List<Object> get props => [
        username,
        email,
        password,
        isValid,
        status,
        termsOfUse,
        privacyPolicy,
        username.props,
      ];
}
