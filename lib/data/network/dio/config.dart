import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/data/network/dio/interceptors/cancel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Dio getDio() {
    Dio dio = Dio();
    int _timeOut = 60 * 1000; // 1 min

    dio.options = BaseOptions(
      connectTimeout: Duration(minutes: _timeOut),
      receiveTimeout: Duration(minutes: _timeOut),
    );

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PreviousRequestInterceptor());
      // dio.interceptors.add(PrettyDioLogger(
      //     requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}