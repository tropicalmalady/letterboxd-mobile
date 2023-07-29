import 'package:flutter/cupertino.dart';
import 'package:letterboxd/presentation/views/app/movie_details/intro.dart';
import 'package:letterboxd/presentation/widgets/container.dart';

class BuildMovieDetails extends StatelessWidget {
  final bool withPosterImage;
  final double initialScrollOffset;
  const BuildMovieDetails({Key? key, this.withPosterImage = true,this.initialScrollOffset=0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildMovieDetailsIntro(
        withPosterImage: withPosterImage,
        initialScrollOffset: initialScrollOffset,
        title: "Mission : Impossible - Dead Reckoning Part One",
        backdropPath: "/dwXW7OBbkXjsVdavPHqoPf1eFo6.jpg",
        originalTitle: "djfhk dfnldkf n",
        releaseDate: "2023",
        directorName: "Christopher McQuarrie",
        runtime: 164,
        posterPath: "/wyUxfQCtcPxRzwJtFy0emtfkux8.jpg",
        tagLine:
            "BEFORE THE FALL OF THE BERLIN WALL, EAST GERMANY'S SECRET POLICE LISTENED TO YOUR SECRETS",
        trailerLink: "youtube.com",
        synopsis:
            "A tragic love story set in East Berlin with the backdrop of an undercover Stasi controlled culture. Stasi captain Wieler is ordered to follow author Dreyman and plunges deeper and deeper into his life until he reaches the threshold of doubting the system.",
        child: buildEmptyContainer);
  }
}
