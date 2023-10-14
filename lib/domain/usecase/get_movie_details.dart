import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/domain/models/tmdb/movie_details.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/_base.dart';

class GetMovieDetailsUseCase
    extends BaseUseCase<GetMovieDetailsRequest, MovieDetailsModel> {
  final TmdbRepository _repo;
  GetMovieDetailsUseCase(this._repo);

  @override
  Future<Either<FailureResponse, MovieDetailsModel>> execute(
          GetMovieDetailsRequest input) =>
      _repo.getMovieDetails(input);
}

