import 'package:letterboxd/data/network/service/app_service.dart';
import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/data/response/auth/auth.dart';
import 'package:letterboxd/data/response/tmdb/tmdb.dart';

abstract class RemoteDataSource {
  Future<SignUpResponse> signUp(SignUpRequest request);
  Future<UsernameCheckResponse> usernameCheck(UsernameCheckRequest request);
  Future<SearchMovieResponse> searchMovies(SearchMovieRequest request);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) => _appServiceClient
      .signUp(request.username, request.email, request.password);

  @override
  Future<UsernameCheckResponse> usernameCheck(UsernameCheckRequest request) =>
      _appServiceClient.usernameCheck(request.username);

  @override
  Future<SearchMovieResponse> searchMovies(
          SearchMovieRequest request) =>
      _appServiceClient.searchMovies(request.query,request.page);
}
