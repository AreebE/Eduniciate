import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/settings/items/time_range.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsersFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String bioKey = "bio";
  static const String classesKey = "classes";
  static const String emailKey = "email";
  static const String languageKey = "language";
  static const String nameKey = "name";
  static const String notificationStatusKey = "notificationStatus";
  static const String phoneNumberKey = "phoneNumber";
  static const String photoKey = "photo";
  static const String pronounsKey = "pronouns";
  static const String textSizesKey = "textSize";
  static const String typeKey = "type";
  static const String workHoursKey = "workHours";

  static const String rangeCollections = "Ranges";
  static const String dayKey = "day";
  static const String endTimeKey = "endTime";
  static const String startTimeKey = "startTime";

  static Timestamp _baseStartTime =
      Timestamp.fromDate(DateTime(2022, 3, 3, 8, 0));
  static Timestamp _baseEndTime =
      Timestamp.fromDate(DateTime(2022, 3, 3, 18, 0));

  late FirebaseFirestore storage;

  UsersFirebaseAccessor() {
    storage = FirebaseFirestore.instance;
  }

  Future<void> createNewUser(String email, String phoneNumber, String pronouns,
      String name, FirebaseListener listener) async {
    List<DocumentReference> workHours = [];
    for (int i = 0; i < 7; i++) {
      Map<String, dynamic> items = Map();
      items.putIfAbsent(startTimeKey, () => _baseStartTime);
      items.putIfAbsent(endTimeKey, () => _baseEndTime);
      items.putIfAbsent(dayKey, () => i);
      DocumentReference reference =
          await storage.collection(rangeCollections).add(items);
      workHours.add(reference);
    }
    List<int> photoBytes =
        (await rootBundle.load("assets/images/basicProfile.png"))
            .buffer
            .asUint8List()
            .toList();
    Map<String, dynamic> userData = Map();
    userData.putIfAbsent(bioKey, () => "");
    userData.putIfAbsent(classesKey, () => []);
    userData.putIfAbsent(emailKey, () => email);
    userData.putIfAbsent(languageKey, () => "en");
    userData.putIfAbsent(nameKey, () => name);
    userData.putIfAbsent(notificationStatusKey, () => "always");
    userData.putIfAbsent(phoneNumberKey, () => phoneNumber);
    userData.putIfAbsent(photoKey, () => photoBytes);
    userData.putIfAbsent(pronounsKey, () => pronouns);
    userData.putIfAbsent(textSizesKey, () => 12);
    userData.putIfAbsent(typeKey, () => "student");
    userData.putIfAbsent(workHoursKey, () => workHours);
    // print("eeee");
    listener.onSuccess(
        [(await storage.collection(usersCollection).add(userData)).id]);
  }

  Future<void> doesUserExist(String email, FirebaseListener listener) async {
    QuerySnapshot results = await storage
        .collection(usersCollection)
        .where(emailKey, isEqualTo: email)
        .get();
    if (results.size != 0) {
      listener.onSuccess([
        results.docs.elementAt(0).id,
        results.docs.elementAt(0).get(typeKey)
      ]);
    } else {
      listener.onSuccess([]);
    }
  }

  Future<void> getUserRole(String userID, FirebaseListener listener) async {
    DocumentSnapshot user =
        await storage.collection(usersCollection).doc(userID).get();
    listener.onSuccess([UserRole.getRole(user.get(typeKey))]);
  }
}
