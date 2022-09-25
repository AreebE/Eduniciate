// ignore_for_file: unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/settings/items/event.dart';
import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:edunciate/settings/items/time_range.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseSettingsAccessor {
  static const String usersCollection = "Users";
  static const String textSizesKey = "textSize";
  static const String notificationStatusKey = "notificationStatus";
  static const String languageKey = "language";
  static const String workHoursKey = "workHours";

  static const String rangeCollections = "Ranges";
  static const String dayKey = "day";
  static const String endTimeKey = "endTime";
  static const String startTimeKey = "startTime";

  static const int textArrayKey = 0;
  static const int langArrayKey = 1;
  static const int notifStatusArrayKey = 2;
  static const int workHoursStatusArrayKey = 3;

  late FirebaseFirestore storage;

  FirebaseSettingsAccessor() {
    storage = FirebaseFirestore.instance;
  }

  void getSettingsInfo(String personID, FirebaseListener listener) {
    List returnValues = [
      12, // text size
      "en", // language
      "always", // not. status
      [] // work hours
    ];
    print("EEEEEEEE");
    storage.collection(usersCollection).doc(personID).get().then((value) {
      print("found");
      if (!value.exists) {
        listener.onFailure("Could not find you. :(");
      }

      returnValues[textArrayKey] = value.get(textSizesKey);
      returnValues[langArrayKey] = value.get(languageKey);
      returnValues[notifStatusArrayKey] = value.get(notificationStatusKey);
      List<DocumentReference> timeRangeKeys =
          (value.get(workHoursKey) as List).cast<DocumentReference>();
      returnValues[workHoursStatusArrayKey] = timeRangeKeys;
      loadTimeRanges(returnValues, timeRangeKeys, listener);
    });
  }

  void loadTimeRanges(List returnValues, List<DocumentReference> timeRangeKeys,
      FirebaseListener listener) {
    int timeRangesAdded = 0;
    List<TimeRange> ranges =
        List.filled(7, TimeRange("", Timestamp(0, 0), Timestamp(0, 0)));
    returnValues[workHoursStatusArrayKey] = ranges;
    for (int i = 0; i < timeRangeKeys.length; i++) {
      storage
          .collection(rangeCollections)
          .doc(timeRangeKeys.elementAt(i).id)
          .get()
          .then((value) {
        print("value");
        if (!value.exists) {
          listener.onFailure("Could not find time ranges. :(");
        }
        print(value.data());
        print(", " + value.id);
        ranges[value.get(dayKey)] =
            TimeRange(value.id, value.get(startTimeKey), value.get(endTimeKey));
        timeRangesAdded++;
        if (timeRangesAdded == 7) {
          listener.onSuccess(returnValues);
        }
      });
    }
  }

  void updateWorkHours(TimeRange rangeToChange) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(startTimeKey,
        () => Timestamp.fromDate(rangeToChange.getTime(true, true)));
    newData.putIfAbsent(endTimeKey,
        () => Timestamp.fromDate(rangeToChange.getTime(false, true)));
    storage
        .collection(rangeCollections)
        .doc(rangeToChange.getID())
        .update(newData);
  }

  void updateLanguage(String id, String newLang) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(languageKey, () => newLang);
    storage.collection(usersCollection).doc(id).update(newData);
  }

  void updateTextSize(String id, int newSize) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(textSizesKey, () => newSize);
    storage.collection(usersCollection).doc(id).update(newData);
  }

  void updateNotifStatus(String id, String newStatus) {
    Map<String, dynamic> newData = Map();
    print(id);
    newData.putIfAbsent(notificationStatusKey, () => newStatus);
    storage.collection(usersCollection).doc(id).update(newData);
  }
}
