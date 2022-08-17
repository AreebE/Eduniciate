// Areeb Emran
// Terms of Service display

// ignore_for_file: no_logic_in_create_state

import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';

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
                Style.header,
                FontSize.heading,
              )),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        ),
        Container(
          decoration: BoxDecoration(
              color: colorScheme.getColor(CustomColorScheme.lightPrimary),
              border: Border.all(
                  width: Sizes.borderWidth,
                  color: colorScheme.getColor(CustomColorScheme.darkPrimary))),
          child: FractionallySizedBox(
            widthFactor: Sizes.largeRowSpace,
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Sizes.smallMargin),
                  child: Text(
                    StringList.permissionsEnabled,
                    style: FontStandards.getTextStyle(
                        colorScheme, Style.darkBold, FontSize.large),
                  ),
                ),
                getPermissionDisplay()
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }

  static const int _name = 0;
  static const int _link = 1;
  static const int _deny = 2;
  static const int _numOfElements = 3;

  Row getPermissionDisplay() {
    List<Widget> children = [];
    for (int i = 0; i < _numOfElements; i++) {
      children.add(getPermissionItem(i));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget getPermissionItem(int type) {
    List<Widget> children = [];
    for (int i = 0; i < enabledPermissions.length; i++) {
      bool useDarkerVersion = i % 2 == 0;
      Style fontStyle = (useDarkerVersion) ? Style.darkBold : Style.darkVarBold;
      Color background = colorScheme.getColor((useDarkerVersion)
          ? CustomColorScheme.lightVariant
          : CustomColorScheme.lightPrimary);
      Permission current = enabledPermissions.elementAt(i);
      Widget child = const Text("");
      switch (type) {
        case _name:
          child = Text(
            current.getName(),
            style: FontStandards.getTextStyle(
                colorScheme, fontStyle, FontSize.medium),
          );
          break;
        case _link:
          child = ElevatedButton(
              onPressed: () => openLink(current.getLink()),
              style: ElevatedButton.styleFrom(
                  primary: colorScheme.getColor(CustomColorScheme.change)),
              child: Text(
                StringList.moreInfo,
                style: FontStandards.getTextStyle(
                    colorScheme, Style.norm, FontSize.small),
              ));
          break;
        case _deny:
          child = ElevatedButton(
              onPressed: () => removePermission(current.getName()),
              style: ElevatedButton.styleFrom(
                  primary: colorScheme.getColor(CustomColorScheme.delete)),
              child: Text(
                StringList.deny,
                style: FontStandards.getTextStyle(
                    colorScheme, Style.brightNorm, FontSize.small),
              ));
          break;
      }
      children.add(Container(
          color: background,
          height: Sizes.permissionHeight,
          padding: const EdgeInsets.all(Sizes.smallMargin),
          child: child));
    }
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  void openLink(String link) {}

  void removePermission(String name) {}
}
