import 'package:json_annotation/json_annotation.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/data/response/_base.dart';
import 'package:letterboxd/domain/models/tmdb/shared.dart';

part "shared.g.dart";

@JsonSerializable()
class DetailableIntResponse extends BaseResponseField<DetailableIntModel> {
  int? id;
  String? name;

  DetailableIntResponse(this.id, this.name);

  factory DetailableIntResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailableIntResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailableIntResponseToJson(this);

  @override
  toDomain() =>
      DetailableIntModel(id: id ?? Empty.integer, name: name ?? Empty.string);
}

@JsonSerializable()
class DetailableStringResponse
    extends BaseResponseField<DetailableStringModel> {
  String? id;
  String? name;

  DetailableStringResponse(this.id, this.name);

  factory DetailableStringResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailableStringResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailableStringResponseToJson(this);

  @override
  toDomain() =>
      DetailableStringModel(id: id ?? Empty.string, name: name ?? Empty.string);
}
