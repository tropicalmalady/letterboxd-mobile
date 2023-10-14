import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letterboxd/app/app.dart';
import 'package:letterboxd/app/bloc_observable.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorManager.primaryColor,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Bloc.observer = AppBlocObserver();
    runApp(LetterboxdApp());
  });
}
