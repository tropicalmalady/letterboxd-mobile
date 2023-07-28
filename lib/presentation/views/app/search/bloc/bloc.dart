import 'package:bloc/bloc.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/search_movies.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/event.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TmdbRepository _tmdbRepository;
  SearchBloc({tmdbRepository})
      : _tmdbRepository = tmdbRepository,
        super(SearchState.initial()) {
    on<SearchStatusChanged>(_onSearchStatusChanged);
    on<SearchContentChanged>(_onSearchContentChanged);
    on<SearchTypeChanged>(_onSearchTypeChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchMoviesPreviewFetched>(_onSearchMoviesPreviewFetched);
    on<SearchReset>(_onSearchReset);
    on<SearchResetWithRecentSearches>(_onSearchResetWithRecentSearches);
    on<SearchNextPageRequested>(_onSearchNextPageRequested);
  }

  void _onSearchMoviesPreviewFetched(
      SearchMoviesPreviewFetched event, Emitter<SearchState> emit) {
    emit(state.setMoviesPreviewResults(
        page: event.page,
        results: event.results,
        totalPages: event.totalPages));
  }

  void _onSearchStatusChanged(
      SearchStatusChanged event, Emitter<SearchState> emit) {
    emit(state.setStatus(event.status));
  }

  void _onSearchTypeChanged(
      SearchTypeChanged event, Emitter<SearchState> emit) {
    emit(state.setType(event.type));
  }

  void _onSearchContentChanged(
      SearchContentChanged event, Emitter<SearchState> emit) {
    emit(state.setContent(event.content));
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) {
    emit(state.setQuery(event.query));
  }

  void _onSearchReset(SearchReset event, Emitter<SearchState> emit) {
    emit(state.setSearchReset());
  }

  void _onSearchResetWithRecentSearches(
      SearchResetWithRecentSearches event, Emitter<SearchState> emit) {
    emit(state.setSearchResetWithRecentSearches());
  }

  Future<void> _onSearchNextPageRequested(
      SearchNextPageRequested event, Emitter<SearchState> emit) async {
    emit(state.setNextPageStatus(SearchStatus.loading));
    (await SearchMoviesUseCase(_tmdbRepository).execute(
            SearchMovieRequest(state.query, state.moviesPreview.page + 1)))
        .fold((l) {
      print("error occurred in _onSearchNextPageRequested $l");
      emit(state.setNextPageStatus(SearchStatus.initial));
    }, (r) {
      emit(state.setMoviesPreviewWithAdditionalResults(
          totalPages: r.totalPages, page: r.page, newResults: r.results));
      emit(state.setNextPageStatus(SearchStatus.success));
    });
    await Future.delayed(const Duration(milliseconds: 500),(){
      emit(state.setNextPageStatus(SearchStatus.initial));
    });
  }
}
