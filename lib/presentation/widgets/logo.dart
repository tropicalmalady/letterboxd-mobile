import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/image_manager.dart';

Widget headingLogoWidget(BuildContext context, {required String text}) {
  return Column(
    children: [
      Image.asset(
        ImageManager.logoDots,
        width: 100,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget letterboxdLogoWidget({required double appWidth}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Center(
        child: Image.asset(
      ImageManager.letterboxdLogo,
      width: appWidth * 0.6,
    )),
  );
}
