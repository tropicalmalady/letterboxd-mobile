import 'package:equatable/equatable.dart';

class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();
  @override
  List<Object> get props => [];
}

class OnBoardingCarouselSwipeStarted extends OnBoardingEvent {}

class OnBoardingSignUpFormUsernameChanged extends OnBoardingEvent {
  const OnBoardingSignUpFormUsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class OnBoardingSignUpFormEmailChanged extends OnBoardingEvent {
  const OnBoardingSignUpFormEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class OnBoardingSignUpFormPasswordChanged extends OnBoardingEvent {
  const OnBoardingSignUpFormPasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class OnBoardingSignUpFormTermsOfUseValueChanged extends OnBoardingEvent {
  const OnBoardingSignUpFormTermsOfUseValueChanged({required this.value});
  final bool value;
  @override
  List<Object> get props => [value];
}

class OnBoardingSignUpFormPrivacyPolicyValueChanged extends OnBoardingEvent {
  const OnBoardingSignUpFormPrivacyPolicyValueChanged({required this.value});
  final bool value;
  @override
  List<Object> get props => [value];
}

class OnBoardingSignUpFormSubmitted extends OnBoardingEvent {}

class OnBoardingSignUpFormReset extends OnBoardingEvent{}
