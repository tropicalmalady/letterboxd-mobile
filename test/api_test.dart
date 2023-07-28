import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:letterboxd/data/data_source/remote_data_source.dart';
import 'package:letterboxd/data/network/dio/config.dart';
import 'package:letterboxd/data/network/network_info.dart';
import 'package:letterboxd/data/network/service/app_service.dart';
import 'package:letterboxd/data/repository/auth.dart';
import 'package:letterboxd/data/request/auth.dart';

void main() async{
  AuthRepositoryImpl impl = AuthRepositoryImpl(
      RemoteDataSourceImpl(AppServiceClient(Dio())),
      NetworkInfoImpl(InternetConnectionChecker())
  );
await impl.signUp(SignUpRequest("jola", "jola@gmail.com", "underamaddeningsky"));
}
