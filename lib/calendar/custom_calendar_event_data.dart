import 'dart:core';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';

class CustomCalendarEventData extends CalendarEventData {
  MemoryImage image;

  static const List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  static const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  CustomCalendarEventData(this.image,
      {required super.title, required super.date, required super.description});

  static String getDayName(int typeOfDay) {
    return weekDays[typeOfDay];
  }

  static String getMonth(int month) {
    return months[month];
  }

  static String getDayNum(int day) {
    switch (day % 10) {
      case 1:
        return day.toString() + "st";
      case 2:
        return day.toString() + "nd";
      case 3:
        return day.toString() + "rd";
      default:
        return day.toString() + "th";
    }
  }
}
