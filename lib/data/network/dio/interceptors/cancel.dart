import 'package:dio/dio.dart';

class PreviousRequestInterceptor extends Interceptor {
  CancelToken cancelToken = CancelToken();

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    cancelToken.cancel("Cancelled by new request");
    cancelToken = CancelToken();
    options.cancelToken = cancelToken;

    return super.onRequest(options, handler);
  }
}