import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/data/data_source/remote_data_source.dart';
import 'package:letterboxd/data/network/dio/config.dart';
import 'package:letterboxd/data/network/service/app_service.dart';
import 'package:letterboxd/data/repository_impl/auth.dart';
import 'package:letterboxd/data/repository_impl/tmdb.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/repository/auth.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/onboarding/bloc/bloc.dart';

final remoteDataSource =
    RemoteDataSourceImpl(AppServiceClient(DioFactory().getDio()));

class LetterboxdApp extends StatefulWidget {
  const LetterboxdApp._internal();
  static const LetterboxdApp instance =
      LetterboxdApp._internal(); // single instance -- singleton
  factory LetterboxdApp() => instance;

  @override
  State<LetterboxdApp> createState() => _LetterboxdAppState();
}

class _LetterboxdAppState extends State<LetterboxdApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(remoteDataSource)),
        RepositoryProvider<TmdbRepository>(
            create: (context) => TmdbRepositoryImpl(remoteDataSource))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<OnBoardingBloc>(
              create: (BuildContext context) => OnBoardingBloc(
                  ticker: TickerModel(durationInMilliSeconds: 5000),
                  authRepository: context.read<AuthRepository>())),
          BlocProvider<SearchBloc>(
              create: (BuildContext context) =>
                  SearchBloc(tmdbRepository: context.read<TmdbRepository>())),
          BlocProvider<MovieDetailsBloc>(
              create: (context) => MovieDetailsBloc(
                  tmdbRepository: context.read<TmdbRepository>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager().themeData,
          onGenerateRoute: RouteManager.getRoute,
          initialRoute: Routes.defaultRoute,
        ),
      ),
    );
  }
}
