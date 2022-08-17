import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/settings/items/family_contact_item.dart';
import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/settings/items/time_range.dart';

import 'event.dart';

class SettingsItem {
  List<FamilyContact> _contacts;
  List<Event> _events;
  List<Permission> _permissions;
  List<List<TimeRange>> _timeRanges;
  CustomColorScheme _colorScheme;
  String _language;

  SettingsItem(this._contacts, this._events, this._permissions,
      this._timeRanges, this._colorScheme, this._language);

  List<FamilyContact> getContacts() {
    return _contacts;
  }

  void addContact(FamilyContact c) {
    _contacts.add(c);
  }

  void removeContact(FamilyContact c) {
    _contacts.remove(c);
  }

  List<Event> getEvents() {
    return _events;
  }

  void addEvent(Event e) {
    _events.add(e);
  }

  void removeEvent(Event e) {
    _events.remove(e);
  }

  List<Permission> getPermissions() {
    return _permissions;
  }

  void removePermission(Permission p) {
    _permissions.remove(p);
  }

  void addPermission(Permission p) {
    _permissions.add(p);
  }

  List<List<TimeRange>> getTimeRanges() {
    return _timeRanges;
  }

  void removeTimeRange(int day, TimeRange timeRange) {
    _timeRanges.elementAt(day).remove(timeRange);
  }

  void addTimeRange(int day, TimeRange timeRange) {
    _timeRanges.elementAt(day).add(timeRange);
  }

  CustomColorScheme getColorScheme() {
    return _colorScheme;
  }

  String getLanguage() {
    return _language;
  }

  void changeLanguage(String newLanguage) {
    _language = newLanguage;
  }
}
