import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/data/response/auth/auth.dart';
import 'package:letterboxd/domain/repository/auth.dart';
import 'package:letterboxd/domain/usecase/_base.dart';

class SignUpUseCase extends BaseUseCase<SignUpRequest, SignUpResponse> {
  final AuthRepository _repo;
  SignUpUseCase(this._repo);
  @override
  execute(SignUpRequest input) {
    return _repo.signUp(input);
  }
}
