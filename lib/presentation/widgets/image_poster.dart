import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/test.dart';

const tmdbSmallImageUrl = "https://image.tmdb.org/t/p/w92";
const tmdbMediumImageUrl = "https://image.tmdb.org/t/p/w185";
const tmdbLargeImageUrl = "https://image.tmdb.org/t/p/w300";

final buildPlaceholder = Container(color: ColorManager.primaryColor);

Widget buildImage(String path, [tmdbImageUrl = tmdbMediumImageUrl]) {
  return Container(
    color: ColorManager.primaryColor,
    child: Image.network(
      "$tmdbImageUrl$path",
      errorBuilder: (context, err, st) => buildPlaceholder,
      fit: BoxFit.cover,
    ),
  );
}

Widget buildPosterImage({String? posterPath, required double width}) {
  return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(0.7),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(width: 0.7, color: ColorManager.primaryColor7)),
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: posterPath != null ? buildImage(posterPath) : null,
        ),
      ));
}

Widget buildBackdropImage({String? backdropPath}) {
  return backdropPath != null
      ? buildImage(backdropPath, tmdbLargeImageUrl)
      : buildPlaceholder;
}
