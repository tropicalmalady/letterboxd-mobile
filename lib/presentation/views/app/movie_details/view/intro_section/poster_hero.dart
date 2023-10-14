import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/movie_details.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildPosterHeroPage extends StatelessWidget {
  final double _scrollOffset;
  final String? _posterPath;

  const BuildPosterHeroPage(
      {Key? key, required double scrollOffset, String? posterPath})
      : _scrollOffset = scrollOffset,
        _posterPath = posterPath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final buildImage = buildPosterImage(posterPath: _posterPath, width: 300);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            BuildMovieDetails(
                isHeroWidget: true, initialScrollOffset: _scrollOffset),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Center(
              child: Hero(
                  tag: "poster_image",
                  child: Draggable(
                    onDragEnd: (details) {
                      if (details.offset.dx <
                              (MediaQuery.of(context).size.width / 1.5) - 300 ||
                          details.offset.dx >
                              (MediaQuery.of(context).size.width / 3) ||
                          details.offset.dy <
                              (MediaQuery.of(context).size.height / 1.7) -
                                  (300 / 0.67) ||
                          details.offset.dy >
                              (MediaQuery.of(context).size.height / 2.8)) {
                        Navigator.pop(context);
                      }
                    },
                    feedback: buildImage,
                    childWhenDragging: buildEmptyContainer,
                    child: buildImage,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PosterHeroPageArguments {
  final double scrollOffset;
  final String? posterPath;

  PosterHeroPageArguments({required this.scrollOffset, this.posterPath});
}
