import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letterboxd/presentation/views/app/movie_details/movie_details.dart';
import 'package:letterboxd/presentation/views/app/search/view/categories.dart';
import 'package:letterboxd/presentation/views/app/search/view/search.dart';
import 'package:letterboxd/presentation/views/onboarding/view/onboarding.dart';
import 'package:letterboxd/presentation/views/onboarding/view/tour.dart';
import 'package:letterboxd/test.dart';

class RouteManager {
  static MaterialPageRoute<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.onBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => _appWithScaffold(child:const BuildMovieDetails()));
      default:
        return _undefinedRoute();
    }
  }

  static MaterialPageRoute _undefinedRoute() => MaterialPageRoute(
      builder: (_) => _appWithScaffold(
              child: const Center(
            child: Text("Route not found"),
          )));

  static Widget _appWithoutScaffold({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: child);
  }

  static Widget _appWithScaffold({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: child,
      ),
    );
  }
}

class RouteName {
  static const String onBoardingRoute = "/onBoarding";
}
