// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentSearchModel _$RecentSearchModelFromJson(Map<String, dynamic> json) =>
    RecentSearchModel(
      searchQuery: json['searchQuery'] as String,
      searchType: $enumDecode(_$SearchTypeEnumMap, json['searchType']),
      id: json['id'] as int,
    );

Map<String, dynamic> _$RecentSearchModelToJson(RecentSearchModel instance) =>
    <String, dynamic>{
      'searchType': _$SearchTypeEnumMap[instance.searchType]!,
      'searchQuery': instance.searchQuery,
      'id': instance.id,
    };

const _$SearchTypeEnumMap = {
  SearchType.films: 'films',
  SearchType.reviews: 'reviews',
  SearchType.lists: 'lists',
  SearchType.castCrewOrStudio: 'castCrewOrStudio',
  SearchType.membersOrHqs: 'membersOrHqs',
  SearchType.stories: 'stories',
  SearchType.journals: 'journals',
  SearchType.podcastEpisodes: 'podcastEpisodes',
  SearchType.all: 'all',
};
