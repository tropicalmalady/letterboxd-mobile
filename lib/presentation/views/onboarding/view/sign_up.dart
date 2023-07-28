import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/event.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/state.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StreamController<bool> _isPasswordVisibleController =
      StreamController();
  bool _isPasswordVisible = false;
  late OnBoardingBloc bloc;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    _isPasswordVisibleController.sink.add(_isPasswordVisible);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<OnBoardingBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisibleController.close();
    bloc.add(OnBoardingSignUpFormReset());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<OnBoardingBloc, OnBoardingState>(
      listener: (context, state) {
        debugPrint("listening");
        if (state.signUpForm.status.isInProgress) {
          showDialog(
              context: context,
              builder: (context) => LoaderWidget(),
              barrierDismissible: false);
        }

        if (state.signUpForm.status.isFailure) {
          Navigator.of(context).pop();
          showSnackBar(context, "Sign up Failure");
        }
        if (state.signUpForm.status.isSuccess) {
          Navigator.of(context).pop();
          showSnackBar(context, "Sign up Success");
          context.read<OnBoardingBloc>().add(OnBoardingSignUpFormReset());
          _usernameController.clear();
          _passwordController.clear();
          _emailController.clear();
        }
      },
      listenWhen: (previousState, state) =>
          previousState.signUpForm.status != state.signUpForm.status,
      child: Stack(
        children: [
          _imageWidget(size),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              child: buildGradientContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      headingLogoWidget(context, text: "Join Letterboxd"),
                      _signInFormFieldsWidget(context, size: size),
                      _singInActionsWidget(context),
                      _footerDescriptionTextWidget(context,
                          text: "Guardians of the Galaxy")
                    ],
                  ),
                  stops: const [0.55, 0.6, 0.75]),
            ),
          ),
          _closeModelWidget(context),
        ],
      ),
    );
  }

  Widget _dividerWidget() => buildDivider(color: ColorManager.onPrimaryColor);

  Widget _closeModelWidget(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ;
              Navigator.pop(context);
            }));
  }

  Widget _imageWidget(Size size) {
    return Image.asset(MovieBannerImageManger.killerOfSheep,
        fit: BoxFit.cover, height: size.height * 0.5);
  }

  Widget _footerDescriptionTextWidget(context, {required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 40),
      child: artworkDescriptionTextWidget(context, text: text),
    );
  }

  Widget _singInActionsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        outlinedButtonWidget(text: "SIGN IN", onPressed: () {}),
        const SizedBox(
          width: 16,
        ),
        outlinedButtonWidget(text: "RESET PASSWORD", onPressed: () {}),
        const SizedBox(
          width: 32,
        ),
        _submitButtonWidget(context)
      ]),
    );
  }

  Widget _submitButtonWidget(BuildContext context) {
    return BlocSelector<OnBoardingBloc, OnBoardingState, SignUpFormModel>(
      selector: (state) => state.signUpForm,
      builder: (context, state) => outlinedButtonWidget(
          text: "JOIN",
          onPressed: () {
            List<FormzInput<dynamic, dynamic>> input = [
              state.email,
              state.username,
              state.password,
              state.termsOfUse,
              state.privacyPolicy
            ];
            dynamic error;
            for (var element in input) {
              if (element.isNotValid) {
                error = element.error;
                break;
              }
            }
            if (error == null) {
              if (state.username.exists ==
                      UsernameFormElementExists.notChecked &&
                  state.email.isValid &&
                  state.username.isValid) {
                showSnackBar(context, "Awaiting username validation");
              } else if (state.username.value == state.password.value &&
                  state.isValid) {
                showSnackBar(context,
                    "Error registering member- For security reasons, please make your password different from your username");
              } else {
                context
                    .read<OnBoardingBloc>()
                    .add(OnBoardingSignUpFormSubmitted());
              }
            } else {
              showSnackBar(
                  context, SignUpFormModel.generateErrorMessage(error));
            }
          },
          isVariant: true),
    );
  }

  Widget _signInFormRadioWidget(BuildContext context, {required Size size}) {
    return Column(
      children: [
        _termsOfUseInputFieldWidget(context, size),
        _dividerWidget(),
        _privacyPolicyInputFieldWidget(context, size)
      ],
    );
  }

  Widget _signInFormFieldsWidget(BuildContext context, {required Size size}) {
    return Container(
        color: ColorManager.alternateColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dividerWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: [
                  _emailInputFieldWidget(),
                  _dividerWidget(),
                  _usernameInputFieldWidget(),
                  _dividerWidget(),
                  _passwordInputFieldWidget(),
                  _dividerWidget(),
                  _signInFormRadioWidget(context, size: size)
                ],
              ),
            ),
            _dividerWidget()
          ],
        ));
  }

  Widget _passwordInputFieldWidget() {
    return BlocSelector<OnBoardingBloc, OnBoardingState,
        PasswordFormElementModel>(
      selector: (state) => state.signUpForm.password,
      builder: (context, state) => StreamBuilder<bool>(
          stream: _isPasswordVisibleController.stream,
          builder: (context, snapshot) {
            return textFormFieldWithAnnexedElementWidget(
                textFormField: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: (password) => context.read<OnBoardingBloc>().add(
                      OnBoardingSignUpFormPasswordChanged(password: password)),
                  style: TextStyle(color: ColorManager.primaryColor5),
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                child: state.value.isEmpty
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passwordVisibilityToggleButtonWidget(
                              isTextObscured: !_isPasswordVisible,
                              onPressed: togglePasswordVisibility),
                          const SizedBox(
                            width: 8,
                          ),
                          state.isNotValid
                              ? invalidInputRadioWidget()
                              : validInputRadioWidget()
                        ],
                      ));
          }),
    );
  }

  Widget _usernameInputFieldWidget() {
    return BlocSelector<OnBoardingBloc, OnBoardingState, SignUpFormModel>(
        selector: (state) => state.signUpForm,
        builder: (context, state) {
          final usernameExists = state.username.exists;
          return textFormFieldWithAnnexedElementWidget(
              textFormField: TextFormField(
                controller: _usernameController,
                onChanged: (username) {
                  context.read<OnBoardingBloc>().add(
                      OnBoardingSignUpFormUsernameChanged(username: username));
                },
                style: TextStyle(color: ColorManager.primaryColor5),
                decoration: const InputDecoration(hintText: "Username"),
              ),
              child: (state.username.isNotValid && !state.username.isPure) ||
                      usernameExists == UsernameFormElementExists.exists
                  ? invalidInputRadioWidget()
                  : usernameExists == UsernameFormElementExists.doesNotExist
                      ? validInputRadioWidget()
                      : null);
        });
  }

  Widget _emailInputFieldWidget() {
    return BlocSelector<OnBoardingBloc, OnBoardingState, EmailFormElementModel>(
        selector: (state) => state.signUpForm.email,
        builder: (context, state) {
          return textFormFieldWithAnnexedElementWidget(
              textFormField: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (email) {
                  context
                      .read<OnBoardingBloc>()
                      .add(OnBoardingSignUpFormEmailChanged(email: email));
                },
                style: TextStyle(color: ColorManager.primaryColor5),
                decoration: const InputDecoration(hintText: "Email address"),
              ),
              child: state.isPure
                  ? null
                  : state.isValid
                      ? validInputRadioWidget()
                      : invalidInputRadioWidget());
        });
  }

  Widget _termsOfUseInputFieldWidget(BuildContext context, Size size) {
    return BlocSelector<OnBoardingBloc, OnBoardingState,
        TermsOfUseFormElementModel>(
      selector: (state) => state.signUpForm.termsOfUse,
      builder: (context, state) => radioCheckerWidget(
          isChecked: state.value,
          child: RichText(
              text: TextSpan(
                  text: "I'm at least 16 years old and accept the ",
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                TextSpan(
                    text: "Term of Use",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeightManager.bold))
              ])),
          size: size,
          onPressed: () => context.read<OnBoardingBloc>().add(
              OnBoardingSignUpFormTermsOfUseValueChanged(value: !state.value))),
    );
  }

  Widget _privacyPolicyInputFieldWidget(BuildContext context, Size size) {
    return BlocSelector<OnBoardingBloc, OnBoardingState,
        PrivacyPolicyFormElementModel>(
      selector: (state) => state.signUpForm.privacyPolicy,
      builder: (context, state) => radioCheckerWidget(
          isChecked: state.value,
          child: RichText(
              text: TextSpan(
                  text: "I accept the ",
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                TextSpan(
                    text: "Privacy Policy ",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeightManager.bold)),
                TextSpan(
                    text:
                        "and consent to the processing of my personal information in accordance with it ",
                    style: Theme.of(context).textTheme.bodySmall)
              ])),
          size: size,
          onPressed: () => context.read<OnBoardingBloc>().add(
              OnBoardingSignUpFormPrivacyPolicyValueChanged(
                  value: !state.value))),
    );
  }
}
