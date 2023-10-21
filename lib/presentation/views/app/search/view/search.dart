import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/views/app/search/cubit/cubit.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar.dart';
import 'package:letterboxd/presentation/views/app/search/view/categories.dart';
import 'package:letterboxd/presentation/views/app/search/view/recent_searches.dart';
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
      body: BlocProvider(
        create: (context)=>RecentSearchCubit(),
        child: MultiBlocListener(
            listeners: [
              BlocListener<SearchBloc, SearchState>(
                  listener: (context, state) async {
                    final bloc = context.read<SearchBloc>();
                    bloc.add(SearchStatusChanged(ApiStatus.loading));
                    (await MoviesPreviewUseCase(context.read<TmdbRepository>())
                            .execute(MoviesPreviewRequest(
                                state.query, state.moviesPreview.page)))
                        .fold((l) => print("dd ${l.code}"), (r) {
                      bloc.add(SearchMoviePreviewsPreviewFetched(
                          page: r.page,
                          totalPages: r.totalPages,
                          results: r.results));
                      bloc.add(SearchStatusChanged(ApiStatus.success));
                    });
                  },
                  listenWhen: (prev, next) =>
                      (prev.query != next.query) && (next.query.isNotEmpty)),
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
                  return buildSearchRecentSearches();
                }
                if (state == SearchContent.categories) {
                  return const BuildSearchCategories();
                }
                return Container();
              },
            )),
      ),
    );
  }
}
