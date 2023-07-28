import 'package:letterboxd/data/network/error/constants.dart';

class FailureResponse {
  int code;
  String message;
  FailureResponse(this.code, this.message);
}

class DefaultFailureResponse extends FailureResponse {
  DefaultFailureResponse([String? message])
      : super(
            ErrorResponseCode.UNKNOWN, message ?? ErrorResponseMessage.UNKNOWN);
}

class BadRequestFailureResponse extends FailureResponse {
  BadRequestFailureResponse([String? message])
      : super(ErrorResponseCode.BAD_REQUEST,
            message ?? ErrorResponseMessage.BAD_REQUEST);
}

class ForbiddenFailureResponse extends FailureResponse {
  ForbiddenFailureResponse([String? message])
      : super(ErrorResponseCode.FORBIDDEN,
            message ?? ErrorResponseMessage.FORBIDDEN);
}

class ConflictFailureResponse extends FailureResponse {
  ConflictFailureResponse([String? message])
      : super(ErrorResponseCode.CONFLICT,
            message ?? ErrorResponseMessage.CONFLICT);
}

class UnauthorizedFailureResponse extends FailureResponse {
  UnauthorizedFailureResponse([String? message])
      : super(ErrorResponseCode.UNAUTHORISED,
            message ?? ErrorResponseMessage.UNAUTHORISED);
}

class NotFoundFailureResponse extends FailureResponse {
  NotFoundFailureResponse([String? message])
      : super(ErrorResponseCode.NOT_FOUND,
            message ?? ErrorResponseMessage.NOT_FOUND);
}

class InternalServerErrorFailureResponse extends FailureResponse {
  InternalServerErrorFailureResponse([String? message])
      : super(ErrorResponseCode.INTERNAL_SERVER_ERROR,
            message ?? ErrorResponseMessage.INTERNAL_SERVER_ERROR);
}

class NoInternetConnectionErrorFailureResponse extends FailureResponse {
  NoInternetConnectionErrorFailureResponse([String? message])
      : super(ErrorResponseCode.NO_INTERNET_CONNECTION,
            message ?? ErrorResponseMessage.NO_INTERNET_CONNECTION);
}

class ConnectionErrorFailureResponse extends FailureResponse {
  ConnectionErrorFailureResponse([String? message])
      : super(ErrorResponseCode.CONNECTION_ERROR,
            message ?? ErrorResponseMessage.CONNECTION_ERROR);
}

class CancelFailureResponse extends FailureResponse {
  CancelFailureResponse([String? message])
      : super(ErrorResponseCode.CANCEL, message ?? ErrorResponseMessage.CANCEL);
}

class ReceiveTimeoutFailureResponse extends FailureResponse {
  ReceiveTimeoutFailureResponse([String? message])
      : super(ErrorResponseCode.RECEIVE_TIMEOUT,
            message ?? ErrorResponseMessage.RECEIVE_TIMEOUT);
}

class SendTimeoutFailureResponse extends FailureResponse {
  SendTimeoutFailureResponse([String? message])
      : super(ErrorResponseCode.SEND_TIMEOUT,
            message ?? ErrorResponseMessage.SEND_TIMEOUT);
}

class CacheErrorFailureResponse extends FailureResponse {
  CacheErrorFailureResponse([String? message])
      : super(ErrorResponseCode.CACHE_ERROR,
            message ?? ErrorResponseMessage.CACHE_ERROR);
}
