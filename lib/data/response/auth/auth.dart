import 'package:json_annotation/json_annotation.dart';
import 'package:letterboxd/data/response/_base.dart';

part 'auth.g.dart';

@JsonSerializable()
class SignUpResponse implements BaseResponse<SignUpResponse> {
  @override
  int? status;
  String message;

  SignUpResponse(this.status, this.message);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  @override
  toDomain() => this;
}

@JsonSerializable()
class UsernameCheckResponse implements BaseResponse<UsernameCheckResponse> {
  @override
  int? status;
  bool message;

  UsernameCheckResponse(this.status, this.message);

  factory UsernameCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$UsernameCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameCheckResponseToJson(this);

  @override
  toDomain() => this;
}
