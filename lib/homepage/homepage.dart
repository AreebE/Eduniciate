import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/homepage/owner_class_view.dart';
import 'package:edunciate/homepage/res/sizes.dart';
import 'package:edunciate/homepage/searchbar.dart';
import 'package:edunciate/settings/res/sizes.dart';
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
    switch (index) {
      case Numbers.searchBar:
        return SearchBar(_colorScheme);
      case Numbers.ownerClass:
        return OwnerClassDisplay();
      case Numbers.normalClass:
        return ClassDisplay();
    }
    return Container();
  }
}
