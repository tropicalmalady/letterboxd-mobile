// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentSearchModelCappedStack _$RecentSearchModelCappedStackFromJson(
        Map<String, dynamic> json) =>
    RecentSearchModelCappedStack(
      json['capacity'] as int,
      (json['items'] as List<dynamic>)
          .map((e) => RecentSearchModel.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

Map<String, dynamic> _$RecentSearchModelCappedStackToJson(
        RecentSearchModelCappedStack instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'items': instance.items.toList(),
    };
