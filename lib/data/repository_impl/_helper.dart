import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:letterboxd/data/network/error/error_handler.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';
import 'package:letterboxd/data/network/network_info.dart';
import 'package:letterboxd/data/response/_base.dart';

Future<Either<FailureResponse, X>> resolveResponse<T extends BaseResponse,X>(
    Future<T> Function() callRemoteDataSource) async {
  final NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());
  if (await networkInfo.isConnected) {
    try {
      final response = await callRemoteDataSource();
      print(response);
      return Right(response.toDomain());
    } catch (error) {
      return (Left(ErrorHandler.handle(error).failure));
    }
  } else {
    return Left(NoInternetConnectionErrorFailureResponse());
  }
}
