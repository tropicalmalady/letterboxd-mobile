import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

Widget buildGradientContainer(
    {required Widget child, required List<double> stops}) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              ColorManager.primaryColor,
              ColorManager.primaryColor.withOpacity(0.7),
              ColorManager.primaryColor.withOpacity(0)
            ],
            stops: stops)),
    child: child,
  );
}
