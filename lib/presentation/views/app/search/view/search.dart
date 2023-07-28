import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar.dart';
import 'package:letterboxd/presentation/views/app/search/view/categories.dart';
import 'package:letterboxd/presentation/views/app/search/view/suggestion.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/domain/usecase/search_movies.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/event.dart';

class BuildSearch extends StatelessWidget {
  const BuildSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      body: MultiBlocListener(
          listeners: [
            BlocListener<SearchBloc, SearchState>(
                listener: (context, state) async {
                  final bloc = context.read<SearchBloc>();
                  bloc.add(SearchStatusChanged(SearchStatus.loading));
                  (await SearchMoviesUseCase(context.read<TmdbRepository>())
                          .execute(SearchMovieRequest(
                              state.query, state.moviesPreview.page)))
                      .fold((l) => print("dd ${l.code}"), (r) {
                    bloc.add(SearchMoviesPreviewFetched(
                        page: r.page,
                        totalPages: r.totalPages,
                        results: r.results));
                    bloc.add(SearchStatusChanged(SearchStatus.success));
                  });
                },
                listenWhen: (prev, next) =>
                    (prev.query != next.query) && (next.query.isNotEmpty)),
            BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  context.read<SearchBloc>().add(SearchReset());
                },
                listenWhen: (prev, next) =>
                    (next.content != SearchContent.recentSearches) &&
                    (next.query.isEmpty)),
          ],
          child: BlocSelector<SearchBloc, SearchState, SearchContent>(
            selector: (state) => state.content,
            builder: (context, state) {
              if (state == SearchContent.searchSuggestions) {
                return context
                        .read<SearchBloc>()
                        .state
                        .moviesPreview
                        .results
                        .isEmpty
                    ? buildEmptySearchFilmSuggestions()
                    : const BuildSearchFilmSuggestions();
              }
              if (state == SearchContent.recentSearches) {
                return const Center(
                  child: Text("Recent Searches"),
                );
              }
              if (state == SearchContent.categories) {
                return const BuildSearchCategories();
              }
              return Container();
            },
          )),
    );
  }
}
