part of "bloc.dart";

abstract class MovieDetailsEvent extends Equatable{
}

class MovieDetailsRequested extends MovieDetailsEvent{
  final int movieId;
  MovieDetailsRequested(this.movieId);

  @override
  List<Object?> get props =>[movieId];
}