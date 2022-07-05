import 'package:flutter/cupertino.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';

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
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }
}
