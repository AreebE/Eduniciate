// Areeb Emran
// Font standards

import 'package:flutter/cupertino.dart';
import 'package:edunciate/color_scheme.dart';

enum FontSize { finePrint, extraSmall, small, medium, large, title, heading }

extension SizeExtension on FontSize {
  double get pxSize {
    switch (this) {
      case FontSize.finePrint:
        return 8;
      case FontSize.extraSmall:
        return 10;
      case FontSize.small:
        return 14;
      case FontSize.medium:
        return 20;
      case FontSize.large:
        return 24;
      case FontSize.title:
        return 30;
      case FontSize.heading:
        return 40;
    }
  }
}

enum Style {
  norm,
  normUnderline,
  normHeader,
  brightNorm,
  darkNorm,
  darkNormUnderline,
  darkBold,
  darkVarNorm,
  darkVarBold,
  header,
  lightNorm,
  lightBold,
  lightVarNorm,
  lightVarBold,
  deleteText,
  title
}

extension StyleExtension on Style {
  TextDecoration get decoration {
    switch (this) {
      case Style.header:
      case Style.darkNormUnderline:
      case Style.normUnderline:
      case Style.normHeader:
        return TextDecoration.underline;
      default:
        return TextDecoration.none;
    }
  }

  FontStyle get style {
    switch (this) {
      default:
        return FontStyle.normal;
    }
  }

  FontWeight get weight {
    switch (this) {
      case Style.title:
      case Style.header:
      case Style.darkBold:
      case Style.darkVarBold:
      case Style.lightBold:
      case Style.lightVarBold:
      case Style.normHeader:
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  String get fontFamily {
    switch (this) {
      case Style.title:
      case Style.header:
      case Style.normHeader:
        return "Josefin Sans";
      default:
        return "Lato";
    }
  }

  int get color {
    switch (this) {
      case Style.norm:
      case Style.normUnderline:
      case Style.normHeader:
        return CustomColorScheme.normalText;
      case Style.brightNorm:
      case Style.title:
        return CustomColorScheme.backgroundAndHighlightedNormalText;
      case Style.header:
      case Style.darkNorm:
      case Style.darkBold:
      case Style.darkNormUnderline:
        return CustomColorScheme.darkPrimary;
      case Style.darkVarNorm:
      case Style.darkVarBold:
        return CustomColorScheme.darkVariant;
      case Style.lightNorm:
      case Style.lightBold:
        return CustomColorScheme.lightPrimary;
      case Style.lightVarNorm:
      case Style.lightVarBold:
        return CustomColorScheme.lightVariant;
      case Style.deleteText:
        return CustomColorScheme.delete;
    }
  }
}

class FontStandards {
  static TextStyle getTextStyle(
      CustomColorScheme colorScheme, Style style, FontSize size) {
    // print(style);
    return TextStyle(
        color: colorScheme.getColor(style.color),
        fontFamily: style.fontFamily,
        fontSize: size.pxSize,
        decoration: style.decoration,
        decorationColor: colorScheme.getColor(style.color),
        fontStyle: style.style,
        fontWeight: style.weight);
  }
}
