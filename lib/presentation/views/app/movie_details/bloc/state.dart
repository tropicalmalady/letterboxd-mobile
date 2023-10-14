part of "bloc.dart";

class MovieDetailsState extends Equatable {
  final ApiStatus apiStatus;
  final MovieDetailsModel movieDetails;

  const MovieDetailsState(
      {required this.apiStatus, required this.movieDetails});

  const MovieDetailsState.initial()
      : this(
            apiStatus: ApiStatus.initial,
            movieDetails: const MovieDetailsModel.initial());

  MovieDetailsState copyWith(
          {ApiStatus? apiStatus, MovieDetailsModel? movieDetails}) =>
      MovieDetailsState(
          apiStatus: apiStatus ?? this.apiStatus,
          movieDetails: movieDetails ?? this.movieDetails);

  setApiStatus(ApiStatus apiStatus) => copyWith(apiStatus: apiStatus);
  setMovieDetails(MovieDetailsModel movieDetails) =>
      copyWith(movieDetails: movieDetails);

  @override
  List<Object?> get props => [apiStatus, movieDetails];
}
