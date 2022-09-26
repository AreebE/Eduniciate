import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/settings/items/event.dart';

class CalendarFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String classesKey = "classes";

  static const String classesCollection = "Classes";
  static const String eventsKey = "events";

  static const String eventsCollection = "Absences";
  static const String timestampKey = "date";
  static const String reasonKey = "reason";

  late FirebaseFirestore _storage;

  CalendarFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getEvents(String personID, FirebaseListener listener) async {
    List<Event> userEvents = [];
    DocumentSnapshot personInfo =
        await _storage.collection(usersCollection).doc(personID).get();
    List<DocumentReference> classes = personInfo.get(classesKey);
    for (int i = 0; i < classes.length; i++) {
      DocumentSnapshot classInfo = await _storage
          .collection(classesCollection)
          .doc(classes.elementAt(i).id)
          .get();
      List<DocumentReference> events = classInfo.get(eventsKey);
      for (int j = 0; j < events.length; j++) {
        DocumentSnapshot event = await _storage
            .collection(eventsCollection)
            .doc(events.elementAt(i).id)
            .get();
        DateTime time = (event.get(timestampKey) as Timestamp).toDate();
        userEvents
            .add(Event(event.get(reasonKey), time.day, time.month, time.year));
      }
    }
    listener.onSuccess(userEvents);
  }

  Future<void> addEvent(String classID, Event e) async {
    Map<String, dynamic> data = Map();
    data.putIfAbsent(timestampKey,
        () => DateTime(e.getYear(), e.getMonth(), e.getDayOfMonth()));
    DocumentReference eventRef =
        await _storage.collection(eventsCollection).add(data);
    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> events = classInfo.get(eventsKey);
    events.add(eventRef);
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(eventsKey, () => events);
    _storage.collection(classesCollection).doc(classInfo.id).update(newData);
  }
}
