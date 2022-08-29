// ignore_for_file: unused_import, unnecessary_import, implementation_imports, prefer_final_fields, must_be_immutable, no_logic_in_create_state

import 'dart:ui';

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/homepage/res/sizes.dart';
import 'package:edunciate/homepage/res/string_list.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            SizedBox(
                width: Numbers.searchTextWidth,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Numbers.searchMargin, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: StringList.searchHint,
                          hintStyle: FontStandards.getTextStyle(
                              _colorScheme, Style.lightNorm, FontSize.medium)),
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                      maxLines: 1,
                      style: FontStandards.getTextStyle(
                          _colorScheme, Style.darkVarNorm, FontSize.medium),
                      scrollPadding: EdgeInsets.zero,
                    ))),
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
