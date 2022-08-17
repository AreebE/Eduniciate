// Areeb Emran
// Color theme changer

// ignore_for_file: no_logic_in_create_state

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';

class ColorSetter extends StatefulWidget {
  final CustomColorScheme colorScheme;

  const ColorSetter(this.colorScheme, {Key? key}) : super(key: key);

  @override
  State<ColorSetter> createState() => _ColorSetterState(colorScheme);
}

class _ColorSetterState extends State<ColorSetter> {
  final CustomColorScheme colorScheme;

  _ColorSetterState(this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.colorSetter,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                colorScheme,
                Style.header,
                FontSize.heading,
              )),
        ),
        FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: Sizes.largeRowSpace,
          child: Column(
            children: getColors(),
          ),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }

  List<Widget> getColors() {
    List<Widget> widgets = [];
    for (int i = 0; i < CustomColorScheme.numOfColors; i++) {
      bool useDarkColor = i % 2 == 1;
      Color current = colorScheme.getColor(i);
      String name = CustomColorScheme.colorNames.elementAt(i);
      String hexcode = CustomColorScheme.getHexcode(current);
      Color background = colorScheme.getColor((useDarkColor)
          ? CustomColorScheme.lightVariant
          : CustomColorScheme.lightPrimary);
      Style fontStyle = (useDarkColor) ? Style.darkBold : Style.darkVarBold;
      widgets.add(Container(
        color: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: Sizes.colorNameWidth,
                height: Sizes.colorNameHeight,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: FontStandards.getTextStyle(
                        colorScheme, fontStyle, FontSize.large),
                  ),
                )),
            Material(
              color: CustomColorScheme.transparent,
              shape: const CircleBorder(
                  side: BorderSide(
                      color: CustomColorScheme.black,
                      width: Sizes.outerRadius - Sizes.innerRadius)),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => changeColor(i),
                  icon: Icon(
                    Icons.circle,
                    color: current,
                    size: Sizes.innerRadius,
                  )),
            ),
            SizedBox(
              width: Sizes.hexcodeWidth,
              child: Text(
                hexcode,
                style: FontStandards.getTextStyle(
                    colorScheme, fontStyle, FontSize.medium),
              ),
            ),
          ],
        ),
      ));
    }
    return widgets;
  }

  changeColor(int i) {}
}
