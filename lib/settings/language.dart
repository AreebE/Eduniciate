// Areeb Emran
// Language display

// ignore_for_file: no_logic_in_create_state, unused_element, avoid_print

import 'package:edunciate/personal_profile/profile_page.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';

import '../color_scheme.dart';

enum SupportedLanguages { english, japanese, french, spanish, bengali }

extension LangProcessor on SupportedLanguages {
  String get code {
    switch (this) {
      case SupportedLanguages.english:
        return "en";
      case SupportedLanguages.japanese:
        return "ja";
      case SupportedLanguages.french:
        return "fr";
      case SupportedLanguages.spanish:
        return "es";
      case SupportedLanguages.bengali:
        return "bn";
    }
  }

  static SupportedLanguages getLang(String code) {
    for (int i = 0; i < SupportedLanguages.values.length; i++) {
      if (SupportedLanguages.values.elementAt(i).code == code) {
        return SupportedLanguages.values.elementAt(i);
      }
    }
    return SupportedLanguages.english;
  }
}

class LanguageApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  LanguageApp(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<LanguageApp> createState() =>
      _LanguageAppState(_colorScheme, _settingsItem);
}

class _LanguageAppState extends State<LanguageApp> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  _LanguageAppState(this._colorScheme, this._settingsItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: buildAppBar(context),
      body: Language(_colorScheme, _settingsItem),
    ));
  }
}

class Language extends StatefulWidget {
  final CustomColorScheme colorScheme;
  SettingsItem _settingsItem;

  Language(this.colorScheme, this._settingsItem, {Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState(colorScheme, _settingsItem);
}

class _LanguageState extends State<Language> {
  final CustomColorScheme colorScheme;
  SettingsItem _settingsItem;
  late SupportedLanguages currentVal;

  _LanguageState(this.colorScheme, this._settingsItem) {
    currentVal = LangProcessor.getLang(_settingsItem.getLanguage());
  }

  void _voidFunction() {
    // print("EEEEEE");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.language,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                colorScheme,
                Style.normHeader,
                FontSize.heading,
              )),
        ),
        // The language display box
        SizedBox(
          child: Container(
            padding: const EdgeInsets.all(Sizes.smallMargin),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              children: [
                // Current Language
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      StringList.currentLang,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: FontStandards.getTextStyle(
                          colorScheme, Style.norm, FontSize.large),
                    ),
                    const SizedBox(
                      width: Sizes.mediumMargin,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(Sizes.smallMargin),
                      child: Text(
                        textWidthBasis: TextWidthBasis.longestLine,
                        getFullLangName(currentVal.code),
                        style: FontStandards.getTextStyle(
                            colorScheme, Style.normUnderline, FontSize.large),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: Sizes.smallSpacerWidth,
                ),
                // Change language box
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:
                            colorScheme.getColor(CustomColorScheme.darkPrimary),
                        onPrimary: colorScheme.getColor(CustomColorScheme
                            .backgroundAndHighlightedNormalText),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Sizes.roundedBorder))),
                    onPressed: _changeLang,
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.smallMargin),
                      child: Text(
                        textWidthBasis: TextWidthBasis.longestLine,
                        StringList.changeLang,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: FontStandards.getTextStyle(
                            colorScheme, Style.brightNorm, FontSize.large),
                      ),
                    )),
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

  void _changeLang() {
    print(currentVal);
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                  backgroundColor: colorScheme.getColor(
                      CustomColorScheme.backgroundAndHighlightedNormalText),
                  contentPadding: const EdgeInsets.all(Sizes.mediumMargin),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        StringList.changeLang,
                        style: FontStandards.getTextStyle(
                            colorScheme, Style.norm, FontSize.large),
                      ),
                      DropdownButton<SupportedLanguages>(
                          dropdownColor: colorScheme.getColor(CustomColorScheme
                              .backgroundAndHighlightedNormalText),
                          focusColor: colorScheme.getColor(CustomColorScheme
                              .backgroundAndHighlightedNormalText),
                          items: SupportedLanguages.values
                              .map<DropdownMenuItem<SupportedLanguages>>(
                                  (SupportedLanguages val) {
                            return DropdownMenuItem<SupportedLanguages>(
                              value: val,
                              child: Text(
                                getFullLangName(val.code),
                                style: FontStandards.getTextStyle(
                                    colorScheme, Style.norm, FontSize.small),
                              ),
                            );
                          }).toList(),
                          onChanged: (SupportedLanguages? newValue) {
                            setState(() {
                              currentVal = newValue!;
                              _settingsItem.changeLanguage(currentVal.code);
                            });
                          },
                          value: currentVal)
                    ],
                  ),
                ))).then((value) {
      setState(() {});
    });
  }

  static String getFullLangName(String code) {
    String lowercaseName = LangProcessor.getLang(code).name;
    String firstElem = lowercaseName.characters.elementAt(0).toUpperCase();
    return firstElem + lowercaseName.substring(1);
  }
}
