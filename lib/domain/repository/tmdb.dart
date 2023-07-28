import "package:dartz/dartz.dart";
import "package:letterboxd/data/network/error/failure_response.dart";
import "package:letterboxd/data/request/tmdb.dart";
import "package:letterboxd/domain/models/movie_preview.dart";

abstract class TmdbRepository {
  Future<Either<FailureResponse, MoviesPreviewModel>> searchMovies(
      SearchMovieRequest request);
}
