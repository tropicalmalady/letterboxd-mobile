import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/data_source/remote_data_source.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/repository_impl/_helper.dart';
import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/data/response/auth/auth.dart';
import 'package:letterboxd/domain/repository/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<FailureResponse, SignUpResponse>> signUp(
          SignUpRequest request) async =>
      resolveResponse(() => _remoteDataSource.signUp(request));

  @override
  Future<Either<FailureResponse, UsernameCheckResponse>> usernameCheck(
          UsernameCheckRequest request) async =>
      resolveResponse(() => _remoteDataSource.usernameCheck(request));
}
