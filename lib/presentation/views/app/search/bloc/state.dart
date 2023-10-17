import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchState extends Equatable {
  final SearchContent content;
  final ApiStatus status;
  final SearchType type;
  final String query;
  final ApiStatus nextPageStatus;
  final MoviesPreviewModel moviesPreview;
  final CappedStack<RecentSearchModel> recentSearches;



  const SearchState(
      {required this.content,
      required this.status,
      required this.type,
      required this.query,
      required this.nextPageStatus,
      required this.moviesPreview,
      required this.recentSearches});

  SearchState.initial()
      : this(
            content: SearchContent.categories,
            status: ApiStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: ApiStatus.initial,
            moviesPreview: const MoviesPreviewModel.initial(),
            recentSearches: CappedStack(40));

  const SearchState.initialWithRecentSearches(
      {required CappedStack<RecentSearchModel> recentSearches})
      : this(
            content: SearchContent.recentSearches,
            status: ApiStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: ApiStatus.initial,
            moviesPreview: const MoviesPreviewModel.initial(),
            recentSearches: recentSearches);

  SearchState copyWith(
          {SearchContent? content,
          ApiStatus? status,
          SearchType? type,
          int? currentApiPage,
          String? query,
          ApiStatus? nextPageStatus,
          MoviesPreviewModel? moviesPreview,
          CappedStack<RecentSearchModel>? recentSearches}) =>
      SearchState(
          content: content ?? this.content,
          status: status ?? this.status,
          type: type ?? this.type,
          query: query ?? this.query,
          nextPageStatus: nextPageStatus ?? this.nextPageStatus,
          moviesPreview: moviesPreview ?? this.moviesPreview,
          recentSearches: recentSearches ?? this.recentSearches);

  SearchState setContent(SearchContent content) => copyWith(content: content);
  SearchState setStatus(ApiStatus status) => copyWith(
      status: status,
      content: status == ApiStatus.success
          ? SearchContent.searchSuggestions
          : status == ApiStatus.loading
              ? SearchContent.empty
              : SearchContent.categories);
  SearchState setNextPageStatus(ApiStatus nextPageStatus) =>
      copyWith(nextPageStatus: nextPageStatus);
  SearchState setType(SearchType type) => copyWith(type: type);
  SearchState setCurrentApiPage(int currentApiPage) =>
      copyWith(currentApiPage: currentApiPage);
  SearchState setQuery(String query) =>
      copyWith(query: query, moviesPreview: const MoviesPreviewModel.initial());
  SearchState setMoviesPreviewResults(
          {required List<MoviesPreviewResultsModel> results,
          required int page,
          required int totalPages}) =>
      copyWith(
          moviesPreview: moviesPreview.copyWith(
              results: results, page: page, totalPages: totalPages));
  SearchState setMoviesPreviewWithAdditionalResults(
          {required List<MoviesPreviewResultsModel> newResults,
          required int page,
          required int totalPages}) =>
      copyWith(
          moviesPreview: moviesPreview.copyWith(results: [
        ...moviesPreview.results,
        ...newResults,
      ], page: page, totalPages: totalPages));
  SearchState setIncrementMoviesPreviewPage() => copyWith(
      moviesPreview: moviesPreview.copyWith(page: moviesPreview.page + 1));
  SearchState setSearchReset() => SearchState.initial();
  SearchState setSearchResetWithRecentSearches() =>
      SearchState.initialWithRecentSearches(recentSearches: recentSearches);
  SearchState setAddRecentSearch(RecentSearchModel search) =>
      copyWith(recentSearches: recentSearches.add(search));

  @override
  List<Object> get props =>
      [content, status, type, moviesPreview, query, nextPageStatus,recentSearches];
}

enum SearchContent { categories, recentSearches, searchSuggestions, empty }

enum SearchType {
  films,
  reviews,
  lists,
  castCrewOrStudio,
  membersOrHqs,
  stories,
  journals,
  podcastEpisodes,
  all
}

extension SearchTypeExtension on SearchType {
  String getName() {
    switch (this) {
      case SearchType.films:
        return "Films";
      case SearchType.reviews:
        return "Reviews";
      case SearchType.lists:
        return "Lists";
      case SearchType.castCrewOrStudio:
        return "Cast, Crew or Studio";
      default:
        return "All";
    }
  }
}

class CappedStack<T> {
  Set<T> _items = {};

  Set<T> get element => _items;
  final int capacity;

  CappedStack(this.capacity);

  CappedStack<T> add(T item) {
    _items = {item, ..._items}.take(capacity).toSet();
    return this;
  }
  bool get isEmpty=>_items.isEmpty;

  @override
  String toString() {
    return _items.toString();
  }
}
