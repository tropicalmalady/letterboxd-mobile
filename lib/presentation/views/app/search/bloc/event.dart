import 'package:equatable/equatable.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';

class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStatusChanged extends SearchEvent {
  final SearchStatus status;

  SearchStatusChanged(this.status);
  @override
  List<Object> get props => [status];
}

class SearchContentChanged extends SearchEvent {
  final SearchContent content;
  SearchContentChanged(this.content);

  @override
  List<Object> get props => [content];
}

class SearchTypeChanged extends SearchEvent {
  final SearchType type;
  SearchTypeChanged(this.type);

  @override
  List<Object> get props => [type];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
  @override
  List<Object> get props => [query];
}

class SearchMoviesPreviewFetched extends SearchEvent {
  final List<MoviePreviewModel> results;
  final int page;
  final int totalPages;

  SearchMoviesPreviewFetched(
      {required this.results, required this.page, required this.totalPages});
  @override
  List<Object> get props => [results, page, totalPages];
}

class SearchReset extends SearchEvent {}

class SearchResetWithRecentSearches extends SearchEvent {}

class SearchNextPageRequested extends SearchEvent {}
