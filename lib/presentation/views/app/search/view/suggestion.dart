import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/event.dart';

import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildSearchFilmSuggestions extends StatefulWidget {
  const BuildSearchFilmSuggestions({Key? key}) : super(key: key);

  @override
  State<BuildSearchFilmSuggestions> createState() =>
      _BuildSearchFilmSuggestionsState();
}

class _BuildSearchFilmSuggestionsState
    extends State<BuildSearchFilmSuggestions> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if ((_scrollController.position.pixels >
                _scrollController.position.maxScrollExtent) &&
            (context.read<SearchBloc>().state.moviesPreview.page <
                context.read<SearchBloc>().state.moviesPreview.totalPages) &&
            (context.read<SearchBloc>().state.nextPageStatus ==
                SearchStatus.initial)) {
          print("----reading");
          context.read<SearchBloc>().add(SearchNextPageRequested());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      print(state.nextPageStatus);
      bool nextPageLoading = state.nextPageStatus == SearchStatus.loading;
      int previewsLength = state.moviesPreview.results.length;
      return ListView.builder(
          controller: _scrollController,
          itemCount: nextPageLoading ? previewsLength + 1 : previewsLength,
          itemBuilder: (context, index) => (nextPageLoading &&
                  (index + 1 == previewsLength + 1))
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: SizeManager.horizontalPadding),
                  child: LoaderWidget(
                    withBackdrop: false,
                    fraction: 0.5,
                  ))
              : buildSearchFilmSuggestion(
                  title: state.moviesPreview.results[index].title,
                  originalTitle:
                      state.moviesPreview.results[index].originalTitle ==
                              state.moviesPreview.results[index].title
                          ? null
                          : state.moviesPreview.results[index].originalTitle,
                  releaseDate: state.moviesPreview.results[index].releaseDate,
                  posterPath: state.moviesPreview.results[index].posterPath));
    });
  }
}

Widget buildEmptySearchFilmSuggestions() {
  return const Center(
    child: Text("Not found"),
  );
}

Widget buildSearchFilmSuggestion(
    {required String title,
    String? posterPath,
    String? releaseDate,
    String? originalTitle,
    String? directorName}) {
  const lineHeight = 1.5;
  return Builder(builder: (context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: SizeManager.horizontalPadding * 2,
              bottom: SizeManager.horizontalPadding * 2,
              left: SizeManager.horizontalPadding),
          child: Row(
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(0.7),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                          width: 0.7, color: ColorManager.primaryColor7)),
                  child: SizedBox(
                    width: 50,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: posterPath != null
                          ? Image.network(
                              "https://image.tmdb.org/t/p/w200$posterPath",
                              fit: BoxFit.cover,
                              errorBuilder: (context, err, st) => Container(),
                            )
                          : null,
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SizeManager.horizontalPadding),
                child: RichText(
                  text: TextSpan(
                      text: title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 19, height: lineHeight),
                      children: [
                        TextSpan(
                            text: releaseDate != null ? " $releaseDate" : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(height: lineHeight)),
                        TextSpan(
                            text: originalTitle != null
                                ? ",'$originalTitle'"
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    height: lineHeight)),
                        TextSpan(
                            text: directorName != null ? ", directed by" : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(height: lineHeight)),
                        TextSpan(
                            text: directorName != null ? " $directorName" : "",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    height: lineHeight,
                                    fontWeight: FontWeightManager.bold))
                      ]),
                ),
              ))
            ],
          ),
        ),
        buildDividerWithLeftPadding()
      ],
    );
  });
}
