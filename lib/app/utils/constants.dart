abstract class ApiEndpoints {
  static const String baseUrl = "http://172.20.10.3:8001/";
  static const String signUp = "auth/signUp";
  static const String usernameCheck = "auth/usernameCheck/{username}";
}

enum ApiStatus { initial, loading, error, success }

class ApiStatusHelper {
  final ApiStatus _status;
  bool get isLoading => _status == ApiStatus.loading;
  bool get isError => _status == ApiStatus.error;
  bool get isSuccess => _status == ApiStatus.success;
  bool get isInitial => _status == ApiStatus.initial;
  const ApiStatusHelper(this._status);
}

abstract class Empty {
  static const int integer = -1;
  static const String string = "";
  static const List array = [];
}
