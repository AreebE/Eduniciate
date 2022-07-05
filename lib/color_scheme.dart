import 'package:flutter/material.dart';

class CustomColorScheme {
  static const Color transparent = Color.fromARGB(0, 255, 255, 255);
  static const int darkPrimary = 0;
  static const int darkVariant = 1;
  static const int lightPrimary = 2;
  static const int lightVariant = 3;
  static const int lightSecondVariant = 4;
  static const int normalText = 5;
  static const int backgroundAndHighlightedNormalText = 6;
  static const int delete = 7;
  static const int change = 8;
  static const int links = 9;
  static const int suggestion = 10;

  final List<Color> _colors;

  CustomColorScheme(this._colors);

  Color getColor(int colorIndex) {
    return _colors.elementAt(colorIndex);
  }

  static Color createFromHex(String hexcode) {
    int red = _translateCodeUnit(hexcode.codeUnitAt(1)) * 16 +
        _translateCodeUnit(hexcode.codeUnitAt(2));
    int green = _translateCodeUnit(hexcode.codeUnitAt(3)) * 16 +
        _translateCodeUnit(hexcode.codeUnitAt(4));
    int blue = _translateCodeUnit(hexcode.codeUnitAt(5)) * 16 +
        _translateCodeUnit(hexcode.codeUnitAt(6));
    return Color.fromARGB(255, red, green, blue);
  }

  static int _translateCodeUnit(int codeUnit) {
    return (codeUnit < "A".codeUnitAt(0))
        ? codeUnit - "0".codeUnitAt(0)
        : codeUnit - "A".codeUnitAt(0) + 10;
  }
}
