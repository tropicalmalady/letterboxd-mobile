import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letterboxd/play_ground.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/_view.dart';
import 'package:letterboxd/presentation/views/app/search/view/search.dart';
import 'package:letterboxd/presentation/views/onboarding/view/onboarding.dart';

abstract class Routes {
  static const String onBoardingRoute = "/onBoarding";
  static const String searchMoviesRoute = "/search";
  static const String movieDetailsRoute = "/movieDetails";
  static const String movieDetailsPosterHeroRoute = "/posterImage";
  static const String defaultRoute = "/default";
  static const String playgroundRoute = "/playground";
}

class RouteManager {
  static PageRoute getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.defaultRoute:
      case Routes.searchMoviesRoute:
        return MaterialPageRoute(
            builder: (_) => _appWithScaffold(child: const BuildSearch()));
      case Routes.movieDetailsRoute:
        return MaterialPageRoute(builder: (_) => const BuildMovieDetails());

      case Routes.playgroundRoute:
        return MaterialPageRoute(
            builder: (_) => _appWithScaffold(child: const BuildPlayGround()));

      case Routes.onBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => _appWithScaffold(child: const OnBoardingView()));
      case Routes.movieDetailsPosterHeroRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BuildPosterHeroPage(
                  scrollOffset: (settings.arguments as PosterHeroPageArguments)
                      .scrollOffset,
                  posterPath: (settings.arguments as PosterHeroPageArguments)
                      .posterPath),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
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
