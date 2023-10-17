import 'package:equatable/equatable.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:json_annotation/json_annotation.dart';

part "recent_search.g.dart";

@JsonSerializable()
class RecentSearchModel extends Equatable {
  final SearchType searchType;
  final String searchQuery;
  final int id;

  Map<String,dynamic> toJson()=>_$RecentSearchModelToJson(this);
  RecentSearchModel fromJson(Map<String,dynamic> json)=>_$RecentSearchModelFromJson(json);

  const RecentSearchModel(
      {required this.searchQuery, required this.searchType, required this.id});

  @override
  List<Object> get props => [searchType, searchQuery, id];
}
