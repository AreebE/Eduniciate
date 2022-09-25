// Areeb Emran
// Custom color schemes
import 'package:flutter/material.dart';

class CustomColorScheme {
  static const String _zeroChar = "0";
  static const String _aChar = "A";
  static const int _aNum = 10;

  static const String hashtag = "#";

  static CustomColorScheme defaultColors = CustomColorScheme([
    CustomColorScheme.createFromHex("#3A1B67"),
    CustomColorScheme.createFromHex("#5F379A"),
    CustomColorScheme.createFromHex("#EBDDFF"),
    CustomColorScheme.createFromHex("#D4B7FF"),
    CustomColorScheme.createFromHex("#9461E1"),
    CustomColorScheme.createFromHex("#000000"),
    CustomColorScheme.createFromHex("#FFFFFF"),
    CustomColorScheme.createFromHex("#B90000"),
    CustomColorScheme.createFromHex("#DDDDDD"),
    CustomColorScheme.createFromHex("#0244C5"),
    CustomColorScheme.createFromHex("#5F379A"),
  ]);

  static const List<String> colorNames = [
    "Primary Color",
    "Primary Variant",
    "Secondary Color",
    "Secondary Variant",
    "Tertiary Color",
    "Normal Text",
    "Main Background",
    "Delete",
    "Change",
    "Links"
  ];
  static const Color transparent = Color.fromARGB(0, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);

  static const int darkPrimary = 0;
  static const int darkVariant = 1;
  static const int lightPrimary = 2;
  static const int lightVariant = 3;
  static const int lightSecondVariant = 4;
  static const int normalText = 5;
  static const int backgroundAndHighlightedNormalText = 6;
  static const int delete = 7;
  static const int change = 8;
  static const int gray = 8;

  static const int links = 9;
  static const int numOfColors = 10;

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
    return (codeUnit < _aChar.codeUnitAt(0))
        ? codeUnit - _zeroChar.codeUnitAt(0)
        : codeUnit - _aChar.codeUnitAt(0) + 10;
  }

  static String getHexcode(Color color) {
    int red = color.red;
    int blue = color.blue;
    int green = color.green;
    // print(red.toString() + ", " + green.toString() + ", " + blue.toString());
    return hashtag +
        _translateNumber((red / 16).floor()) +
        _translateNumber(red % 16) +
        _translateNumber((green / 16).floor()) +
        _translateNumber(green % 16) +
        _translateNumber((blue / 16).floor()) +
        _translateNumber(blue % 16);
  }

  static String _translateNumber(int number) {
    // print(number.toString() + " == color");
    return ((number < _aNum)
        ? number.toString()
        : String.fromCharCode(_aChar.codeUnitAt(0) + number - _aNum));
  }
}
