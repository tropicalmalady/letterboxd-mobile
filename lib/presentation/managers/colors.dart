import 'dart:ui';

abstract class ColorManager {
  static final Color primaryColor = _colorFromHex("#171b1f");
  static final Color primaryColor1 = _colorFromHex("#20262e");
  static final Color primaryColor2 = _colorFromHex("#202830");
  static final Color primaryColor3 = _colorFromHex("#223344");
  static final Color primaryColor4 = _colorFromHex("#2c3440");
  static final Color primaryColor5 = _colorFromHex("#445566");
  static final Color primaryColor6 = _colorFromHex("#556677");
  static final Color primaryColor7 = _colorFromHex("#667788");
  static final Color primaryColor8 = _colorFromHex("#778899");
  static final Color primaryColor9 = _colorFromHex("#8899aa");
  static final Color primaryColor10 = _colorFromHex("#99aabb");

  static final Color onPrimaryColor = _colorFromHex("#aabbcc");
  static final Color onPrimaryColor1 = _colorFromHex("#bbccdd");
  static final Color onPrimaryColor2 = _colorFromHex("#ccddee");
  static final Color onPrimaryColor3 = _colorFromHex("#ddeeff");
  static final Color onPrimaryColor4 = _colorFromHex("#e8f0fe");
  static final Color onPrimaryColor5 = _colorFromHex("#ffffff");

  static final Color secondaryColor = _colorFromHex("#0092ef");
  static final Color secondaryColor1 = _colorFromHex("#40bcf4");

  static final Color alternateColor = _colorFromHex("#333333");
  static final Color alternateColor1 = _colorFromHex("#949494");
  static final Color alternateColor2 = _colorFromHex("#c4ccd4");
  static final Color alternateColor3 = _colorFromHex("#c8d4e0");
  static final Color alternateColor4 = _colorFromHex("#000000");

  static final Color accentColor = _colorFromHex("#00b020");
  static final Color accentColor1 = _colorFromHex("#00c030");
  static final Color accentColor2 = _colorFromHex("#00e054");

  static Color errorColor = _colorFromHex("#ff8000");
}

Color _colorFromHex(String hexColorString) {
  hexColorString = hexColorString.replaceAll('#', '');
  if (hexColorString.length == 6) {
    hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
  }
  return Color(int.parse(hexColorString, radix: 16));
}
