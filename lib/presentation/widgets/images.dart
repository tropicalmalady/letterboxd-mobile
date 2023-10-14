import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/play_ground.dart';

const tmdbSmallImageUrl = "https://image.tmdb.org/t/p/w92";
const tmdbMediumImageUrl = "https://image.tmdb.org/t/p/w185";
const tmdbLargeImageUrl = "https://image.tmdb.org/t/p/w300";

final buildPlaceholder = Container(color: ColorManager.primaryColor);

final buildCreditsPlaceholder = Container(color: ColorManager.primaryColor4);

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

Widget buildCreditsImage({String? imagePath}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    height: 45,
    width: 45,
    decoration: BoxDecoration(
      color: ColorManager.primaryColor4,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: imagePath != null
        ? Image.network(
            "$tmdbSmallImageUrl$imagePath",
            errorBuilder: (context, err, st) => buildCreditsPlaceholder,
            fit: BoxFit.cover,
          )
        : buildCreditsPlaceholder,
  );
}
