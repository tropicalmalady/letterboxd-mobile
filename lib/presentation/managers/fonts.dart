import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/colors.dart';

abstract class FontStyleManager {
  static final _baseTextStyle = TextStyle(
      fontWeight: FontWeightManager.regular,
      decoration: TextDecoration.none,
      textBaseline: TextBaseline.alphabetic,
      color: ColorManager.onPrimaryColor);

  static final TextStyle titleLarge = _baseTextStyle.copyWith(
      color: ColorManager.onPrimaryColor5,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSizeManager.s22,
      height: 1.27);

  static final TextStyle titleMedium = _baseTextStyle.copyWith(
      color: ColorManager.onPrimaryColor5,
      fontWeight: FontWeightManager.bold,
      fontSize: FontSizeManager.s20,
      height: 1.5);

  static final TextStyle titleSmall = _baseTextStyle.copyWith(
      color: ColorManager.onPrimaryColor5,
      fontWeight: FontWeightManager.semiBold,
      fontSize: FontSizeManager.s16,
      height: 1.43);

  static final TextStyle labelLarge = _baseTextStyle.copyWith(
      fontSize: FontSizeManager.s16,
      fontWeight: FontWeightManager.bold,
      letterSpacing: 0.1,
      height: 1.5);

  static final TextStyle labelMedium = _baseTextStyle.copyWith(
      fontSize: FontSizeManager.s14,
      fontWeight: FontWeightManager.bold,
      letterSpacing: 0.1,
      height: 1.33);

  static final TextStyle labelSmall = _baseTextStyle.copyWith(
      fontSize: FontSizeManager.s12, letterSpacing: 0.5, height: 1.43);

  static final TextStyle bodyLarge = _baseTextStyle.copyWith(
      fontSize: FontSizeManager.s16, letterSpacing: 0.16, height: 1.5);

  static final TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: FontSizeManager.s14,
    letterSpacing: 0.25,
    height: 1.33,
  );

  static final TextStyle bodySmall = _baseTextStyle.copyWith(
      fontWeight: FontWeightManager.light,
      fontSize: FontSizeManager.s12,
      letterSpacing: 0.4,
      height: 1.43);
}

abstract class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;
}

abstract class FontSizeManager {
  static const double s11 = 11.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
}


