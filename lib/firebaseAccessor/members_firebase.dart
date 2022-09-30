import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/calendar_firebase.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/member_item.dart';
import 'package:edunciate/settings/items/event.dart';

class MembersFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String photoKey = "photo";
  static const String nameKey = "name";

  static const String membersCollection = "Members";
  static const String personIDKey = "personID";
  static const String roleKey = "role";
  static const String conversationLastSeenKey = "conversationLastSeen";

  static const String classesCollection = "Classes";
  static const String membersKey = "members";

  late FirebaseFirestore _storage;

  MembersFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getMembers(String classID, FirebaseListener listener) async {
    DocumentSnapshot classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> members = classInfo.get(membersKey);
    List membersList = [];
    for (int i = 0; i < members.length; i++) {
      DocumentSnapshot memberInfo = await _storage
          .collection(membersCollection)
          .doc(members.elementAt(0).id)
          .get();
      DocumentSnapshot userInfo = await _storage
          .collection(usersCollection)
          .doc(memberInfo.get(personIDKey))
          .get();
      membersList.insert(
          0,
          MemberItem(
              userInfo.get(nameKey),
              userInfo.id,
              memberInfo.id,
              ClassRole.getRole(userInfo.get(roleKey)),
              (userInfo.get(photoKey) as List).cast<int>(),
              userInfo.get(conversationLastSeenKey)));
    }
  }

  void updateRole(String memberID, ClassRole newRole) {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(roleKey, () => newRole.name);
    _storage.collection(membersCollection).doc(memberID).update(newData);
  }
}
