import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar_searchbar.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildPlayGround extends StatelessWidget {
  const BuildPlayGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: BuildFilmGridCollection());
  }
}

class BuildFilmGridCollection extends StatelessWidget {
  const BuildFilmGridCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_header(), _body(), _footer()],
    );
  }

  Widget _header() {
    return Builder(builder: (context) {
      return buildButtonWithTextChild(
          title: "Actor in 64 films".toUpperCase(),
          onPressed: () {},
          backgroundColor: ColorManager.primaryColor4,
          activeColor: ColorManager.primaryColor5,
          annex: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.remove_red_eye_sharp,
                color: ColorManager.secondaryColor1,
              ),
              const SizedBox(
                width: SpacingManager.sm,
              ),
              Text(
                "21%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorManager.secondaryColor1),
              )
            ],
          ));
    });
  }

  Widget _body() {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: SpacingManager.lg, horizontal: SpacingManager.md),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: SpacingManager.sm,
            crossAxisSpacing: SpacingManager.sm),
        itemCount: 10,
        itemBuilder: (context, index) => buildPosterImage(width: 100));
  }

  Widget _footer() {
    return buildButtonWithTextChild(
        annex: buildArrowIcon(), title: "All films as Actor", onPressed: () {});
  }
}

Widget buildUserDetailsAccordion(
    {String? posterPath, String? bio = "", Widget? child}) {
  return BuildAccordion(
    color: ColorManager.primaryColor4,
    firstChild: Padding(
      padding: const EdgeInsets.only(
          left: SpacingManager.md,
          right: SpacingManager.md,
          top: SpacingManager.xlg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPosterImage(width: 100, posterPath: posterPath),
          const SizedBox(
            width: SpacingManager.md,
          ),
          Expanded(
            child: Text(bio!),
          )
        ],
      ),
    ),
    offset: (100 / 0.67) + SpacingManager.xlg,
    secondChild: Column(
      children: [
        buildDivider(color: ColorManager.primaryColor5, thickness: 0.3),
        child ?? buildEmptyContainer
      ],
    ),
  );
}
