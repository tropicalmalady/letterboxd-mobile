import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

Widget buildTextFormFieldWithAnnexedElement(
    {required TextFormField textFormField,Widget ? child,double ? rightPadding}) {
  return Stack(alignment: Alignment.center, children: [
    textFormField,
    Padding(
      padding:EdgeInsets.only(right: rightPadding ?? 16),
      child: Align(alignment: Alignment.centerRight, child: child),
    )
  ]);
}

Widget buildRadioChecker(
    {required Widget child,
    bool isChecked = false,
    required Size size,
    required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Stack(alignment: Alignment.centerLeft, children: [
    SizedBox(width: size.width * 0.8, child: child),
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Align(
            alignment: Alignment.centerRight,
            child:IconButton(
                onPressed: onPressed,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                icon: isChecked
                    ? buildCheckedInputIcon()
                    : buildUncheckedInputIcon(),
              ),
            ),
      )
    ]),
  );
}
