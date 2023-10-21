import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:letterboxd/domain/models/recent_search.dart';
import 'package:json_annotation/json_annotation.dart';

part "cubit.g.dart";

class RecentSearchCubit extends HydratedCubit<RecentSearchModelCappedStack> {
  RecentSearchCubit() : super(RecentSearchModelCappedStack(40, {}));

  void addRecentSearch(RecentSearchModel recentSearch) =>
      emit(state.add(recentSearch));

  @override
  RecentSearchModelCappedStack? fromJson(Map<String, dynamic> json) =>
      state.fromJson(json);

  @override
  Map<String, dynamic>? toJson(RecentSearchModelCappedStack state) =>
      state.toJson(state);
}

@JsonSerializable()
class RecentSearchModelCappedStack {
  final int capacity;
  Set<RecentSearchModel> items;

  RecentSearchModelCappedStack(this.capacity, this.items);

  RecentSearchModelCappedStack add(RecentSearchModel item) {
    items = {item, ...items}.take(capacity).toSet();
    return this;
  }

  RecentSearchModelCappedStack fromJson(Map<String, dynamic> json) =>
      _$RecentSearchModelCappedStackFromJson(json);

  Map<String, dynamic> toJson(RecentSearchModelCappedStack state) =>
      _$RecentSearchModelCappedStackToJson(state);
}
