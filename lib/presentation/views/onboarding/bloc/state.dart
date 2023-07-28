import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import "package:letterboxd/domain/models/_models.dart";

class OnBoardingState extends Equatable {
  final CarouselModel carousel;
  final SignUpFormModel signUpForm;
  final SignInFormModel signInForm;
  const OnBoardingState(
      {required this.carousel,
      required this.signUpForm,
      required this.signInForm});

  OnBoardingState copyWith(
          {CarouselModel? carousel,
          SignUpFormModel? signUpForm,
          SignInFormModel? signInForm}) =>
      OnBoardingState(
          carousel: carousel ?? this.carousel,
          signUpForm: signUpForm ?? this.signUpForm,
          signInForm: signInForm ?? this.signInForm);

  OnBoardingState setCarouselCurrentIndex(int index) => copyWith(
      carousel: CarouselModel(data: carousel.data, currentIndex: index));

  OnBoardingState setSignUpFormUsername(UsernameFormElementModel username,
          List<FormzInput<dynamic, dynamic>> validationArgs) =>
      copyWith(
          signUpForm: signUpForm.copyWith(
              username: username, isValid: Formz.validate(validationArgs)));

  OnBoardingState setSignUpFormEmail(EmailFormElementModel email,
          List<FormzInput<dynamic, dynamic>> validationArgs) =>
      copyWith(
          signUpForm: signUpForm.copyWith(
              email: email, isValid: Formz.validate(validationArgs)));

  OnBoardingState setSignUpFormPassword(PasswordFormElementModel password,
          List<FormzInput<dynamic, dynamic>> validationArgs) =>
      copyWith(
          signUpForm: signUpForm.copyWith(
              password: password, isValid: Formz.validate(validationArgs)));

  OnBoardingState setSignUpFormTermsOfUse(TermsOfUseFormElementModel value,
          List<FormzInput<dynamic, dynamic>> validationArgs) =>
      copyWith(
          signUpForm: signUpForm.copyWith(
              termsOfUse: value, isValid: Formz.validate(validationArgs)));

  OnBoardingState setSignUpFormPrivacyPolicy(
          PrivacyPolicyFormElementModel value,
          List<FormzInput<dynamic, dynamic>> validationArgs) =>
      copyWith(
          signUpForm: signUpForm.copyWith(
              privacyPolicy: value, isValid: Formz.validate(validationArgs)));

  OnBoardingState setSignUpFormSubmissionState(FormzSubmissionStatus status) =>
      copyWith(signUpForm: signUpForm.copyWith(status: status));

  OnBoardingState setSignUpStateToDefault() =>
      copyWith(signUpForm: const SignUpFormModel());
  @override
  List<Object> get props => [carousel, signUpForm];
}
