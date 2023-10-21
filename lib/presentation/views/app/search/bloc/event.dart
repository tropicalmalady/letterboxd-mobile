import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';

abstract class SearchEvent extends Equatable {}

class SearchStatusChanged extends SearchEvent {
  final ApiStatus status;

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

class SearchMoviePreviewsPreviewFetched extends SearchEvent {
  final List<MoviesPreviewResultsModel> results;
  final int page;
  final int totalPages;

  SearchMoviePreviewsPreviewFetched(
      {required this.results, required this.page, required this.totalPages});
  @override
  List<Object> get props => [results, page, totalPages];
}

class SearchReset extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchNextPageRequested extends SearchEvent {
  @override
  List<Object?> get props => [];
}
