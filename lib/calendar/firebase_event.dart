// ignore_for_file: prefer_final_fields

import 'dart:typed_data';

import 'package:edunciate/calendar/custom_calendar_event_data.dart';
import 'package:flutter/cupertino.dart';

class FirebaseEvent {
  String _message;
  int _dayOfMonth;
  int _month;
  int _year;
  String _className;
  late MemoryImage _classPhoto;

// Testing the settings
  FirebaseEvent(this._message, this._dayOfMonth, this._month, this._year,
      this._className, Uint8List photoBytes) {
    _classPhoto = MemoryImage(photoBytes);
  }

  String getMessage() {
    return _message;
  }

  String getClassName() {
    return _className;
  }

  int getDayOfMonth() {
    return _dayOfMonth;
  }

  int getMonth() {
    return _month;
  }

  int getYear() {
    return _year;
  }

  MemoryImage getImage() {
    return _classPhoto;
  }

  CustomCalendarEventData toCustomCalendarEvent() {
    return CustomCalendarEventData(_classPhoto,
        title: _className,
        date: DateTime(_year, _month, _dayOfMonth),
        description: _message);
  }
}
