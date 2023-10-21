import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/views/app/search/cubit/cubit.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

Widget buildSearchRecentSearches() {
  return BlocBuilder<RecentSearchCubit,RecentSearchModelCappedStack>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const Center(
            child: Text("Recent Searches"),
          );
        } else {
          return buildRecentSearchesListTiles(
              title: "Recent Searches", items: state.items);
        }
      });
}

Widget buildRecentSearchesListTiles(
    {required String title,
    required Set<RecentSearchModel> items,
    bool isClickable = true}) {
  return Builder(builder: (context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(
                left: SpacingManager.md,
                bottom: SpacingManager.md,
                top: SpacingManager.xlg),
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            )),
        buildDividerWithLeftPadding(),
        ...items.map((item) => buildButtonWithDivider(
            annex: Chip(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              backgroundColor: ColorManager.primaryColor6,
              label: Text(
                item.searchType.getName(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    height: 0,
                    color: ColorManager.onPrimaryColor3,
                    fontWeight: FontWeightManager.bold),
              ),
            ),
            title: item.searchQuery,
            onPressed: () {
              if (item.searchType == SearchType.films) {
                context
                    .read<MovieDetailsBloc>()
                    .add(MovieDetailsRequested(item.id));
                Navigator.pushNamed(context, Routes.movieDetailsRoute);
              }
            }))
      ],
    );
  });
}
