import 'package:letterboxd/data/network/error/failure_response.dart';

enum ErrorResponseType {
  BAD_REQUEST,
  FORBIDDEN,
  CONFLICT,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECTION_ERROR,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN
}

class ErrorResponseCode {
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int CONFLICT = 409;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  static const int UNKNOWN = -1;
  static const int CONNECTION_ERROR = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ErrorResponseMessage {
  static const String BAD_REQUEST = "bad request";
  static const String FORBIDDEN = "forbidden";
  static const String UNAUTHORISED = "unauthorized";
  static const String CONFLICT = "conflict";
  static const String NOT_FOUND = "not found";
  static const String INTERNAL_SERVER_ERROR = "internal server error";

  static const String UNKNOWN = "unknown error";
  static const String CONNECTION_ERROR = "connection error";
  static const String CANCEL = "cancelled";
  static const String RECEIVE_TIMEOUT = "receive timeout";
  static const String SEND_TIMEOUT = "send timeout";
  static const String CACHE_ERROR = "cache error";
  static const String NO_INTERNET_CONNECTION = "no internet connection";
}

extension ResponseTypeExtension on ErrorResponseType {
  FailureResponse getFailureResponse([String ? message]) {
    switch (this) {
      case ErrorResponseType.BAD_REQUEST:
        return BadRequestFailureResponse(message);
      case ErrorResponseType.FORBIDDEN:
        return ForbiddenFailureResponse(message);
      case ErrorResponseType.CONFLICT:
        return ConflictFailureResponse(message);
      case ErrorResponseType.UNAUTHORISED:
        return UnauthorizedFailureResponse(message);
      case ErrorResponseType.NOT_FOUND:
        return NotFoundFailureResponse(message);
      case ErrorResponseType.INTERNAL_SERVER_ERROR:
        return InternalServerErrorFailureResponse(message);
      case ErrorResponseType.NO_INTERNET_CONNECTION:
        return NoInternetConnectionErrorFailureResponse();
      case ErrorResponseType.CONNECTION_ERROR:
        return ConnectionErrorFailureResponse();
      case ErrorResponseType.CANCEL:
        return CancelFailureResponse();
      case ErrorResponseType.RECEIVE_TIMEOUT:
        return ReceiveTimeoutFailureResponse();
      case ErrorResponseType.SEND_TIMEOUT:
        return SendTimeoutFailureResponse();
      case ErrorResponseType.CACHE_ERROR:
        return CacheErrorFailureResponse();
      default:
        return DefaultFailureResponse();
    }
  }
}
