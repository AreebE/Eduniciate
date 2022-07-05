import 'package:flutter/material.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/event.dart';
import 'package:edunciate/settings/res/icons.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';

class Calendar extends StatefulWidget {
  final CustomColorScheme colorScheme;

  const Calendar(this.colorScheme, {Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState(colorScheme);
}

class _CalendarState extends State<Calendar> {
  final CustomColorScheme colorScheme;

  List<Event> events = [
    Event("Testing", 7, 7, 2022),
    Event("Test222222", 10, 7, 2022),
    Event("Test444444", 20, 7, 2022),
    Event("Test444444", 22, 7, 2022),
  ];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  _CalendarState(this.colorScheme);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<Widget> calenderItems = _createDays();

    // print((calenderItems.length / 7).round().toString() + " == length");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.calendar,
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
        // Calender display
        FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: Sizes.calenderWidth,
            child: Container(
              decoration: BoxDecoration(
                  color: colorScheme.getColor(CustomColorScheme.lightPrimary),
                  border: Border.all(
                      width: Sizes.borderWidth,
                      color:
                          colorScheme.getColor(CustomColorScheme.darkPrimary))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Sizes.smallMargin),
                        child: Material(
                          shape: const CircleBorder(),
                          color: colorScheme
                              .getColor(CustomColorScheme.normalText),
                          child: IconButton(
                            onPressed: () => changeMonth(false),
                            padding: const EdgeInsets.all(Sizes.smallMargin),
                            icon: Icon(
                              Icons.arrow_back,
                              size: Sizes.arrowSize,
                              color: colorScheme.getColor(CustomColorScheme
                                  .backgroundAndHighlightedNormalText),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        getTitle(),
                        style: FontStandards.getTextStyle(
                            colorScheme, Style.darkBold, FontSize.large),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Sizes.smallMargin),
                        child: Material(
                          shape: const CircleBorder(),
                          color: colorScheme
                              .getColor(CustomColorScheme.normalText),
                          child: IconButton(
                            onPressed: () => changeMonth(true),
                            padding: const EdgeInsets.all(Sizes.smallMargin),
                            icon: Icon(
                              Icons.arrow_forward,
                              size: Sizes.arrowSize,
                              color: colorScheme.getColor(CustomColorScheme
                                  .backgroundAndHighlightedNormalText),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: Sizes.borderWidth,
                            color: colorScheme
                                .getColor(CustomColorScheme.darkPrimary))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: calenderItems,
                    ),
                  )

                  // )
                ],
              ),
            )),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        ),
      ],
    );
  }

  List<Column> _createDays() {
    List<Column> widgets = [];
    DateTime firstDay = DateTime(_selectedYear, _selectedMonth, 1);
    // print(firstDay.toString() + ", " + firstDay.weekday.toString());
    int daysInMonth = DateUtils.getDaysInMonth(_selectedYear, _selectedMonth);
    int weekday = firstDay.weekday;
    // print(weekday.toString() + " == weekday");
    for (int i = 0; i < StringList.weekDays.length; i++) {
      widgets.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Sizes.daySize,
            height: Sizes.daySize,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colorScheme.getColor(CustomColorScheme.lightVariant),
                border: Border.all(
                    color: colorScheme.getColor(CustomColorScheme.darkPrimary),
                    width: Sizes.smallBorder)),
            child: Text(
              StringList.weekDays.elementAt(i).substring(0, 2),
              textAlign: TextAlign.center,
              style: FontStandards.getTextStyle(
                  colorScheme, Style.darkBold, FontSize.medium),
            ),
          )
        ],
      ));
    }

    int currentWeekday = DateTime.sunday - 7;
    print(currentWeekday);
    bool useLighterShade = true;
    while (currentWeekday != weekday) {
      widgets
          .elementAt(currentWeekday)
          .children
          .add(getEmptySpace(colorScheme, useLighterShade));
      currentWeekday++;
      // print(widgets.toString());
      // print(" -- " + currentWeekday.toString());
      // print(weekday);
    }

    for (int i = 1; i <= daysInMonth; i++) {
      print(currentWeekday);
      bool isEvent = isAnEvent(i, _selectedMonth, _selectedYear);
      if (currentWeekday == Sizes.numOfDays) {
        currentWeekday = 0;
        useLighterShade = !useLighterShade;
      }
      Color backgroundColor = const Color.fromARGB(0, 0, 0, 0);
      Style fontStyle = Style.norm;
      if (isEvent) {
        if (useLighterShade) {
          backgroundColor = colorScheme.getColor(CustomColorScheme.darkVariant);
          fontStyle = Style.lightBold;
        } else {
          backgroundColor = colorScheme.getColor(CustomColorScheme.darkPrimary);
          fontStyle = Style.lightVarBold;
        }
      } else {
        if (useLighterShade) {
          backgroundColor =
              colorScheme.getColor(CustomColorScheme.lightPrimary);
          fontStyle = Style.darkVarBold;
        } else {
          backgroundColor =
              colorScheme.getColor(CustomColorScheme.lightVariant);
          fontStyle = Style.darkBold;
        }
      }

      DateTime today = DateTime.now();
      if (i == today.day &&
          _selectedMonth == today.month &&
          _selectedYear == today.year) {
        backgroundColor = colorScheme.getColor(CustomColorScheme.change);
        fontStyle = (useLighterShade) ? Style.darkVarBold : Style.darkBold;
      }
      print(widgets.elementAt(currentWeekday).children.length);
      print("Weekday == " + currentWeekday.toString());
      widgets.elementAt(currentWeekday).children.add(Container(
          height: Sizes.daySize,
          width: Sizes.daySize,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.getColor(CustomColorScheme.darkPrimary),
                  width: Sizes.smallBorder)),
          child: ElevatedButton(
            onPressed: () => handleOnClick(i),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(Sizes.plusSize, Sizes.plusSize),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Sizes.fineMargin),
              primary: backgroundColor,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text(
              i.toString(),
              maxLines: 1,
              style: FontStandards.getTextStyle(
                  colorScheme, fontStyle, FontSize.medium),
            ),
          )));
      currentWeekday++;
    }

    while (currentWeekday != Sizes.numOfDays) {
      widgets
          .elementAt(currentWeekday)
          .children
          .add(getEmptySpace(colorScheme, useLighterShade));
      currentWeekday++;
    }
    return widgets;
  }

  Widget getEmptySpace(CustomColorScheme colorScheme, bool useLighterShade) {
    return Container(
      alignment: Alignment.center,
      width: Sizes.daySize,
      height: Sizes.daySize,
      decoration: BoxDecoration(
          color: colorScheme.getColor((useLighterShade)
              ? CustomColorScheme.lightPrimary
              : CustomColorScheme.lightVariant),
          border: Border.all(
              color: colorScheme.getColor(CustomColorScheme.darkPrimary),
              width: Sizes.smallBorder)),
      child: Icon(
        CustomIcons.x_symbol,
        color: colorScheme.getColor(CustomColorScheme.lightSecondVariant),
        size: Sizes.plusSize,
      ),
    );
  }

  bool isAnEvent(int currentDay, int month, int year) {
    for (int i = 0; i < events.length; i++) {
      Event current = events.elementAt(i);

      if (current.getDayOfMonth() == currentDay &&
          current.getMonth() == month &&
          current.getYear() == year) {
        return true;
      }
    }
    return false;
  }

  void handleOnClick(int day) {}

  void changeMonth(bool advance) {
    if (advance) {
      _selectedMonth++;
      if (_selectedMonth == 13) {
        _selectedMonth = 1;
        _selectedYear++;
      }
      setState(() {});
    } else if (_selectedMonth > DateTime.now().month ||
        _selectedYear > DateTime.now().year) {
      _selectedMonth--;
      if (_selectedMonth == 0) {
        _selectedMonth = 12;
        _selectedYear--;
      }
      setState(() {});
    }
  }

  String getTitle() {
    return StringList.getMonth(_selectedMonth) +
        ", " +
        _selectedYear.toString();
  }
}
