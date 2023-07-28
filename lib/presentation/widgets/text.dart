import 'package:flutter/material.dart';

RichText artworkDescriptionTextWidget(BuildContext context,{required String text}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Artwork from ',
      style: Theme.of(context).textTheme.bodySmall,
      children: <TextSpan>[
        TextSpan(
          text:text ,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}