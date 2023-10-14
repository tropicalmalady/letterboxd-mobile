import 'package:flutter/cupertino.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildMovieDetailsCrew extends StatelessWidget {
  final MovieDetailsCreditsModel state;
  const BuildMovieDetailsCrew({Key? key, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          state.crew.length,
          (index) => buildTileButton(
              title: state.crew[index].name,
              subtitle: state.crew[index].job,
              imagePath: state.crew[index].profilePath,
              onPressed: () {})).toList(),
    );
  }
}
