import 'package:letterboxd/data/request/auth.dart';
import 'package:letterboxd/data/response/auth/auth.dart';
import 'package:letterboxd/domain/repository/auth.dart';
import 'package:letterboxd/domain/usecase/_base.dart';

class UsernameCheckUseCase
    extends BaseUseCase<UsernameCheckRequest, UsernameCheckResponse> {
  final AuthRepository _repo;
  UsernameCheckUseCase(this._repo);

  @override
  execute(UsernameCheckRequest input) {
    return _repo.usernameCheck(input);
  }
}
