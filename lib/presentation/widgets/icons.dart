import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

Icon buildArrowIcon({Color? color, double? size}) => Icon(
      Icons.arrow_forward_ios,
      color: color ?? ColorManager.primaryColor7,
      size: size ?? 16,
    );

Icon buildCheckedInputIcon({Color? color, double? size}) {
  return Icon(Icons.check_circle_outline,
      size: size ?? 28, color: color ?? ColorManager.onPrimaryColor);
}

Icon buildUncheckedInputIcon({Color? color, double? size}) {
  return Icon(Icons.circle_outlined,
      size: size ?? 28, color: color ?? ColorManager.onPrimaryColor2);
}

Icon buildValidInputIcon({Color? color, double? size}) {
  return Icon(Icons.check_circle_rounded,
      size: size ?? 28, color: color ?? ColorManager.accentColor2);
}

Icon buildInvalidInputIcon({Color? color, double? size}) {
  return Icon(Icons.cancel_rounded,
      size: size ?? 28, color: color ?? ColorManager.errorColor);
}
