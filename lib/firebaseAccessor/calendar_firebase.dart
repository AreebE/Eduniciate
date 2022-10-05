import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/calendar/firebase_event.dart';

class CalendarFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String classesKey = "classes";

  static const String classesCollection = "Classes";
  static const String eventsKey = "events";
  static const String nameKey = "name";
  static const String photoKey = "photo";

  static const String eventsCollection = "Absences";
  static const String timestampKey = "date";
  static const String reasonKey = "reason";

  late FirebaseFirestore _storage;

  CalendarFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getUserEvents(String personID, FirebaseListener listener) async {
    List<FirebaseEvent> userEvents = [];
    DocumentSnapshot personInfo =
        await _storage.collection(usersCollection).doc(personID).get();
    // print(personInfo.get(classesKey));
    List<DocumentReference> classes =
        (personInfo.get(classesKey) as List).cast<DocumentReference>();
    // print("classes = " + classes.toString());
    for (int i = 0; i < classes.length; i++) {
      DocumentSnapshot classInfo = await _storage
          .collection(classesCollection)
          .doc(classes.elementAt(i).id)
          .get();
      List<DocumentReference> events =
          (classInfo.get(eventsKey) as List).cast<DocumentReference>();
      print("class events = " + events.length.toString());
      for (int j = 0; j < events.length; j++) {
        DocumentSnapshot event = await _storage
            .collection(eventsCollection)
            .doc(events.elementAt(j).id)
            .get();
        DateTime time = (event.get(timestampKey) as Timestamp).toDate();
        userEvents.add(FirebaseEvent(
            event.get(reasonKey),
            time.day,
            time.month,
            time.year,
            classInfo.get(nameKey),
            Uint8List.fromList((classInfo.get(photoKey) as List).cast<int>())));
      }
    }
    listener.onSuccess(userEvents);
  }

  Future<void> getClassEvents(String classID, FirebaseListener listener) async {
    List<FirebaseEvent> userEvents = [];
    DocumentSnapshot classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> events =
        (classInfo.get(eventsKey) as List).cast<DocumentReference>();
    print(events);
    for (int j = 0; j < events.length; j++) {
      DocumentSnapshot event = await _storage
          .collection(eventsCollection)
          .doc(events.elementAt(j).id)
          .get();
      DateTime time = (event.get(timestampKey) as Timestamp).toDate();
      userEvents.add(FirebaseEvent(
          event.get(reasonKey),
          time.day,
          time.month,
          time.year,
          classInfo.get(nameKey),
          Uint8List.fromList((classInfo.get(photoKey) as List).cast<int>())));
    }
    listener.onSuccess(userEvents);
  }

  Future<void> addEvent(String classID, FirebaseEvent e) async {
    Map<String, dynamic> data = Map();
    data.putIfAbsent(timestampKey,
        () => DateTime(e.getYear(), e.getMonth(), e.getDayOfMonth()));
    data.putIfAbsent(nameKey, () => e.getClassName());
    data.putIfAbsent(reasonKey, () => e.getMessage());
    data.putIfAbsent(photoKey, () => e.getImage().bytes);
    DocumentReference eventRef =
        await _storage.collection(eventsCollection).add(data);
    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> events =
        (classInfo.get(eventsKey) as List).cast<DocumentReference>();
    events.add(eventRef);
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(eventsKey, () => events);
    _storage.collection(classesCollection).doc(classInfo.id).update(newData);
  }
}
