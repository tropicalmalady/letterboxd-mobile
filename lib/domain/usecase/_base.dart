import 'package:dartz/dartz.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<FailureResponse, Out>> execute(In input);
}
