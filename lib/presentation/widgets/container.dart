import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

final buildEmptyContainer = Container();
const buildEmptySliverContainer = SliverToBoxAdapter();

Widget buildGradientContainer(
    {required Widget child, required List<double> stops, Color? color}) {
  color ??= ColorManager.primaryColor;
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [color, color.withOpacity(0.7), color.withOpacity(0)],
            stops: stops)),
    child: child,
  );
}
