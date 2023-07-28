import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/data/response/tmdb/tmdb.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/_base.dart';

class SearchMoviesUseCase
    extends BaseUseCase<SearchMovieRequest, MoviesPreviewModel> {
  final TmdbRepository _repo;

  SearchMoviesUseCase(this._repo);
  @override
  Future<Either<FailureResponse, MoviesPreviewModel>> execute(
          SearchMovieRequest input) =>
      _repo.searchMovies(input);
}
