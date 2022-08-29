import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class NotificationStatusSetterApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  NotificationStatusSetterApp(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<NotificationStatusSetterApp> createState() =>
      _NotificationStatusSetterAppState(_colorScheme);
}

class _NotificationStatusSetterAppState
    extends State<NotificationStatusSetterApp> {
  CustomColorScheme _colorScheme;

  _NotificationStatusSetterAppState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: NotificationStatusSetter(_colorScheme),
    ));
  }
}

class NotificationStatusSetter extends StatefulWidget {
  CustomColorScheme _colorScheme;
  NotificationStatusSetter(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<NotificationStatusSetter> createState() =>
      _NotificationStatusSetterState(_colorScheme);
}

class _NotificationStatusSetterState extends State<NotificationStatusSetter> {
  CustomColorScheme _colorScheme;
  bool notificationsAreOn = true;

  _NotificationStatusSetterState(this._colorScheme);

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
                    (notificationsAreOn)
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
                      value: notificationsAreOn,
                      onChanged: changedNotificationStatus)
                ],
              ))
        ]);
  }

  void changedNotificationStatus(bool newVal) {
    notificationsAreOn = newVal;
    setState(() {});
  }
}
