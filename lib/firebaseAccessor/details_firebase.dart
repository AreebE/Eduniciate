import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/class_details_item.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../user_info_item.dart';

class ClassDetailsFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String userRoleKey = "type";
  static const String classesKey = "classes";

  static const String classesCollection = "Classes";
  static const String membersKey = "members";
  static const String nameKey = "name";
  static const String isPrivateKey = "isPrivate";
  static const String codeKey = "code";
  static const String photoKey = "photo";
  static const String descriptionKey = "description";

  static const String membersCollection = "Members";
  static const String personIDKey = "personID";
  static const String classIDKey = "classID";
  static const String roleKey = "role";

  late FirebaseFirestore _storage;

  ClassDetailsFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> leaveClass(
      String memberID, String classID, FirebaseListener listener) async {
    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(classesCollection).doc(classID).get();

    DocumentSnapshot memberInfo =
        (await _storage.collection(membersCollection).doc(memberID).get());
    DocumentSnapshot<Map<String, dynamic>> userInfo = await _storage
        .collection(usersCollection)
        .doc(memberInfo.get(personIDKey))
        .get();

    UserRole userRole = UserRole.getRole(userInfo.get(userRoleKey));
    ClassRole classRole = ClassRole.getRole(memberInfo.get(roleKey));

    if (classRole == ClassRole.owner && userRole == UserRole.owner) {
      List<DocumentReference> members =
          (classInfo.get(membersKey) as List).cast<DocumentReference>();
      bool foundOtherOwner = false;
      for (int i = 0; i < members.length; i++) {
        String currentID = members[i].id;
        if (currentID != memberID) {
          DocumentSnapshot currentMember =
              await _storage.collection(membersCollection).doc(currentID).get();
          DocumentSnapshot currentPerson = await _storage
              .collection(usersCollection)
              .doc(currentMember.get(personIDKey) as String)
              .get();
          if (UserRole.getRole(currentPerson.get(userRoleKey) as String) ==
              UserRole.owner) {
            foundOtherOwner = true;
            break;
          }
        }
      }
      if (!foundOtherOwner) {
        listener.onFailure("Cannot leave a class without a teacher!");
        return;
      }
    }
    List<DocumentReference> members =
        (classInfo.get(membersKey) as List).cast<DocumentReference>();
    for (int i = 0; i < members.length; i++) {
      if (members[i].id == memberInfo.id) {
        members.removeAt(i);
      }
    }
    Map<String, dynamic> newClassData = Map<String, dynamic>();
    newClassData[membersKey] = members;
    _storage.collection(classesCollection).doc(classID).update(newClassData);

    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(roleKey, () => ClassRole.nonMember.name);
    _storage.collection(membersCollection).doc(memberInfo.id).update(newData);

    List<DocumentReference> classes =
        (userInfo.get(classesKey) as List).cast<DocumentReference>();
    for (int i = 0; i < classes.length; i++) {
      if (classes[i].id == classInfo.id) {
        classes.removeAt(i);
      }
    }
    _storage
        .collection(usersCollection)
        .doc(userInfo.id)
        .update({classesKey: classes});
    listener.onSuccess([]);
  }

  Future<void> getClassInfo(String classID, FirebaseListener listener) async {
    DocumentSnapshot classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    listener.onSuccess([
      ClassDetailsItem(
          classID,
          classInfo.get(nameKey),
          classInfo.get(isPrivateKey),
          classInfo.get(descriptionKey),
          Uint8List.fromList((classInfo.get(photoKey) as List).cast<int>()),
          classInfo.get(codeKey))
    ]);
  }

  void updateName(String classID, String name) {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(nameKey, () => name);
    _storage.collection(classesCollection).doc(classID).update(newData);
  }

  void updateDesc(String classID, String desc) {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(descriptionKey, () => desc);
    _storage.collection(classesCollection).doc(classID).update(newData);
  }

  void updatePrivacy(String classID, bool isPrivate) {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(isPrivateKey, () => isPrivate);
    _storage.collection(classesCollection).doc(classID).update(newData);
  }

  void updatePhoto(String classID, Uint8List bytes) {
    Map<String, dynamic> newData = Map<String, dynamic>();
    newData.putIfAbsent(photoKey, () => bytes);
    _storage.collection(classesCollection).doc(classID).update(newData);
  }

  Future<void> getName(String classID, FirebaseListener listener) async {
    listener.onSuccess([
      (await _storage.collection(classesCollection).doc(classID).get())
          .get(nameKey)
    ]);
  }

  Future<void> getPhoto(String classID, FirebaseListener listener) async {
    listener.onSuccess([
      (await _storage.collection(classesCollection).doc(classID).get())
          .get(photoKey)
    ]);
  }

  Future<void> findSelf(
      String userID, String classID, FirebaseListener listener) async {
    QueryDocumentSnapshot member = (await _storage
            .collection(membersCollection)
            .where(personIDKey, isEqualTo: userID)
            .where(classIDKey, isEqualTo: classID)
            .get())
        .docs
        .first;
    listener.onSuccess([member.id]);
  }
}
