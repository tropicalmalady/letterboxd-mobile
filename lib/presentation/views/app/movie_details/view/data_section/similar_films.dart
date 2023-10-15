import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsSimilarFilms extends StatelessWidget {
  const BuildMovieDetailsSimilarFilms({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        buildWhen: (prev, next) => prev.apiStatus != next.apiStatus,
        builder: (context, state) {
      return state.movieDetails.similar.results.isEmpty
          ? buildEmptyContainer
          : Padding(
            padding: const EdgeInsets.only(top:SpacingManager.xlg),
            child: buildFilmListCollection(
                title: "Similar Films",
                onPressed: () {
                  print("hmm");
                },
                items: state.movieDetails.similar.results.fold({}, (acc, item) {
                  if(item.posterPath==null) return acc;
                  acc[item.posterPath!] = () {};
                  return acc;
                })),
          );
    });
  }
}
