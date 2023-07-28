import 'package:equatable/equatable.dart';
import 'package:letterboxd/domain/models/_models.dart';

class SearchState extends Equatable {
  final SearchContent content;
  final SearchStatus status;
  final SearchType type;
  final String query;
  final SearchStatus nextPageStatus;
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
            status: SearchStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: SearchStatus.initial,
            moviesPreview: MoviesPreviewModel.initial());

  SearchState.initialWithRecentSearches()
      : this(
            content: SearchContent.recentSearches,
            status: SearchStatus.initial,
            type: SearchType.films,
            query: "",
            nextPageStatus: SearchStatus.initial,
            moviesPreview: MoviesPreviewModel.initial());

  SearchState copyWith(
          {SearchContent? content,
          SearchStatus? status,
          SearchType? type,
          int? currentApiPage,
          String? query,
          SearchStatus? nextPageStatus,
          MoviesPreviewModel? moviesPreview}) =>
      SearchState(
          content: content ?? this.content,
          status: status ?? this.status,
          type: type ?? this.type,
          query: query ?? this.query,
          nextPageStatus: nextPageStatus ?? this.nextPageStatus,
          moviesPreview: moviesPreview ?? this.moviesPreview);

  SearchState setContent(SearchContent content) => copyWith(content: content);
  SearchState setStatus(SearchStatus status) => copyWith(
      status: status,
      content: status == SearchStatus.success
          ? SearchContent.searchSuggestions
          : status == SearchStatus.loading
              ? SearchContent.empty
              : SearchContent.categories);
  SearchState setNextPageStatus(SearchStatus nextPageStatus) =>
      copyWith(nextPageStatus: nextPageStatus);
  SearchState setType(SearchType type) => copyWith(type: type);
  SearchState setCurrentApiPage(int currentApiPage) =>
      copyWith(currentApiPage: currentApiPage);
  SearchState setQuery(String query) =>
      copyWith(query: query, moviesPreview: MoviesPreviewModel.initial());
  SearchState setMoviesPreviewResults(
          {required List<MoviePreviewModel> results,
          required int page,
          required int totalPages}) =>
      copyWith(
          moviesPreview: moviesPreview.copyWith(
              results: results, page: page, totalPages: totalPages));
  SearchState setMoviesPreviewWithAdditionalResults(
          {required List<MoviePreviewModel> newResults,
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

enum SearchStatus { initial, loading, error, success }

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
