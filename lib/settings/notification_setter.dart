import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

enum NotifStates {
  always,
  never;
}

class NotificationStatusSetterApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _item;
  NotificationStatusSetterApp(this._colorScheme, this._item, {Key? key})
      : super(key: key);

  @override
  State<NotificationStatusSetterApp> createState() =>
      _NotificationStatusSetterAppState(_colorScheme, _item);
}

class _NotificationStatusSetterAppState
    extends State<NotificationStatusSetterApp> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  _NotificationStatusSetterAppState(this._colorScheme, this._settingsItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: NotificationStatusSetter(_colorScheme, _settingsItem),
    ));
  }
}

class NotificationStatusSetter extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  NotificationStatusSetter(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<NotificationStatusSetter> createState() =>
      _NotificationStatusSetterState(_colorScheme, _settingsItem);
}

class _NotificationStatusSetterState extends State<NotificationStatusSetter> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  NotifStates _state = NotifStates.never;

  _NotificationStatusSetterState(this._colorScheme, this._settingsItem) {
    _state = _parseNotifStatus(_settingsItem.getNotifStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          Text(
            StringList.notificationTitle,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.normHeader, FontSize.heading),
          ),
          const FractionallySizedBox(
            widthFactor: 1,
          ),
          FractionallySizedBox(
              widthFactor: Sizes.smallRowSpace,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    (_state == NotifStates.always)
                        ? StringList.activated
                        : StringList.deactivated,
                    style: FontStandards.getTextStyle(
                        _colorScheme, Style.norm, FontSize.medium),
                  ),
                  // const SizedBox(
                  //   width: Sizes.smallSpacerWidth,
                  // ),
                  Switch(
                      activeColor:
                          _colorScheme.getColor(CustomColorScheme.darkPrimary),
                      activeTrackColor: _colorScheme
                          .getColor(CustomColorScheme.lightSecondVariant),
                      inactiveThumbColor:
                          _colorScheme.getColor(CustomColorScheme.normalText),
                      inactiveTrackColor:
                          _colorScheme.getColor(CustomColorScheme.gray),
                      value: _state == NotifStates.always,
                      onChanged: (isOn) {
                        if (isOn) {
                          changedNotificationStatus(NotifStates.always);
                        } else {
                          changedNotificationStatus(NotifStates.never);
                        }
                      })
                ],
              ))
        ]);
  }

  void changedNotificationStatus(NotifStates newState) {
    _state = newState;
    _settingsItem.changeNotifStatus(newState.name);
    setState(() {});
  }

  NotifStates _parseNotifStatus(String notifStatus) {
    switch (notifStatus) {
      case "always":
        return NotifStates.always;
      case "never":
      default:
        return NotifStates.never;
    }
  }
}
