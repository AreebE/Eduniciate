import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/personal_profile/profile_page.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextSizeChangerApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  TextSizeChangerApp(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<TextSizeChangerApp> createState() =>
      _TextSizeChangerAppState(_colorScheme, this._settingsItem);
}

class _TextSizeChangerAppState extends State<TextSizeChangerApp> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  _TextSizeChangerAppState(this._colorScheme, this._settingsItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: buildAppBar(context),
      body: TextSizeChanger(_colorScheme, _settingsItem),
    ));
  }
}

class TextSizeChanger extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  TextSizeChanger(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<TextSizeChanger> createState() =>
      _TextSizeChangerState(_colorScheme, _settingsItem);
}

class _TextSizeChangerState extends State<TextSizeChanger> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;
  int currentFontSize = 12;

  _TextSizeChangerState(this._colorScheme, this._settingsItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        Text(
          StringList.textSizeTitle,
          style: FontStandards.getTextStyle(
              _colorScheme, Style.normHeader, FontSize.heading),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              StringList.currentColon,
              style: FontStandards.getTextStyle(
                  _colorScheme, Style.norm, FontSize.medium),
            ),
            const SizedBox(
              width: Sizes.smallSpacerWidth,
            ),
            DropdownButton<int>(
              items: <int>[12, 14, 16, 18].map<DropdownMenuItem<int>>((int i) {
                return DropdownMenuItem<int>(
                  value: i,
                  child: Text(
                    i.toString(),
                    style: FontStandards.getTextStyle(
                        _colorScheme, Style.norm, FontSize.small),
                  ),
                );
              }).toList(),
              onChanged: changedSize,
              value: currentFontSize,
            )
          ],
        )
      ],
    );
  }

  void changedSize(int? newValue) {
    currentFontSize = int.parse(newValue.toString());
    _settingsItem.changeTextSize(newValue!);
    setState(() {});
  }
}
