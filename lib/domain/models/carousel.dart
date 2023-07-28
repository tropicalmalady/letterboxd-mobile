import 'package:equatable/equatable.dart';
import 'package:letterboxd/presentation/managers/managers.dart';

class CarouselModel extends Equatable {
  final Iterable<CarouselMovieObjectModel> data;
  final int currentIndex;

  const CarouselModel({required this.data, required this.currentIndex});

  static CarouselModel get defaultCarouselData => CarouselModel(data: [
        CarouselMovieObjectModel(
            movieImage: MovieBannerImageManger.tropicalMalady,
            movieName: "Tropical Malady"),
        CarouselMovieObjectModel(
            movieImage: MovieBannerImageManger.burning, movieName: "Burning"),
        CarouselMovieObjectModel(
            movieImage: MovieBannerImageManger.theAdventure,
            movieName: "The Adventure"),
        CarouselMovieObjectModel(
            movieImage: MovieBannerImageManger.apocalypseNow,
            movieName: "Apocalypse Now"),
        CarouselMovieObjectModel(
            movieImage: MovieBannerImageManger.wagesOfFear,
            movieName: "The Wages of Fear")
      ], currentIndex: 0);

  @override
  List<Object> get props => [data, currentIndex];
}

class CarouselMovieObjectModel extends Equatable {
  final String movieImage;
  final String movieName;

  const CarouselMovieObjectModel(
      {required this.movieImage, required this.movieName});

  @override
  List<Object> get props => [movieImage, movieName];
}
