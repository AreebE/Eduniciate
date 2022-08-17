// Areeb Emran
// Settings display

import 'package:flutter/material.dart';
import 'package:edunciate/settings/work_hours.dart';
import 'package:edunciate/settings/color_setter.dart';
import 'package:edunciate/settings/family_contacts.dart';
import 'package:edunciate/settings/language.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/terms_of_service.dart';
import 'package:edunciate/settings/calendar.dart';

import '../color_scheme.dart';

class Settings extends StatefulWidget {
  final CustomColorScheme colorScheme;
  const Settings({required this.colorScheme, Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState(colorScheme);
}

class _SettingsState extends State<Settings> {
  final CustomColorScheme colorScheme;
  _SettingsState(this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme
          .getColor(CustomColorScheme.backgroundAndHighlightedNormalText),
      padding: const EdgeInsets.all(Sizes.mediumMargin),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // print(index);
          if ((index + 1) % 3 == 0) {
            switch (((index + 1) / 3).round()) {
              case 3:
                return Calendar(colorScheme);
              case 2:
                return WorkHours(colorScheme);
              case 6:
                return FamilyContactDisplay(colorScheme);
              case 4:
                return Language(colorScheme);
              case 1:
                return ColorSetter(colorScheme);
              case 5:
                return TermsOfService(colorScheme);
            }
          }
          return Divider(
            height: Sizes.dividerHeight,
            thickness: Sizes.dividerThickness,
            color: colorScheme.getColor(CustomColorScheme.darkPrimary),
          );
        },
        itemCount: 6 * 3 + 2,
      ),
    );
  }
}
