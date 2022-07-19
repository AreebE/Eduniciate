import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/homepage/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchBar extends StatefulWidget {
  CustomColorScheme _colorScheme;

  SearchBar(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState(_colorScheme);
}

class _SearchBarState extends State<SearchBar> {
  CustomColorScheme _colorScheme;
  _SearchBarState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: Numbers.longRow,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Numbers.smallMargin),
        height: Numbers.searchHeight,
        decoration: BoxDecoration(
            color: _colorScheme.getColor(CustomColorScheme.lightPrimary),
            borderRadius:
                const BorderRadius.all(Radius.circular(Numbers.searchRad)),
            border: Border.all(
                color: _colorScheme.getColor(CustomColorScheme.darkPrimary),
                width: Numbers.averageBorderThickness)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Search",
              style: FontStandards.getTextStyle(
                  _colorScheme, Style.darkVarNorm, FontSize.medium),
            ),
            Icon(
              Icons.search,
              color: _colorScheme.getColor(CustomColorScheme.darkPrimary),
              size: Numbers.searchIconSize,
            )
          ],
        ),
      ),
    );
  }
}
