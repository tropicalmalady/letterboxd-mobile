import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/_view.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetails extends StatelessWidget {
  final bool isHeroWidget;
  final double initialScrollOffset;
  const BuildMovieDetails(
      {Key? key, this.isHeroWidget = false, this.initialScrollOffset = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          buildWhen: (prev, next) => prev.apiStatus != next.apiStatus,
          builder: (context, state) {
            print("building movie details");
            return ApiStatusHelper(state.apiStatus).isLoading
                ? buildFullscreenLoader()
                : BuildMovieDetailsIntroSection(
                    isHeroWidget: isHeroWidget,
                    initialScrollOffset: initialScrollOffset,
                    title: state.movieDetails.title,
                    backdropPath: state.movieDetails.backdropPath,
                    originalTitle: state.movieDetails.originalTitle,
                    releaseDate: state.movieDetails.releaseDate,
                    directorName: state.movieDetails.directorName,
                    runtime: state.movieDetails.runtime,
                    posterPath: state.movieDetails.posterPath,
                    tagLine: state.movieDetails.tagline,
                    trailerLink: state.movieDetails.trailer,
                    synopsis: state.movieDetails.overview,
                    child: BuildMovieDetailsDataSection(
                      state: state.movieDetails,
                    ));
          }),
    );
  }
}
