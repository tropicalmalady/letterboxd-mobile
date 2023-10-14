import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/data_source/remote_data_source.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/repository_impl/_helper.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/data/response/tmdb/tmdb.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/models/tmdb/movie_details.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  final RemoteDataSource _remoteDataSource;

  TmdbRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<FailureResponse, MoviesPreviewModel>> searchMovies(
          MoviesPreviewRequest request) =>
      resolveResponse(() => _remoteDataSource.searchMovies(request));

  @override
  Future<Either<FailureResponse, MovieDetailsModel>> getMovieDetails(
          GetMovieDetailsRequest request) =>
      resolveResponse(() => _remoteDataSource.getMovieDetails(request));
}
