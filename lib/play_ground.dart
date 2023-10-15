import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar_searchbar.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildPlayGround extends StatelessWidget {
  const BuildPlayGround({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: BuildApp());
  }
}

class BuildApp extends StatefulWidget {
  const BuildApp({Key? key}) : super(key: key);

  @override
  State<BuildApp> createState() => _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          return buildFilmListCollection(
              title: "Similar Films",
              onPressed: () {},
              items: state.movieDetails.similar.results.fold({}, (acc, item) {
                acc[item.posterPath ?? ""] = () {};
                return acc;
              }));
        });
  }
}

Widget buildFilmListCollection(
    {required String title,
    required VoidCallback onPressed,
    required Map<String, VoidCallback> items}) {
  return Builder(builder: (context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: SpacingManager.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: SpacingManager.xlg,
                            left: SpacingManager.md,
                            right: SpacingManager.md),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall),
                            buildArrowIcon(size: 14)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100 / 0.7)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: SpacingManager.xlg),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: SpacingManager.md) ,
              child: Row(
                children: items.entries.map((item) => Padding(
                  padding:
                  const EdgeInsets.only(right: SpacingManager.md),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: item.value,
                    child: buildPosterImage(width: 100,posterPath: item.key),
                  ),
                )).toList(),
              ),
            ),
          ),
        )
      ],
    );
  });
}
