// Areeb Emran
// Work Hours display

// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:edunciate/settings/items/time_range.dart';

class WorkHoursApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  WorkHoursApp(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<WorkHoursApp> createState() => _WorkHoursAppState(_colorScheme);
}

class _WorkHoursAppState extends State<WorkHoursApp> {
  CustomColorScheme _colorScheme;

  _WorkHoursAppState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: WorkHours(_colorScheme),
    ));
  }
}

class WorkHours extends StatefulWidget {
  final CustomColorScheme _colorScheme;

  const WorkHours(this._colorScheme, {Key? key}) : super(key: key);

  @override
  State<WorkHours> createState() => _WorkHoursState(_colorScheme);
}

class _WorkHoursState extends State<WorkHours> {
  int _selectedIndex = 0;
  final CustomColorScheme _colorScheme;
  List<TimeRange> setRanges = [
    TimeRange("8:00\nA.M.", "6:00\nP.M."),
    TimeRange("1:00\nP.M.", "6:00\nP.M."),
  ];

  _WorkHoursState(this._colorScheme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        // Title
        const FractionallySizedBox(
          widthFactor: 1,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.workHours,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                _colorScheme,
                Style.normHeader,
                FontSize.heading,
              )),
        ),
        const SizedBox(height: Sizes.smallMargin),
        // Day Selection
        SizedBox(
          height: Sizes.smallButtonHeight,
          child: FractionallySizedBox(
            widthFactor: Sizes.largeRowSpace,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              textDirection: TextDirection.ltr,
              children: [
                const SizedBox(
                  width: Sizes.smallMargin,
                ),
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: buildDay,
                    shrinkWrap: true,
                    itemCount: Sizes.numOfDays * 2 - 1)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              0, Sizes.smallMargin, 0, Sizes.smallMargin),
          child: Divider(
            height: Sizes.dividerHeight,
            thickness: Sizes.dividerThickness,
            color: _colorScheme.getColor(CustomColorScheme.gray),
          ),
        ),

        // Day title
        Text(StringList.weekDays.elementAt(_selectedIndex),
            textDirection: TextDirection.ltr,
            style: FontStandards.getTextStyle(
              _colorScheme,
              Style.darkNorm,
              FontSize.title,
            )),
        const SizedBox(
          height: Sizes.smallMargin,
        ),
        // Range view
        FractionallySizedBox(
            widthFactor: Sizes.largeRowSpace,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: getRangeDisplay(),
            )),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }

  Widget buildDay(BuildContext context, int index) {
    if (index % 2 == 1) {
      return const SizedBox(width: Sizes.smallMargin);
    }
    index = (index + 1) ~/ 2;
    bool isSelected = index == _selectedIndex;
    return SizedBox(
      width: Sizes.smallButtonWidth,
      height: Sizes.smallButtonHeight,
      child: ElevatedButton(
          onPressed: () => changeDay(index),
          style: ElevatedButton.styleFrom(
              primary: (isSelected)
                  ? _colorScheme.getColor(CustomColorScheme.darkPrimary)
                  : _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
              shape: BeveledRectangleBorder(
                side: BorderSide(
                    color: _colorScheme.getColor(CustomColorScheme.darkPrimary),
                    width: Sizes.borderWidth),
                borderRadius: BorderRadius.zero,
              ),
              padding: EdgeInsets.zero),
          child: Text(
            StringList.weekDays.elementAt(index).substring(0, 2),
            style: FontStandards.getTextStyle(
                _colorScheme, Style.brightNorm, FontSize.medium),
          )),
    );
  }

  List<Widget> getRangeDisplay() {
    List<Widget> widgets = [];

    widgets.add(buildRange());
    widgets.add(
      Padding(
          padding: const EdgeInsets.all(Sizes.smallMargin),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Sizes.extremeRoundedBorder)),
                primary: _colorScheme.getColor(CustomColorScheme.darkPrimary)),
            onPressed: changeState,
            icon: Icon(
              Icons.timer,
              size: Sizes.addSize,
              color: _colorScheme.getColor(
                  CustomColorScheme.backgroundAndHighlightedNormalText),
            ),
            label: Text(
              StringList.change,
              textAlign: TextAlign.center,
              style: FontStandards.getTextStyle(
                  _colorScheme, Style.brightNorm, FontSize.medium),
            ),
          )),
    );
    return widgets;
  }

  Widget buildRange() {
    TimeRange current = setRanges.elementAt(0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(),
        // The start time
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
          ),
          padding: const EdgeInsets.all(Sizes.mediumMargin),
          margin: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(
            current.getStart(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.brightNorm, FontSize.medium),
          ),
        ),
        // to transition
        Text(
          StringList.to,
          textAlign: TextAlign.center,
          style: FontStandards.getTextStyle(
              _colorScheme, Style.norm, FontSize.medium),
        ),
        // End time
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
          ),
          padding: const EdgeInsets.all(Sizes.mediumMargin),
          margin: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(
            current.getEnd(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.brightNorm, FontSize.medium),
          ),
        ),
        // // Change button
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //       primary: _colorScheme.getColor(CustomColorScheme.change),
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(Sizes.roundedBorder))),
        //   onPressed: changeState,
        //   child: Text(
        //     StringList.change,
        //     textAlign: TextAlign.center,
        //     style: FontStandards.getTextStyle(
        //         _colorScheme, Style.darkBold, FontSize.medium),
        //   ),
        // ),
        const SizedBox(),
      ],
    );
  }

  void changeDay(int position) {
    _selectedIndex = position;
    setState(() {});
  }

  void addState() {}

  void changeState() {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                backgroundColor: _colorScheme.getColor(
                    CustomColorScheme.backgroundAndHighlightedNormalText),
                contentPadding: const EdgeInsets.all(Sizes.mediumMargin),
                content: FractionallySizedBox(
                  widthFactor: Sizes.largeRowSpace,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(),
                          // The start time
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _colorScheme.getColor(
                                  CustomColorScheme.lightSecondVariant),
                            ),
                            padding: const EdgeInsets.all(Sizes.mediumMargin),
                            margin: const EdgeInsets.fromLTRB(
                                Sizes.none,
                                Sizes.smallMargin,
                                Sizes.none,
                                Sizes.smallMargin),
                            child: Text(
                              "8:00\n A.M.",
                              textAlign: TextAlign.center,
                              style: FontStandards.getTextStyle(_colorScheme,
                                  Style.brightNorm, FontSize.medium),
                            ),
                          ),
                          // to transition
                          Text(
                            StringList.to,
                            textAlign: TextAlign.center,
                            style: FontStandards.getTextStyle(
                                _colorScheme, Style.norm, FontSize.medium),
                          ),
                          // End time
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _colorScheme.getColor(
                                  CustomColorScheme.lightSecondVariant),
                            ),
                            padding: const EdgeInsets.all(Sizes.mediumMargin),
                            margin: const EdgeInsets.fromLTRB(
                                Sizes.none,
                                Sizes.smallMargin,
                                Sizes.none,
                                Sizes.smallMargin),
                            child: Text(
                              "6:00\nP.M.",
                              textAlign: TextAlign.center,
                              style: FontStandards.getTextStyle(_colorScheme,
                                  Style.brightNorm, FontSize.medium),
                            ),
                          ),
                          // // Change button
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       primary: _colorScheme.getColor(CustomColorScheme.change),
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(Sizes.roundedBorder))),
                          //   onPressed: changeState,
                          //   child: Text(
                          //     StringList.change,
                          //     textAlign: TextAlign.center,
                          //     style: FontStandards.getTextStyle(
                          //         _colorScheme, Style.darkBold, FontSize.medium),
                          //   ),
                          // ),
                          const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: Sizes.mediumMargin,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () => confirmChanges(false),
                              style: ElevatedButton.styleFrom(
                                  primary: _colorScheme
                                      .getColor(CustomColorScheme.delete)),
                              child: Text(
                                StringList.discard,
                                style: FontStandards.getTextStyle(_colorScheme,
                                    Style.brightNorm, FontSize.small),
                              )),
                          ElevatedButton(
                              onPressed: () => confirmChanges(true),
                              style: ElevatedButton.styleFrom(
                                  primary: _colorScheme
                                      .getColor(CustomColorScheme.darkPrimary)),
                              child: Text(
                                StringList.confirm,
                                style: FontStandards.getTextStyle(_colorScheme,
                                    Style.brightNorm, FontSize.small),
                              ))
                        ],
                      )
                    ],
                  ),
                ))));
  }

  void removeState() {}

  void confirmChanges(bool willChange) {}
}
