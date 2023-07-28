import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/color_manager.dart';

Widget checkedInputRadioWidget() {
  return Icon(Icons.check_circle_outline,
      size: 28, color: ColorManager.onPrimaryColor);
}

Widget uncheckedInputRadioWidget() {
  return Icon(Icons.circle_outlined,
      size: 28, color: ColorManager.onPrimaryColor2);
}

Widget validInputRadioWidget(){
  return Icon(Icons.check_circle_rounded,
      size: 28, color: ColorManager.accentColor2);
}

Widget invalidInputRadioWidget(){
  return Icon(Icons.cancel_rounded,
      size: 28, color: ColorManager.errorColor);
}