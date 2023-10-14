import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:letterboxd/data/network/error/constants.dart';
import 'package:letterboxd/data/network/error/failure_response.dart';



class ErrorHandler implements Exception {
  late FailureResponse failure;

  ErrorHandler.handle(dynamic error) {

    if (error is DioException) {
      print(error.stackTrace);
      failure = _handleError(error);
    }
    else {
      print(error);
      failure = DefaultFailureResponse();
    }

  }
}

  FailureResponse _handleError(DioException error) {
var message=error.response?.data["message"];
    switch (error.type) {
      case DioExceptionType.connectionError:
        return ErrorResponseType.CONNECTION_ERROR.getFailureResponse();
      case DioExceptionType.sendTimeout:
        return ErrorResponseType.SEND_TIMEOUT.getFailureResponse();
      case DioExceptionType.receiveTimeout:
        return ErrorResponseType.RECEIVE_TIMEOUT.getFailureResponse();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ErrorResponseCode.BAD_REQUEST:
            return ErrorResponseType.BAD_REQUEST.getFailureResponse(message);
          case ErrorResponseCode.CONFLICT:
            return ErrorResponseType.CONFLICT.getFailureResponse(message);
          case ErrorResponseCode.FORBIDDEN:
            return ErrorResponseType.FORBIDDEN.getFailureResponse(message);
          case ErrorResponseCode.UNAUTHORISED:
            return ErrorResponseType.UNAUTHORISED.getFailureResponse(message);
          case ErrorResponseCode.NOT_FOUND:
            return ErrorResponseType.NOT_FOUND.getFailureResponse(message);
          case ErrorResponseCode.INTERNAL_SERVER_ERROR:
            return ErrorResponseType.INTERNAL_SERVER_ERROR.getFailureResponse(message);
          default:
            return ErrorResponseType.UNKNOWN.getFailureResponse(message);
        }
      case DioExceptionType.cancel:
        return ErrorResponseType.CANCEL.getFailureResponse();
      default:
        return ErrorResponseType.UNKNOWN.getFailureResponse();
    }
  }
