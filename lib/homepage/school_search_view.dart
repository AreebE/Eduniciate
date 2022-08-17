import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/homepage/res/sizes.dart';
import 'package:edunciate/homepage/res/string_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SchoolDisplay extends StatefulWidget {
  final CustomColorScheme _colorScheme;
  const SchoolDisplay(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<SchoolDisplay> createState() => _SchoolDisplayState(_colorScheme);
}

class _SchoolDisplayState extends State<SchoolDisplay> {
  CustomColorScheme _colorScheme;

  List<String> schools = ["Beta", "Alpha", "Omega", "A", "V", "F", "G"];

  _SchoolDisplayState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringList.schoolNames,
          style: FontStandards.getTextStyle(
              _colorScheme, Style.darkBold, FontSize.title),
        ),
        Divider(
          thickness: Numbers.dividerThickness,
          height: Numbers.dividerHeight,
          color: _colorScheme.getColor(CustomColorScheme.darkPrimary),
        ),
        SizedBox(
          height: Numbers.schoolDisplayHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getSchools(),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _getSchools() {
    List<Widget> widgets = [];
    for (int i = 0; i < schools.length; i++) {
      bool useLightColor = i % 2 == 0;
      widgets.add(Container(
        height: Numbers.nameHeight,
        color: _colorScheme.getColor((useLightColor)
            ? CustomColorScheme.lightPrimary
            : CustomColorScheme.lightVariant),
        child: Text(
          schools.elementAt(i),
          maxLines: 2,
          textAlign: TextAlign.center,
          style: FontStandards.getTextStyle(
              _colorScheme,
              (useLightColor) ? Style.darkVarNorm : Style.darkNorm,
              FontSize.medium),
        ),
      ));
    }
    return widgets;
  }
}
