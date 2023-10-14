import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/domain/models/_models.dart';

class SearchState extends Equatable {
  final SearchContent content;
  final ApiStatus status;
  final SearchType type;
  final String query;
  final ApiStatus nextPageStatus;
  final MoviesPreviewModel moviesPreview;

  const SearchState(
      {required this.content,
      required this.status,
      required this.type,
      required this.query,
      required this.nextPageStatus,
      required this.moviesPreview});

  SearchState.initial()
      : this(
            content: SearchContent.categories,
            status: ApiStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: ApiStatus.initial,
            moviesPreview: MoviesPreviewModel.initial());

  SearchState.initialWithRecentSearches()
      : this(
            content: SearchContent.recentSearches,
            status: ApiStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: ApiStatus.initial,
            moviesPreview: MoviesPreviewModel.initial());

  SearchState copyWith(
          {SearchContent? content,
          ApiStatus? status,
          SearchType? type,
          int? currentApiPage,
          String? query,
          ApiStatus? nextPageStatus,
          MoviesPreviewModel? moviesPreview}) =>
      SearchState(
          content: content ?? this.content,
          status: status ?? this.status,
          type: type ?? this.type,
          query: query ?? this.query,
          nextPageStatus: nextPageStatus ?? this.nextPageStatus,
          moviesPreview: moviesPreview ?? this.moviesPreview);

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
      copyWith(query: query, moviesPreview: MoviesPreviewModel.initial());
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
  SearchState setMoviesPreviewPageIncrementally() => copyWith(
      moviesPreview: moviesPreview.copyWith(page: moviesPreview.page + 1));
  SearchState setSearchReset() => SearchState.initial();
  SearchState setSearchResetWithRecentSearches() =>
      SearchState.initialWithRecentSearches();

  @override
  List<Object> get props =>
      [content, status, type, moviesPreview, query, nextPageStatus];
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
