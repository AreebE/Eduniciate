// Areeb Emran
// Language display

// ignore_for_file: no_logic_in_create_state, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';

import '../color_scheme.dart';

class LanguageApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  LanguageApp(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<LanguageApp> createState() => _LanguageAppState(_colorScheme);
}

class _LanguageAppState extends State<LanguageApp> {
  CustomColorScheme _colorScheme;

  _LanguageAppState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Language(_colorScheme),
    ));
  }
}

class Language extends StatefulWidget {
  final CustomColorScheme colorScheme;

  const Language(this.colorScheme, {Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState(colorScheme);
}

class _LanguageState extends State<Language> {
  final CustomColorScheme colorScheme;
  String currentVal = "en";

  _LanguageState(this.colorScheme);

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
                        "English",
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
                      DropdownButton<String>(
                          dropdownColor: colorScheme.getColor(CustomColorScheme
                              .backgroundAndHighlightedNormalText),
                          focusColor: colorScheme.getColor(CustomColorScheme
                              .backgroundAndHighlightedNormalText),
                          items: <String>["en", "fr", "ja"]
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: FontStandards.getTextStyle(
                                    colorScheme, Style.norm, FontSize.small),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              currentVal = newValue!;
                            });
                          },
                          value: currentVal)
                    ],
                  ),
                )));
  }
}
