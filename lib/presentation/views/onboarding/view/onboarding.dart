import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/domain/models/carousel.dart';
import 'package:letterboxd/domain/repository/auth.dart';
import 'package:letterboxd/domain/usecase/username_check.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/event.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/state.dart';
import 'package:letterboxd/presentation/views/onboarding/view/sign_in.dart';
import 'package:letterboxd/presentation/views/onboarding/view/sign_up.dart';
import 'package:letterboxd/presentation/views/onboarding/view/tour.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingBloc>().add(OnBoardingCarouselSwipeStarted());
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      _imageSliderWidget(size),
      buildGradientContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              letterboxdLogoWidget(appWidth: size.width),
              buildDivider(),
              _onBoardingActionsWidget(context, size),
              _footerDescriptionTextWidget(size)
            ],
          ),
          stops: const [0.45, 0.55, 0.7]),
    ]);
  }
}

Widget _imageSliderWidget(Size size) {
  return BlocSelector<OnBoardingBloc, OnBoardingState, CarouselModel>(
      selector: (state) => state.carousel,
      builder: (context, state) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Image.asset(
                key: UniqueKey(),
                state.data.elementAt(state.currentIndex).movieImage,
                fit: BoxFit.cover,
                height: size.height * 0.6),
          ));
}

Widget _onBoardingActionsWidget(BuildContext context, Size size) {
  return ListView(
    padding: EdgeInsets.only(bottom: size.height * 0.1),
    shrinkWrap: true,
    children: [
      buildButton(title: "Sign in", onPressed: () {
        triggerBottomSheet(context,
            child: SizedBox(height: size.height * 0.93, child: SignInForm()));
      }),
      buildDividerWithLeftPadding(12),
      buildButton( title: "Create account", onPressed: () {
        triggerBottomSheet(context,
            child: SizedBox(
                height: size.height * 0.93, child: const SignUpForm()));
      }),
      buildDividerWithLeftPadding(12),
      buildButton(title: "Open the tour", onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OnBoardingTour()));
      }),
      buildDivider(),
    ],
  );
}

Widget _footerDescriptionTextWidget(Size size) {
  return BlocSelector<OnBoardingBloc, OnBoardingState, CarouselModel>(
      selector: (state) => state.carousel,
      builder: (context, state) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Center(
              child: artworkDescriptionTextWidget(context,
                  text: state.data.elementAt(state.currentIndex).movieName),
            ),
          ));
}
