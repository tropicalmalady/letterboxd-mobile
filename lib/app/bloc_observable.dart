import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/event.dart';

class AppBlocObserver extends BlocObserver {
  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   debugPrint('${bloc.runtimeType} $change');
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if(transition.event is! OnBoardingCarouselSwipeStarted) {
      debugPrint('${bloc.runtimeType} ${transition.event} ',wrapWidth: 100);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
