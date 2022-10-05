// Areeb Emran
// SettingsPage display

// ignore_for_file: no_logic_in_create_state

import 'package:edunciate/font_standards.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:edunciate/settings/notification_setter.dart';
import 'package:edunciate/settings/permissions.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:edunciate/settings/text_size_changer.dart';
import 'package:flutter/material.dart';
import 'package:edunciate/settings/work_hours.dart';
// import 'package:edunciate/settings/color_setter.dart';
import 'package:edunciate/settings/language.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/terms_of_service.dart';

import '../color_scheme.dart';

class SettingsPage extends StatefulWidget {
  final CustomColorScheme colorScheme;
  SettingsItem settingsItem;
  DisplayWidgetListener widgetListener;

  SettingsPage(this.widgetListener,
      {required this.settingsItem, required this.colorScheme, Key? key})
      : super(key: key);

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState(colorScheme, settingsItem, widgetListener);
}

class _SettingsPageState extends State<SettingsPage> {
  final CustomColorScheme colorScheme;
  SettingsItem _settingsItem;
  DisplayWidgetListener widgetListener;

  _SettingsPageState(this.colorScheme, this._settingsItem, this.widgetListener);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: Alignment.center,
        heightFactor: 1,
        child: Container(
            color: colorScheme
                .getColor(CustomColorScheme.backgroundAndHighlightedNormalText),
            padding: const EdgeInsets.all(Sizes.mediumMargin),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: buildListTile,
              itemCount: 8,
            )));
  }

  Widget buildListTile(BuildContext c, int position) {
    IconData leadingData = Icons.abc;
    String text = StringList.addMember;
    switch (position - 2) {
      case -2:
        return Text(
          StringList.settingsTitle,
          textAlign: TextAlign.center,
          style: FontStandards.getTextStyle(
              colorScheme, Style.normHeader, FontSize.heading),
        );
      case -1:
        return Divider(
          color: colorScheme.getColor(CustomColorScheme.gray),
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
        );

      case Sizes.languageTile:
        text = StringList.language;
        leadingData = Icons.translate;
        break;

      case Sizes.textSizeTile:
        text = StringList.textSizeTitle;
        leadingData = Icons.text_fields;
        break;

      case Sizes.workHoursTile:
        text = StringList.workHours;
        leadingData = Icons.timer;
        break;

      case Sizes.permissionsTile:
        text = StringList.permissionsTitle;
        leadingData = Icons.perm_camera_mic;
        break;

      case Sizes.notificationsTile:
        text = StringList.notificationTitle;
        leadingData = Icons.notification_add;
        break;

      case Sizes.termsOfServiceTile:
        text = StringList.termsOfService;
        leadingData = Icons.tab;
        break;
    }

    int backgroundColorID = (position - 2) % 2 == 0
        ? CustomColorScheme.backgroundAndHighlightedNormalText
        : CustomColorScheme.gray;

    return Container(
      padding: const EdgeInsets.all(Sizes.smallMargin),
      color: colorScheme.getColor(backgroundColorID),
      child: ListTile(
        selectedColor: colorScheme.getColor(CustomColorScheme.gray),
        focusColor: colorScheme.getColor(CustomColorScheme.gray),
        tileColor: colorScheme.getColor(CustomColorScheme.gray),
        selected: false,
        leading: Icon(
          leadingData,
          size: Sizes.iconSize,
          color: colorScheme.getColor(CustomColorScheme.darkPrimary),
        ),
        title: Text(text,
            style: FontStandards.getTextStyle(
                colorScheme, Style.norm, FontSize.medium)),
        onTap: () {
          openSection(position - 2);
        },
      ),
    );
  }

  void openSection(int type) {
    Widget section = SizedBox();
    switch (type) {
      case Sizes.languageTile:
        section = LanguageApp(colorScheme, _settingsItem);
        break;

      case Sizes.textSizeTile:
        section = TextSizeChangerApp(colorScheme, _settingsItem);
        break;

      case Sizes.workHoursTile:
        section = WorkHoursApp(colorScheme, _settingsItem);
        break;

      case Sizes.permissionsTile:
        section = PermissionsApp(colorScheme);
        break;

      case Sizes.notificationsTile:
        section = NotificationStatusSetterApp(colorScheme, _settingsItem);
        break;

      case Sizes.termsOfServiceTile:
        section = TermsOfServiceApp(colorScheme);
        break;
    }
    Navigator.of(widgetListener.getContext())
        .push(MaterialPageRoute(builder: (context) {
      return section;
    }));
  }
}
