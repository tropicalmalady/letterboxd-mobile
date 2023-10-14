import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/movie_details.dart';

class BuildMovieDetailsPage extends StatelessWidget {
  const BuildMovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BuildMovieDetails(),
    );
  }
}
