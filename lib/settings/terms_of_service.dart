// Areeb Emran
// Terms of Service display

import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';

class TermsOfServiceApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  TermsOfServiceApp(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<TermsOfServiceApp> createState() =>
      _TermsOfServiceAppState(_colorScheme);
}

class _TermsOfServiceAppState extends State<TermsOfServiceApp> {
  CustomColorScheme _colorScheme;

  _TermsOfServiceAppState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: TermsOfService(_colorScheme),
    ));
  }
}

class TermsOfService extends StatefulWidget {
  final CustomColorScheme colorScheme;

  const TermsOfService(this.colorScheme, {Key? key}) : super(key: key);

  @override
  State<TermsOfService> createState() => _TermsOfServiceState(colorScheme);
}

class _TermsOfServiceState extends State<TermsOfService> {
  final CustomColorScheme colorScheme;

  List<Permission> enabledPermissions = [
    Permission("Camera", "supposed_camera_link", true),
    Permission("Notifications", "notification_link", true),
  ];
  _TermsOfServiceState(this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.termsOfService,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                colorScheme,
                Style.normHeader,
                FontSize.heading,
              )),
        ),
        const FractionallySizedBox(
          widthFactor: 1,
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        ),
        FractionallySizedBox(
          widthFactor: Sizes.largeRowSpace,
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Sizes.smallMargin),
                child: Text(
                  StringList.currentTermsOfService,
                  style: FontStandards.getTextStyle(
                      colorScheme, Style.norm, FontSize.medium),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }
}
