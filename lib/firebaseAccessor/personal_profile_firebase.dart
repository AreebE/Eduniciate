import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:flutter/material.dart';

import '../settings/items/time_range.dart';

class PersonalProfileFirebaseAccessor {
  late FirebaseFirestore _storage;

  PersonalProfileFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }
  static const String usersCollection = "Users";
  static const String bioKey = "bio";
  static const String emailKey = "email";
  static const String nameKey = "name";
  static const String phoneNumberKey = "phoneNumber";
  static const String photoKey = "photo";
  static const String pronounsKey = "pronouns";
  static const String typeKey = "type";
  static const String workHoursKey = "workHours";

  static const String rangeCollections = "Ranges";
  static const String dayKey = "day";
  static const String endTimeKey = "endTime";
  static const String startTimeKey = "startTime";

  static const int bioArrayKey = 0;
  static const int emailArrayKey = 1;
  static const int nameArrayKey = 2;
  static const int phoneNumArrayKey = 3;
  static const int photoArrayKey = 4;
  static const int pronounsArrayKey = 5;
  static const int typeArrayKey = 6;
  static const int workHoursArrayKey = 7;

  Future<void> getUserInfo(String id, FirebaseListener listener) async {
    List returnValues = List.filled(8, null);
    DocumentSnapshot<Map<String, dynamic>> user =
        await _storage.collection(usersCollection).doc(id).get();

    returnValues[bioArrayKey] = user.get(bioKey);
    returnValues[emailArrayKey] = user.get(emailKey);
    returnValues[nameArrayKey] = user.get(nameKey);
    returnValues[phoneNumArrayKey] = user.get(phoneNumberKey);
    returnValues[photoArrayKey] = user.get(photoKey);
    returnValues[typeArrayKey] = user.get(typeKey);
    returnValues[workHoursArrayKey] = user.get(workHoursKey);

    List<TimeRange> ranges =
        List.filled(7, TimeRange("", Timestamp(0, 0), Timestamp(0, 0)));
    List<DocumentReference> workHoursIDs = user.get(workHoursKey);
    for (int i = 0; i < workHoursIDs.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> workHourInfo = await _storage
          .collection(rangeCollections)
          .doc(workHoursIDs.elementAt(i).id)
          .get();
      ranges[workHourInfo.get(dayKey)] = TimeRange(workHourInfo.id,
          workHourInfo.get(startTimeKey), workHourInfo.get(endTimeKey));
    }
    returnValues[workHoursArrayKey] = ranges;

    listener.onSuccess(returnValues);
  }

  void updateBio(String id, String newBio) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(bioKey, () => newBio);
    _storage.collection(usersCollection).doc(id).update(newData);
  }

  void updatePhoto(String id, MemoryImage newImage) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(photoKey, () => newImage);
    _storage.collection(usersCollection).doc(id).update(newData);
  }

  void updatePronouns(String id, String pronouns) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(pronounsKey, () => pronouns);
    _storage.collection(usersCollection).doc(id).update(newData);
  }

  void updateType(String id, String type) {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(typeKey, () => type);
    _storage.collection(usersCollection).doc(id).update(newData);
  }
}
