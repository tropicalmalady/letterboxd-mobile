import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsDetails extends StatelessWidget {
  const BuildMovieDetailsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        buildWhen: (prev, next) => prev.apiStatus != next.apiStatus,
        builder: (context, state) {
          return Column(
            children: [
              state.movieDetails.studios.isEmpty? buildEmptyContainer:
              buildTitledListTiles(
                  title: "Studios",
                  items: state.movieDetails.studios.fold({},
                      (accumulator, item) {
                    accumulator[item.name] = () {};
                    return accumulator;
                  })),
              state.movieDetails.countries.isEmpty? buildEmptyContainer:
              buildTitledListTiles(
                  title: "Country",
                  items: state.movieDetails.countries.fold({},
                      (accumulator, item) {
                    accumulator[item.name] = () {};
                    return accumulator;
                  })),
              buildTitledListTiles(
                  title: "Language",
                  items: {state.movieDetails.originalLanguage.name: () {}}),
              state.movieDetails.alternativeTitles.isEmpty? buildEmptyContainer:
              buildTitledListTiles(
                  title: "Alternative Titles",
                  isClickable: false,
                  items: state.movieDetails.alternativeTitles.fold({},
                      (accumulator, item) {
                    accumulator[item] = null;
                    return accumulator;
                  })),
            ],
          );
        });
  }
}
