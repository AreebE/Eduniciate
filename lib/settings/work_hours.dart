// Areeb Emran
// Work Hours display

import 'package:flutter/material.dart';

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';
import 'package:edunciate/settings/items/time_range.dart';

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
    TimeRange("6:30\nA.M.", "12:30\nP.M."),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.workHours,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                _colorScheme,
                Style.header,
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
                Text(
                  StringList.day,
                  style: FontStandards.getTextStyle(
                      _colorScheme, Style.darkNorm, FontSize.large),
                ),
                const SizedBox(
                  width: Sizes.smallMargin,
                ),
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: buildDay,
                    shrinkWrap: true,
                    itemCount: Sizes.numOfDays)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Sizes.smallMargin,
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
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: Sizes.borderWidth,
                        color: _colorScheme
                            .getColor(CustomColorScheme.darkPrimary)),
                    color:
                        _colorScheme.getColor(CustomColorScheme.lightPrimary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: getRangeDisplay(),
                ))),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }

  Widget buildDay(BuildContext context, int index) {
    bool isSelected = index == _selectedIndex;
    return SizedBox(
      width: Sizes.smallButtonWidth,
      height: Sizes.smallButtonHeight,
      child: ElevatedButton(
          onPressed: () => changeDay(index),
          style: ElevatedButton.styleFrom(
              primary: (isSelected)
                  ? _colorScheme.getColor(CustomColorScheme.darkVariant)
                  : _colorScheme.getColor(CustomColorScheme.lightPrimary),
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
                _colorScheme,
                (isSelected) ? Style.lightBold : Style.darkBold,
                FontSize.medium),
          )),
    );
  }

  List<Widget> getRangeDisplay() {
    List<Widget> widgets = [];
    for (int i = 0; i < setRanges.length * 2 + 1; i++) {
      if (i % 2 == 1) {
        widgets.add(Divider(
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
          color: _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
        ));
      } else if ((i / 2).round() >= setRanges.length) {
        widgets.add(
          Padding(
              padding: const EdgeInsets.all(Sizes.smallMargin),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Sizes.extremeRoundedBorder)),
                    primary:
                        _colorScheme.getColor(CustomColorScheme.normalText)),
                onPressed: addState,
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: Sizes.addSize,
                      color: _colorScheme.getColor(
                          CustomColorScheme.backgroundAndHighlightedNormalText),
                    ),
                    Icon(
                      Icons.add_outlined,
                      size: Sizes.plusSize,
                      color:
                          _colorScheme.getColor(CustomColorScheme.normalText),
                    ),
                  ],
                ),
                label: Text(
                  StringList.addRange,
                  textAlign: TextAlign.center,
                  style: FontStandards.getTextStyle(
                      _colorScheme, Style.brightNorm, FontSize.medium),
                ),
              )),
        );
      } else {
        widgets.add(buildRange((i / 2).round()));
      }
    }
    widgets.insert(
        0,
        Divider(
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
          color: _colorScheme.getColor(CustomColorScheme.lightSecondVariant),
        ));
    widgets.insert(
      0,
      Text(
        StringList.titleOfRanges,
        textAlign: TextAlign.center,
        style: FontStandards.getTextStyle(
            _colorScheme, Style.darkBold, FontSize.title),
      ),
    );
    return widgets;
  }

  Widget buildRange(int position) {
    TimeRange current = setRanges.elementAt(position);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(),
        // The start time
        Container(
          color: _colorScheme.getColor(CustomColorScheme.lightVariant),
          padding: const EdgeInsets.all(Sizes.smallMargin),
          margin: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(
            current.getStart(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.darkBold, FontSize.medium),
          ),
        ),
        // to transition
        Text(
          StringList.to,
          textAlign: TextAlign.center,
          style: FontStandards.getTextStyle(
              _colorScheme, Style.darkVarBold, FontSize.small),
        ),
        // End time
        Container(
          color: _colorScheme.getColor(CustomColorScheme.lightVariant),
          padding: const EdgeInsets.all(Sizes.smallMargin),
          margin: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(
            current.getEnd(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.darkBold, FontSize.medium),
          ),
        ),
        // Change button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: _colorScheme.getColor(CustomColorScheme.change),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.roundedBorder))),
          onPressed: changeState,
          child: Text(
            StringList.change,
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                _colorScheme, Style.darkBold, FontSize.small),
          ),
        ),
        // Deny button
        Material(
          shape: const CircleBorder(),
          color: _colorScheme.getColor(CustomColorScheme.delete),
          child: IconButton(
            onPressed: changeState,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.delete,
              size: Sizes.addSize,
              color: _colorScheme.getColor(
                  CustomColorScheme.backgroundAndHighlightedNormalText),
            ),
          ),
        ),
        const SizedBox(),
      ],
    );
  }

  void changeDay(int position) {
    _selectedIndex = position;
    setState(() {});
  }

  void addState() {}

  void changeState() {}

  void removeState() {}
}
