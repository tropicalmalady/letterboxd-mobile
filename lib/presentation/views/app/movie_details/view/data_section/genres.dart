import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsGenres extends StatelessWidget {
  const BuildMovieDetailsGenres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        buildWhen: (prev, next) => prev.apiStatus != next.apiStatus,
        builder: (context, state) {
          return Column(
            children: [
              state.movieDetails.genres.isEmpty
                  ? buildEmptyContainer
                  : buildTitledListTiles(
                      title: "Genres",
                      items: state.movieDetails.genres.fold({},
                          (accumulator, item) {
                        accumulator[item.name] = () {};
                        return accumulator;
                      })),
            ],
          );
        });
  }
}
