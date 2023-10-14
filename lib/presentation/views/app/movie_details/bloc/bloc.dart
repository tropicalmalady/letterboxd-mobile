import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/get_movie_details.dart';

part "event.dart";
part "state.dart";

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final TmdbRepository _tmdbRepository;
  MovieDetailsBloc({required TmdbRepository tmdbRepository})
      : _tmdbRepository = tmdbRepository,
        super(const MovieDetailsState.initial()) {
    on<MovieDetailsRequested>((event, emit) async {
      emit(state.setApiStatus(ApiStatus.loading));
      (await GetMovieDetailsUseCase(_tmdbRepository)
              .execute(GetMovieDetailsRequest(event.movieId)))
          .fold((l) {
        emit(state.setApiStatus(ApiStatus.error));
        print("error occured in movie details bloc ${l.message}");
      }, (r) => emit(state.copyWith(movieDetails: r, apiStatus: ApiStatus.success)));
    });
  }
}
