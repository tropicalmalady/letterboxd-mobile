import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

class ThemeManager {
  ThemeData get themeData => ThemeData(
      primaryColor: ColorManager.primaryColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorManager.primaryColor,
      bottomNavigationBarTheme: _bottomNavigationBarThemeData,
      textTheme: _textTheme,
      splashColor: Colors.transparent,
      bottomSheetTheme: _bottomSheetThemeData,
      inputDecorationTheme: _inputDecorationTheme,
      appBarTheme: _appBarTheme);

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: ColorManager.alternateColor4,
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        filled: true,
        fillColor: ColorManager.alternateColor,
        hintStyle:FontStyleManager.bodyLarge,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 0));
  }

  BottomSheetThemeData get _bottomSheetThemeData {
    return BottomSheetThemeData(
        backgroundColor: ColorManager.primaryColor,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))));
  }

  TextTheme get _textTheme {
    return TextTheme(
        titleLarge: FontStyleManager.titleLarge,
        titleMedium: FontStyleManager.titleMedium,
        titleSmall: FontStyleManager.titleSmall,
        labelLarge: FontStyleManager.labelLarge,
        labelMedium: FontStyleManager.labelMedium,
        labelSmall: FontStyleManager.labelSmall,
        bodyLarge: FontStyleManager.bodyLarge,
        bodyMedium: FontStyleManager.bodyMedium,
        bodySmall: FontStyleManager.bodySmall);
  }

  BottomNavigationBarThemeData get _bottomNavigationBarThemeData {
    return BottomNavigationBarThemeData(
        selectedItemColor: ColorManager.secondaryColor1,
        unselectedItemColor: ColorManager.onPrimaryColor,
        backgroundColor: ColorManager.primaryColor6);
  }
}