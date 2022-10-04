import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/classroom/announcements/announcement_item.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';

class UpdatesFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String nameKey = "name";

  static const String classesCollection = "Classes";
  static const String announcementsKey = "announcements";

  static const String announcementsCollection = "Announcements";
  static const String contentKey = "content";
  static const String sendTimeKey = "sendTime";
  static const String senderIDKey = "sender";
  static const String classIDKey = "classIDKey";
  static const String titleKey = "title";

  late FirebaseFirestore _storage;
  UpdatesFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getAnnouncements(
      String classID, FirebaseListener listener) async {
    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> announcementIDs = classInfo.get(announcementsKey);
    List announcements = [];
    for (int i = 0; i < announcementIDs.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> announcementInfo = await _storage
          .collection(announcementsCollection)
          .doc(announcementIDs.elementAt(0).id)
          .get();
      DocumentSnapshot<Map<String, dynamic>> senderInfo = await _storage
          .collection(usersCollection)
          .doc((announcementInfo.get(senderIDKey) as DocumentReference).id)
          .get();
      AnnouncementItem item = AnnouncementItem(
          announcementInfo.get(contentKey),
          senderInfo.get(nameKey),
          announcementInfo.get(sendTimeKey),
          senderInfo.id,
          announcementInfo.get(titleKey),
          classID);
      announcements.add(item);
    }
    listener.onSuccess(announcements);
  }

  Future<void> addAnnouncement(AnnouncementItem item) async {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(contentKey, () => item.getContent());
    newData.putIfAbsent(sendTimeKey, () => item.getSendtime());
    newData.putIfAbsent(senderIDKey, () => item.getSenderID());
    newData.putIfAbsent(classIDKey, () => item.getClassID());
    newData.putIfAbsent(titleKey, () => item.getTitle());
    DocumentReference announcementID =
        (await _storage.collection(announcementsCollection).add(newData));

    DocumentSnapshot<Map<String, dynamic>> classInfo = await _storage
        .collection(classesCollection)
        .doc(item.getClassID())
        .get();
    List<DocumentReference> announcementIDs = classInfo.get(announcementsKey);
    announcementIDs.insert(0, announcementID);
    _storage
        .collection(classesCollection)
        .doc(item.getClassID())
        .update(classInfo.data()!.cast<String, Object?>());
  }
}
/