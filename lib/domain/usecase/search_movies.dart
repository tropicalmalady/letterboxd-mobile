import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/data/response/tmdb/tmdb.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/_base.dart';

class MoviesPreviewUseCase
    extends BaseUseCase<MoviesPreviewRequest, MoviesPreviewModel> {
  final TmdbRepository _repo;

  MoviesPreviewUseCase(this._repo);
  @override
  Future<Either<FailureResponse, MoviesPreviewModel>> execute(
          MoviesPreviewRequest input) =>
      _repo.searchMovies(input);
}
