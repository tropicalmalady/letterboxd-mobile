import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/managers.dart';


class ThemeManager {
  static ThemeData getAppTheme() => ThemeData(
        primaryColor: ColorManager.primaryColor,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorManager.primaryColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: ColorManager.secondaryColor1,
            unselectedItemColor: ColorManager.onPrimaryColor,
            backgroundColor: ColorManager.primaryColor6),
        textTheme: TextTheme(
          labelMedium: _getTextStyle(fontSize: FontSizeManager.s14),
            headlineLarge: _getTextStyle(
                fontSize: FontSizeManager.s20,
                weight: FontWeightManager.bold,
                color: ColorManager.onPrimaryColor5),
            bodyMedium: _getTextStyle(),
            bodySmall: _getTextStyle(fontSize: FontSizeManager.s12)),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ColorManager.primaryColor,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)))),
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            fillColor: ColorManager.alternateColor,
            hintStyle: _getTextStyle(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 0)),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.alternateColor4,

    )
      );
}

TextStyle _getTextStyle(
        {Color? color,
        double? fontSize,
        String? fontFamily,
        FontWeight? weight}) =>
    TextStyle(
        color: color ?? ColorManager.onPrimaryColor,
        fontSize: fontSize ?? FontSizeManager.s16,
        fontFamily: "" ?? fontFamily,
        fontWeight: weight ?? FontWeightManager.regular);
