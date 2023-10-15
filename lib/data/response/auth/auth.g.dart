// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      json['status'] as int?,
      json['message'] as String,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

UsernameCheckResponse _$UsernameCheckResponseFromJson(
        Map<String, dynamic> json) =>
    UsernameCheckResponse(
      json['status'] as int?,
      json['message'] as bool,
    );

Map<String, dynamic> _$UsernameCheckResponseToJson(
        UsernameCheckResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
