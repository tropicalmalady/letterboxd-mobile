import 'package:flutter/material.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsCast extends StatelessWidget {
  const BuildMovieDetailsCast({Key? key, required this.state})
      : super(key: key);
  final MovieDetailsCreditsModel state;

  @override
  Widget build(BuildContext context) {
    print("building cast");
    return Column(
      children: List.generate(
          state.cast.length,
          (index) => buildTileButton(
              title: state.cast[index].name,
              subtitle: state.cast[index].character,
              imagePath: state.cast[index].profilePath,
              onPressed: () {})).toList(),
    );
  }
}
