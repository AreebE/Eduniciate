import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomepageFirebaseAccessor {
  static const String usersCollection = "Users";
  static const String usernameKey = "name";
  static const String classesKey = "classes";

  static const String classesCollection = "Classes";
  static const String nameKey = "name";
  static const String photoKey = "photo";
  static const String codeKey = "code";
  static const String isPrivateKey = "isPrivate";
  static const String membersKey = "members";
  static const String announcementsKey = "announcements";
  static const String descriptionKey = "description";
  static const String discussionsKey = "discussions";
  static const String eventsKey = "events";

  static const String membersCollection = "Members";
  static const String roleKey = "role";
  static const String personIDKey = "personID";
  static const String classKey = "classID";
  static const String conversationLastSeenKey = "conversationLastSeen";

  static const String discussionsCollection = "Discussions";
  static const String discussionNameKey = "name";
  static const String discussionMembersKey = "members";
  static const String messagesKey = "messages";
  static const String mostRecentUpdateKey = "mostRecentUpdate";

  late FirebaseFirestore _storage;

  HomepageFirebaseAccessor() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getClasses(String userID, FirebaseListener listener) async {
    QuerySnapshot allClasses =
        await _storage.collection(classesCollection).get();
    List returnValues = [];
    for (QueryDocumentSnapshot snap in allClasses.docs) {
      print(snap.data());
      ClassRole role = ClassRole.nonMember;
      QuerySnapshot memberInfo = await _storage
          .collection(membersCollection)
          .where(classKey, isEqualTo: snap.id)
          .where(personIDKey, isEqualTo: userID)
          .get();
      if (memberInfo.docs.isNotEmpty) {
        role = ClassRole.getRole(memberInfo.docs.elementAt(0).get(roleKey));
      }
      returnValues.insert(
          (role == ClassRole.nonMember && returnValues.isNotEmpty)
              ? returnValues.length - 1
              : 0,
          ClassItem((snap.get(photoKey) as List).cast<int>(), snap.get(nameKey),
              role, snap.get(descriptionKey), snap.id));
    }
    listener.onSuccess(returnValues);
  }

  Future<void> isClassPrivate(String classID, FirebaseListener listener) async {
    DocumentSnapshot classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List potentialCode = [];
    if (classInfo.get(isPrivateKey)) {
      potentialCode.add(classInfo.get(codeKey));
    }
    listener.onSuccess(potentialCode);
  }

  Future<void> joinClass(String userID, String classID, String code,
      UserRole userRole, FirebaseListener listener) async {
    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    if (classInfo.get(codeKey) != code) {
      listener.onFailure("Not the right code.");
      return;
    }
    QuerySnapshot<Map<String, dynamic>> potentialMemberInfo = await _storage
        .collection(membersCollection)
        .where(personIDKey, isEqualTo: userID)
        .where(classKey, isEqualTo: classID)
        .get();

    DocumentReference memberID;
    String classRole = (userRole == UserRole.owner)
        ? ClassRole.owner.name
        : ClassRole.member.name;
    if (potentialMemberInfo.docs.isNotEmpty) {
      Map<String, dynamic> oldData =
          potentialMemberInfo.docs.elementAt(0).data();
      oldData[roleKey] = classRole;
      memberID = potentialMemberInfo.docs.elementAt(0).reference;
      _storage.collection(membersCollection).doc(memberID.id).update(oldData);
    } else {
      Map<String, dynamic> newData = Map<String, dynamic>();
      print("classID");
      newData.putIfAbsent(personIDKey, () => userID);
      newData.putIfAbsent(classKey, () => classID);
      newData.putIfAbsent(roleKey, () => classRole);
      newData.putIfAbsent(
          conversationLastSeenKey, () => Map<String, Timestamp>());
      memberID = (await _storage.collection(membersCollection).add(newData));
    }
    DocumentSnapshot<Map<String, dynamic>> member =
        await _storage.collection(membersCollection).doc(memberID.id).get();
    Map<String, dynamic> classData = classInfo.data()!;

    List<DocumentReference> listOfCurrentMembers =
        (classData[membersKey] as List).cast<DocumentReference>();
    print(listOfCurrentMembers.toString() + " == members");
    for (int i = 0; i < listOfCurrentMembers.length; i++) {
      print("creating discussions");
      createDiscussion(memberID, listOfCurrentMembers[i], classID);
    }

    (classData[membersKey] as List)
        .cast<DocumentReference>()
        .add(member.reference);
    await _storage.collection(classesCollection).doc(classID).update(classData);
    listener.onSuccess([member.id, member.get(roleKey)]);
  }

  Future<void> createClass(String userID, String name, String desc,
      bool isPrivate, FirebaseListener listener) async {
    Map<String, dynamic> memberData = Map<String, dynamic>();
    memberData.putIfAbsent(personIDKey, () => userID);
    memberData.putIfAbsent(roleKey, () => ClassRole.owner.name);
    memberData.putIfAbsent(
        conversationLastSeenKey, () => Map<String, DocumentReference>());
    DocumentReference memberIncompleteInfo =
        await _storage.collection(membersCollection).add(memberData);

    Map<String, dynamic> newData = Map<String, dynamic>();
    ByteData data = await rootBundle.load("assets/images/basicProfile.png");
    newData.putIfAbsent(photoKey, () => data.buffer.asUint8List());
    newData.putIfAbsent(nameKey, () => name);
    newData.putIfAbsent(isPrivateKey, () => isPrivate);
    newData.putIfAbsent(descriptionKey, () => desc);
    newData.putIfAbsent(codeKey, () => _generateRandomCode());
    newData.putIfAbsent(discussionsKey, () => <DocumentReference>[]);
    newData.putIfAbsent(announcementsKey, () => <DocumentReference>[]);
    newData.putIfAbsent(eventsKey, () => <DocumentReference>[]);
    newData.putIfAbsent(
        membersKey, () => <DocumentReference>[memberIncompleteInfo]);
    DocumentReference classInfo =
        await _storage.collection(classesCollection).add(newData);
    DocumentSnapshot userData =
        await _storage.collection(usersCollection).doc(userID).get();
    List<DocumentReference> classList =
        (userData.get(classesKey) as List).cast<DocumentReference>();
    classList.add(classInfo);
    Map<String, dynamic> newInfo = Map<String, dynamic>();
    newInfo.putIfAbsent(classesKey, () => classList);
    _storage.collection(usersCollection).doc(userID).update(newInfo);

    memberData.putIfAbsent(classKey, () => classInfo.id);
    await _storage
        .collection(membersCollection)
        .doc(memberIncompleteInfo.id)
        .update(memberData);

    listener.onSuccess([classInfo.id]);
  }

  String _generateRandomCode() {
    String characterSource =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#\$%^&*()";
    String code = "";
    for (int i = 0; i < 10; i++) {
      int random = Random().nextInt(characterSource.length);
      code += String.fromCharCode(characterSource.codeUnitAt(random));
    }
    return code;
  }

  Future<void> createDiscussion(DocumentReference firstMemberID,
      DocumentReference secondMemberID, String classID) async {
    QuerySnapshot firstMemberDocs = await _storage
        .collection(discussionsCollection)
        .where(discussionMembersKey, arrayContains: firstMemberID)
        .get();
    if (firstMemberDocs.docs.isNotEmpty) {
      for (QueryDocumentSnapshot firstMemberInfo in firstMemberDocs.docs) {
        List<DocumentReference> memberIDs =
            (firstMemberInfo.get(discussionMembersKey) as List)
                .cast<DocumentReference>();
        if (memberIDs[0] == secondMemberID || memberIDs[1] == secondMemberID) {
          return;
        }
      }
    }
    DocumentSnapshot<Map<String, dynamic>> firstMemberInfo = await _storage
        .collection(membersCollection)
        .doc(firstMemberID.id)
        .get();
    DocumentSnapshot<Map<String, dynamic>> secondMemberInfo = await _storage
        .collection(membersCollection)
        .doc(secondMemberID.id)
        .get();

    DocumentSnapshot firstUserInfo = await _storage
        .collection(usersCollection)
        .doc(firstMemberInfo.get(personIDKey))
        .get();
    DocumentSnapshot secondUserInfo = await _storage
        .collection(usersCollection)
        .doc(secondMemberInfo.get(personIDKey))
        .get();

    String firstUsername =
        firstUserInfo.get(usernameKey).toString().split(" ").first;
    String secondUsername =
        secondUserInfo.get(usernameKey).toString().split(" ").first;

    String convoName = firstUsername + " and " + secondUsername;
    Map<String, dynamic> newConvoData = Map<String, dynamic>();
    newConvoData.putIfAbsent(discussionNameKey, () => convoName);
    newConvoData.putIfAbsent(messagesKey, () => <DocumentReference>[]);
    newConvoData.putIfAbsent(discussionMembersKey,
        () => [firstMemberInfo.reference, secondMemberInfo.reference]);
    newConvoData.putIfAbsent(mostRecentUpdateKey, () => Timestamp.now());
    DocumentReference convoRef =
        await _storage.collection(discussionsCollection).add(newConvoData);

    Map<String, Timestamp> firstMembersConvos =
        (firstMemberInfo.get(conversationLastSeenKey) as Map)
            .cast<String, Timestamp>();
    firstMembersConvos.putIfAbsent(convoRef.id, () => Timestamp.now());
    Map<String, Timestamp> secondMembersConvos =
        (secondMemberInfo.get(conversationLastSeenKey) as Map)
            .cast<String, Timestamp>();
    secondMembersConvos.putIfAbsent(convoRef.id, () => Timestamp.now());
    _storage
        .collection(membersCollection)
        .doc(firstMemberID.id)
        .update({conversationLastSeenKey: firstMembersConvos});
    _storage
        .collection(membersCollection)
        .doc(secondMemberID.id)
        .update({conversationLastSeenKey: secondMembersConvos});

    DocumentSnapshot<Map<String, dynamic>> classesInfo =
        await _storage.collection(classesCollection).doc(classID).get();
    List<DocumentReference> discussions =
        (classesInfo.get(discussionsKey) as List).cast<DocumentReference>();
    discussions.add(convoRef);
    _storage
        .collection(classesCollection)
        .doc(classID)
        .update({discussionsKey: discussions});
  }

  Future<void> isAMember(
      String userId, String classId, FirebaseListener firebaseListener) async {
    QuerySnapshot memberInfo = await _storage
        .collection(membersCollection)
        .where(personIDKey, isEqualTo: userId)
        .where(classKey, isEqualTo: classId)
        .get();

    List returnValues = [];
    if (memberInfo.docs.isNotEmpty) {
      if (ClassRole.getRole(memberInfo.docs[0].get(roleKey)) !=
          ClassRole.nonMember) {
        returnValues.add(memberInfo.docs.first.id);
        returnValues.add(memberInfo.docs.first.get(roleKey));
      }
    }
    firebaseListener.onSuccess(returnValues);
  }
}
