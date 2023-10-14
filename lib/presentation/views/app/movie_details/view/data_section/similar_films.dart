import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsSimilarFilms extends StatelessWidget {
  const BuildMovieDetailsSimilarFilms({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      return state.movieDetails.similar.results.isEmpty
          ? buildEmptyContainer
          : Container();
    });
  }
}
