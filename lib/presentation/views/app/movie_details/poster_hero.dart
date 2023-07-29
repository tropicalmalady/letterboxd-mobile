
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/views/app/movie_details/movie_details.dart';
import 'package:letterboxd/presentation/widgets/container.dart';
import 'package:letterboxd/presentation/widgets/image_poster.dart';


class BuildPosterHero extends StatelessWidget {
  final GlobalKey _widgetKey = GlobalKey();
  final double offset;

  final _buildImage = buildPosterImage(
      posterPath: "/wyUxfQCtcPxRzwJtFy0emtfkux8.jpg", width: 300);

  BuildPosterHero(this.offset, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            BuildMovieDetails(
                withPosterImage: false, initialScrollOffset: offset),
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
                    feedback: _buildImage,
                    childWhenDragging: buildEmptyContainer,
                    child: _buildImage,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Route createPosterHeroRoute(double offset) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BuildPosterHero(offset),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

