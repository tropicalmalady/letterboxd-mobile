import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/request/auth.dart';
import "package:dartz/dartz.dart";
import 'package:letterboxd/data/response/auth/auth.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, SignUpResponse>> signUp(SignUpRequest request);
  Future<Either<FailureResponse, UsernameCheckResponse>> usernameCheck(
      UsernameCheckRequest request);
}
