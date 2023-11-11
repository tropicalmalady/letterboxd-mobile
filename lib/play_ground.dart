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
    return Scaffold(
        appBar: AppBar(),
        body: BuildAccordionContainer(
          color: ColorManager.primaryColor4,
          firstChild: firstChild(),
          offset: (100 / 0.67) + SpacingManager.xlg,
          secondChild: Column(
            children: [
              buildDivider(color: ColorManager.primaryColor5, thickness: 0.3)
            ],
          ),
        ));
  }
}

Widget firstChild({String? posterPath, String? text = ""}) {
  return Padding(
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
          child: Text(text!),
        )
      ],
    ),
  );
}
