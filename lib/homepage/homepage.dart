// ignore_for_file: unnecessary_import, implementation_imports, prefer_final_fields, no_logic_in_create_state, must_be_immutable

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/homepage/school_search_view.dart';
import 'package:edunciate/homepage/res/sizes.dart';
import 'package:edunciate/homepage/searchbar.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'class_view.dart';

class Homepage extends StatefulWidget {
  CustomColorScheme _customColors;

  Homepage(this._customColors, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState(_customColors);
}

class _HomepageState extends State<Homepage> {
  CustomColorScheme _colorScheme;

  _HomepageState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: Sizes.largeRowSpace,
        heightFactor: Sizes.largeColumnSpace,
        child: Container(
          alignment: Alignment.center,
          color: _colorScheme
              .getColor(CustomColorScheme.backgroundAndHighlightedNormalText),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: _getItem,
            itemCount: Numbers.numOfElements,
          ),
        ));
  }

  Widget _getItem(BuildContext context, int index) {
    // print(index);
    switch (index) {
      case 0:
        return SearchBar(_colorScheme);
      case 1:
      case 3:
        return const SizedBox(
          height: Numbers.mediumSpacer,
        );
      case 2:
        return FractionallySizedBox(
            widthFactor: Numbers.longRow,
            child: Container(
              height: Numbers.schoolViewHeight,
              alignment: Alignment.center,
              color: _colorScheme.getColor(CustomColorScheme.lightPrimary),
              child: SchoolDisplay(_colorScheme),
            ));
      case 4:
        return FractionallySizedBox(
            widthFactor: Numbers.longRow,
            child: Container(
              alignment: Alignment.center,
              height: Numbers.classViewHeight,
              color: _colorScheme.getColor(CustomColorScheme.lightPrimary),
              child: ClassDisplay(_colorScheme),
            ));
    }
    return Container();
  }
}
