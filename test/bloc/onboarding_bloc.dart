import 'package:flutter_test/flutter_test.dart';
import 'package:letterboxd/domain/models/form/sign_up.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/event.dart';
import "package:bloc_test/bloc_test.dart";
import 'package:letterboxd/domain/models/form_element/email.dart';

void main() {
  group("Tests signup onBoarding bloc", () {
    late OnBoardingBloc onBoardingBloc;
    setUp(() {
      onBoardingBloc =
          OnBoardingBloc(ticker: const TickerModel(durationInSeconds: 5));
    });

    test(
        "checks initial state of sign up form",
        () =>
            {expect(onBoardingBloc.state.signUpForm, const SignUpFormModel())});

    blocTest(
      "emits email when OnBoardingSignUpFormEmailChanged is triggered",
      build: () => onBoardingBloc,
      act: (bloc) =>
          bloc.add(const OnBoardingSignUpFormEmailChanged(email: "jola@gmail.com")),
      expect: () => [
        onBoardingBloc.state.copyWith(
            signUpForm: onBoardingBloc.state.signUpForm
                .copyWith(email: const Email.dirty("jola@gmail.com")))
      ],
      verify: (onBoardingBloc){
       expect(onBoardingBloc.state.signUpForm.email.isValid, true);
      }
    );

    tearDown(() => onBoardingBloc.close());
  });
}
