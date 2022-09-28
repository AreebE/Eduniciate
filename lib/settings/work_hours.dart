// Areeb Emran
// Work Hours display

// ignore_for_file: no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/settings_firebase.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:flutter/material.dart';

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:edunciate/settings/items/time_range.dart';

class WorkHoursApp extends StatefulWidget {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  WorkHoursApp(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<WorkHoursApp> createState() =>
      _WorkHoursAppState(_colorScheme, _settingsItem);
}

class _WorkHoursAppState extends State<WorkHoursApp> {
  CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  _WorkHoursAppState(this._colorScheme, this._settingsItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: WorkHours(_colorScheme, _settingsItem),
    ));
  }
}

class WorkHours extends StatefulWidget {
  final CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;

  WorkHours(this._colorScheme, this._settingsItem, {Key? key})
      : super(key: key);

  @override
  State<WorkHours> createState() =>
      _WorkHoursState(_colorScheme, _settingsItem);
}

class _WorkHoursState extends State<WorkHours> {
  int _selectedIndex = 0;
  final CustomColorScheme _colorScheme;
  SettingsItem _settingsItem;
  late List<TimeRange> _setRanges;

  _WorkHoursState(this._colorScheme, this._settingsItem) {
    _setRanges = _settingsItem.getTimeRanges();
  }

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
    // widgets.add(
    //   Padding(
    //       padding: const EdgeInsets.all(Sizes.smallMargin),
    //       child: ElevatedButton.icon(
    //         style: ElevatedButton.styleFrom(
    //             shape: RoundedRectangleBorder(
    //                 borderRadius:
    //                     BorderRadius.circular(Sizes.extremeRoundedBorder)),
    //             primary: _colorScheme.getColor(CustomColorScheme.darkPrimary)),
    //         onPressed: () => {changeState(true)},
    //         icon: Icon(
    //           Icons.timer,
    //           size: Sizes.addSize,
    //           color: _colorScheme.getColor(
    //               CustomColorScheme.backgroundAndHighlightedNormalText),
    //         ),
    //         label: Text(
    //           StringList.change,
    //           textAlign: TextAlign.center,
    //           style: FontStandards.getTextStyle(
    //               _colorScheme, Style.brightNorm, FontSize.medium),
    //         ),
    //       )),
    // );
    return widgets;
  }

  Widget buildRange() {
    TimeRange current = _setRanges.elementAt(_selectedIndex);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(),
        // The start time
        ElevatedButton(
            onPressed: () => {changeState(true)},
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(Sizes.timeSize, Sizes.timeSize),
                primary:
                    _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
                shadowColor:
                    _colorScheme.getColor(CustomColorScheme.darkPrimary),
                shape: const CircleBorder()),
            child: Text(
              current.getStart(),
              textAlign: TextAlign.center,
              style: FontStandards.getTextStyle(
                  _colorScheme, Style.brightNorm, FontSize.medium),
            )),

        // to transition
        Text(
          StringList.to,
          textAlign: TextAlign.center,
          style: FontStandards.getTextStyle(
              _colorScheme, Style.norm, FontSize.medium),
        ),
        ElevatedButton(
            onPressed: () => {changeState(false)},
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(Sizes.timeSize, Sizes.timeSize),
                primary:
                    _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
                shadowColor:
                    _colorScheme.getColor(CustomColorScheme.darkPrimary),
                shape: const CircleBorder()),
            child: Text(
              current.getEnd(),
              textAlign: TextAlign.center,
              style: FontStandards.getTextStyle(
                  _colorScheme, Style.brightNorm, FontSize.medium),
            )),

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

  Future<void> changeState(bool usingStart) async {
    TimeRange current = _setRanges[_selectedIndex];
    DateTime selectedTime = current.getTime(usingStart, false);
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
      builder: (context, child) {
        return TimePickerTheme(
            data: TimePickerThemeData(
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return _colorScheme.getColor(
                      CustomColorScheme.backgroundAndHighlightedNormalText);
                }
                return _colorScheme.getColor(CustomColorScheme.normalText);
              }),
              hourMinuteColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return _colorScheme.getColor(CustomColorScheme.darkPrimary);
                }
                return _colorScheme.getColor(CustomColorScheme.gray);
              }),
              dialHandColor:
                  _colorScheme.getColor(CustomColorScheme.darkPrimary),
              dayPeriodColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return _colorScheme.getColor(CustomColorScheme.darkVariant);
                }
                return _colorScheme.getColor(CustomColorScheme.gray);
              }),
              dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return _colorScheme.getColor(
                      CustomColorScheme.backgroundAndHighlightedNormalText);
                }
                return _colorScheme.getColor(CustomColorScheme.normalText);
              }),

              // _colorScheme.getColor(CustomColorScheme.darkPrimary)
            ),
            child: child!);
      },
    );

    if (newTime != null) {
      DateTime newDateTime = DateTime(2022, 0, 0, newTime.hour, newTime.minute);
      // print("${newTime.hour}, ${newTime.minute}");
      // print(newDateTime);
      // print(current.getTime(false, false));
      if (usingStart && current.getTime(false, false).isAfter(newDateTime)) {
        current.changeStart(newDateTime);
      } else if (!usingStart &&
          current.getTime(true, false).isBefore(newDateTime)) {
        current.changeEnd(newDateTime);
      }

      setState(() {});
    }
  }

  void removeState() {}

  void confirmChanges(bool willChange) {}
}
