import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/repository/auth.dart';
import 'package:letterboxd/domain/usecase/sign_up.dart';
import 'package:letterboxd/domain/usecase/username_check.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/event.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final TickerModel _ticker;
  final AuthRepository _authRepository;
  OnBoardingBloc({ticker, authRepository})
      : _ticker = ticker,
        _authRepository = authRepository,
        super(OnBoardingState(
            carousel: CarouselModel.defaultCarouselData,
            signUpForm: const SignUpFormModel(),
            signInForm: const SignInFormModel())) {
    on<OnBoardingCarouselSwipeStarted>(_onCarouselSwiped);
    on<OnBoardingSignUpFormEmailChanged>(_onSignUpFormEmailChanged);
    on<OnBoardingSignUpFormUsernameChanged>(_onSignUpFormUsernameChanged);
    on<OnBoardingSignUpFormPasswordChanged>(_onSignUpFormPasswordChanged);
    on<OnBoardingSignUpFormTermsOfUseValueChanged>(
        _onSignUpFormTermsOfUseValueChanged);
    on<OnBoardingSignUpFormPrivacyPolicyValueChanged>(
        _onSignUpFormPrivacyPolicyValueChanged);
    on<OnBoardingSignUpFormSubmitted>(_onSignUpFormSubmitClicked);
    on<OnBoardingSignUpFormReset>(_onSignUpFormReset);
  }

  void _onCarouselSwiped(OnBoardingCarouselSwipeStarted event,
      Emitter<OnBoardingState> emit) async {
    await emit.forEach(
      _ticker.infiniteTick(),
      onData: (int index) {
        return state.setCarouselCurrentIndex(
          regulateLoopCounter(index, state.carousel.data.length));

        },
    );
  }

  Future<void> _onSignUpFormUsernameChanged(
      OnBoardingSignUpFormUsernameChanged event,
      Emitter<OnBoardingState> emit) async {
    UsernameFormElementModel username =
        UsernameFormElementModel.dirty(event.username);

    emit(state.setSignUpFormUsername(username,
        [username, state.signUpForm.password, state.signUpForm.email]));
    (await UsernameCheckUseCase(_authRepository)
            .execute(UsernameCheckRequest(event.username)))
        .fold((l) => null, (r) {
      username = UsernameFormElementModel.dirty(
          event.username,
          r.message
              ? UsernameFormElementExists.exists
              : UsernameFormElementExists.doesNotExist);
      emit(state.setSignUpFormUsername(username,
          [username, state.signUpForm.password, state.signUpForm.email]));
    });
  }

  void _onSignUpFormEmailChanged(
      OnBoardingSignUpFormEmailChanged event, Emitter<OnBoardingState> emit) {
    final email = EmailFormElementModel.dirty(event.email);
    emit(state.setSignUpFormEmail(
        email, [email, state.signUpForm.password, state.signUpForm.username]));
  }

  void _onSignUpFormPasswordChanged(OnBoardingSignUpFormPasswordChanged event,
      Emitter<OnBoardingState> emit) {
    final password = PasswordFormElementModel.dirty(event.password);
    emit(state.setSignUpFormPassword(password,
        [password, state.signUpForm.username, state.signUpForm.email]));
  }

  void _onSignUpFormTermsOfUseValueChanged(
      OnBoardingSignUpFormTermsOfUseValueChanged event,
      Emitter<OnBoardingState> emit) {
    final termsOfUseValue = TermsOfUseFormElementModel.dirty(event.value);
    emit(state.setSignUpFormTermsOfUse(termsOfUseValue, [
      termsOfUseValue,
      state.signUpForm.username,
      state.signUpForm.password,
      state.signUpForm.email,
      state.signUpForm.privacyPolicy,
    ]));
  }

  void _onSignUpFormPrivacyPolicyValueChanged(
      OnBoardingSignUpFormPrivacyPolicyValueChanged event,
      Emitter<OnBoardingState> emit) {
    final privacyPolicyValue = PrivacyPolicyFormElementModel.dirty(event.value);
    emit(state.setSignUpFormPrivacyPolicy(privacyPolicyValue, [
      privacyPolicyValue,
      state.signUpForm.username,
      state.signUpForm.password,
      state.signUpForm.email,
      state.signUpForm.termsOfUse,
    ]));
  }

  Future<void> _onSignUpFormSubmitClicked(OnBoardingSignUpFormSubmitted event,
      Emitter<OnBoardingState> emit) async {
    emit(state.setSignUpFormSubmissionState(FormzSubmissionStatus.inProgress));
    (await SignUpUseCase(_authRepository).execute(SignUpRequest(
            state.signUpForm.username.value.toLowerCase(),
            state.signUpForm.email.value.toLowerCase(),
            state.signUpForm.password.value)))
        .fold((l) {
      debugPrint(l.message);
      emit(state.setSignUpFormSubmissionState(FormzSubmissionStatus.failure));
    },
            (r) => emit(state
                .setSignUpFormSubmissionState(FormzSubmissionStatus.success)));
  }

  void _onSignUpFormReset(
      OnBoardingSignUpFormReset event, Emitter<OnBoardingState> emit) {
    emit(state.setSignUpStateToDefault());
  }

  void disposeTicker(){
    _ticker.stopTicker();
  }

}
