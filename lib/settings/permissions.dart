import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'items/permission.dart';
import 'res/sizes.dart';

//  eee
class PermissionsApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  PermissionsApp(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<PermissionsApp> createState() => _PermissionsAppState(_colorScheme);
}

class _PermissionsAppState extends State<PermissionsApp> {
  CustomColorScheme _colorScheme;

  _PermissionsAppState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Permissions(_colorScheme),
    ));
  }
}

class Permissions extends StatefulWidget {
  CustomColorScheme _colorScheme;
  Permissions(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<Permissions> createState() => _PermissionsState(_colorScheme);
}

class _PermissionsState extends State<Permissions> {
  CustomColorScheme _colorScheme;
  static const int _name = 0;
  static const int _link = 1;
  static const int _deny = 2;
  static const int _numOfElements = 3;

  _PermissionsState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = getPermissionDisplay();
    children.insert(
        0,
        Padding(
          padding: const EdgeInsets.all(Sizes.smallMargin),
          child: Text(
            StringList.permissionsEnabled,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.normUnderline, FontSize.large),
          ),
        ));
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FractionallySizedBox(
            widthFactor: 1,
          ),
          Text(
            StringList.permissionsTitle,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.normHeader, FontSize.heading),
          ),
          FractionallySizedBox(
            widthFactor: Sizes.largeRowSpace,
            alignment: Alignment.center,
            child: Column(children: children),
          ),
        ]);
  }

  List<Permission> enabledPermissions = [
    Permission("Camera", "supposed_camera_link", true),
    Permission("Notifications", "notification_link", true),
  ];

  List<Widget> getPermissionDisplay() {
    List<Widget> children = [];
    for (int i = 0; i < enabledPermissions.length; i++) {
      children.add(getPermissionItem(i));
    }
    return children;
  }

  Widget getPermissionItem(int position) {
    List<Widget> children = [];
    for (int i = 0; i < _numOfElements; i++) {
      bool useDarkerVersion = i % 2 == 0;
      Style fontStyle = Style.norm;

      Permission current = enabledPermissions.elementAt(position);
      Widget child = const Text("");
      switch (i) {
        case _name:
          child = Text(
            current.getName(),
            style: FontStandards.getTextStyle(
                _colorScheme, fontStyle, FontSize.medium),
          );
          break;
        case _link:
          child = ElevatedButton(
              onPressed: () => openLink(current.getLink()),
              style: ElevatedButton.styleFrom(
                  primary:
                      _colorScheme.getColor(CustomColorScheme.darkPrimary)),
              child: Text(
                StringList.moreInfo,
                style: FontStandards.getTextStyle(
                    _colorScheme, Style.brightNorm, FontSize.small),
              ));
          break;
        case _deny:
          child = ElevatedButton(
              onPressed: () => removePermission(current.getName()),
              style: ElevatedButton.styleFrom(
                  primary: _colorScheme.getColor(CustomColorScheme.delete)),
              child: Text(
                StringList.deny,
                style: FontStandards.getTextStyle(
                    _colorScheme, Style.brightNorm, FontSize.small),
              ));
          break;
      }
      children.add(Container(
          // color: background,
          padding: const EdgeInsets.all(Sizes.smallMargin),
          child: child));
    }
    Color background = _colorScheme.getColor((position % 2 == 1)
        ? CustomColorScheme.gray
        : CustomColorScheme.backgroundAndHighlightedNormalText);
    return Container(
        color: background,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: children));
  }

  void openLink(String link) {}

  void removePermission(String name) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                backgroundColor: _colorScheme.getColor(
                    CustomColorScheme.backgroundAndHighlightedNormalText),
                contentPadding: const EdgeInsets.all(Sizes.mediumMargin),
                content: FractionallySizedBox(
                  widthFactor: Sizes.rowSpace,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        StringList.askIfTheyWantToDelete,
                        style: FontStandards.getTextStyle(
                            _colorScheme, Style.deleteText, FontSize.medium),
                      ),
                      const SizedBox(
                        height: Sizes.mediumMargin,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () => changePermission(false),
                              style: ElevatedButton.styleFrom(
                                  primary: _colorScheme
                                      .getColor(CustomColorScheme.darkPrimary)),
                              child: Text(
                                StringList.no,
                                style: FontStandards.getTextStyle(_colorScheme,
                                    Style.brightNorm, FontSize.large),
                              )),
                          ElevatedButton(
                              onPressed: () => changePermission(true),
                              style: ElevatedButton.styleFrom(
                                  primary: _colorScheme
                                      .getColor(CustomColorScheme.delete)),
                              child: Text(
                                StringList.yes,
                                style: FontStandards.getTextStyle(_colorScheme,
                                    Style.brightNorm, FontSize.large),
                              ))
                        ],
                      )
                    ],
                  ),
                ))));
  }

  void changePermission(bool willBeDisabled) {}
}
