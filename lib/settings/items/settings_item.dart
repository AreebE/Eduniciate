// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/settings_firebase.dart';
import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/settings/items/time_range.dart';

import 'event.dart';

class SettingsItem {
  late FirebaseSettingsAccessor _firebaseSettingsAccessor;

  List<TimeRange> _timeRanges;
  String _language;
  String _notifStatus;
  int _textSize;
  String _personID;

  SettingsItem(this._notifStatus, this._textSize, this._timeRanges,
      this._language, this._personID) {
    _firebaseSettingsAccessor = FirebaseSettingsAccessor();
  }

  String getLanguage() {
    return _language;
  }

  String getNotifStatus() {
    return _notifStatus;
  }

  int getTextSize() {
    return _textSize;
  }

  List<TimeRange> getTimeRanges() {
    // print("le garbageeo");
    // print(_timeRanges[0]);
    // print(_timeRanges);
    // print("EEEEE");
    return _timeRanges;
  }

  String getID() {
    return _personID;
  }

  void changeLanguage(String newLanguage) {
    _language = newLanguage;
    _firebaseSettingsAccessor.updateLanguage(_personID, newLanguage);
  }

  void changeNotifStatus(String newStatus) {
    _notifStatus = newStatus;
    // print("EEEE");
    _firebaseSettingsAccessor.updateNotifStatus(_personID, newStatus);
  }

  void changeTextSize(int newSize) {
    _textSize = newSize;
    _firebaseSettingsAccessor.updateTextSize(_personID, newSize);
  }

  void changedRange(TimeRange range) {
    _firebaseSettingsAccessor.updateWorkHours(range);
  }
}
