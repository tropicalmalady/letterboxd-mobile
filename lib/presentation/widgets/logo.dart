import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/images.dart';

Widget buildHeadingLogo(BuildContext context, {required String text}) {
  return Column(
    children: [
      Image.asset(
        ImageManager.logoDots,
        width: 100,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 16,top:8),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget buildLetterboxdLogo({required double appWidth}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Center(
        child: Image.asset(
      ImageManager.letterboxdLogo,
      width: appWidth * 0.6,
    )),
  );
}
