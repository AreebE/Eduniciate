import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/discussion_item.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/member_item.dart';

class ClassDiscussionsFirebase {
  static const String discussionsCollection = "Discussions";
  static const String nameKey = "name";
  static const String discussionMembersKey = "members";
  static const String messagesKey = "messages";
  static const String mostRecentUpdateKey = "mostRecentUpdate";

  static const String membersCollection = "Members";
  static const String personIDKey = "personID";
  static const String conversationLastSeenKey = "conversationLastSeen";
  static const String roleKey = "role";

  static const String usersCollection = "Users";
  static const String photoKey = "photo";

  late FirebaseFirestore _storage;

  ClassDiscussionsFirebase() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getAllDiscussions(
      String memberID, FirebaseListener listener) async {
    DocumentSnapshot<Map<String, dynamic>> thisUserInfo =
        await _storage.collection(membersCollection).doc(memberID).get();
    ClassRole userRole =
        ClassRole.getRole(thisUserInfo.get(roleKey).toString());

    Map<String, Timestamp> convosLastSeen =
        (thisUserInfo.get(conversationLastSeenKey) as Map)
            .cast<String, Timestamp>();
    Iterable<String> convos = convosLastSeen.keys;
    List availableConvos = [];

    for (String convoID in convos) {
      DocumentSnapshot convoInfo =
          await _storage.collection(discussionsCollection).doc(convoID).get();
      List<DocumentReference> memberIDs =
          (convoInfo.get(discussionMembersKey) as List)
              .cast<DocumentReference>();

      DocumentReference otherPerson =
          (memberIDs.first.id == memberID) ? memberIDs.last : memberIDs.first;
      DocumentSnapshot otherMemberInfo = await _storage
          .collection(membersCollection)
          .doc(otherPerson.id)
          .get();

      ClassRole otherRole = ClassRole.getRole(otherMemberInfo.get(roleKey));

      if ((userRole == ClassRole.owner || otherRole == ClassRole.owner) &&
          otherRole != ClassRole.nonMember &&
          userRole != ClassRole.nonMember) {
        DocumentSnapshot otherUserInfo = await _storage
            .collection(usersCollection)
            .doc(otherMemberInfo.get(personIDKey))
            .get();
        availableConvos.add(DiscussionItem(
            convoID,
            convoInfo.get(nameKey),
            convoInfo.get(mostRecentUpdateKey),
            Uint8List.fromList(
                (otherUserInfo.get(photoKey) as List).cast<int>())));
      }
    }
    listener.onSuccess(availableConvos);
  }

  Future<void> onDiscussionOpened(String memberID, String discussionID) async {
    DocumentSnapshot memberInfo =
        await _storage.collection(membersCollection).doc(memberID).get();
    Map<String, Timestamp> convosLastSeen =
        (memberInfo.get(conversationLastSeenKey) as Map)
            .cast<String, Timestamp>();
    convosLastSeen[discussionID] = Timestamp.now();
    _storage
        .collection(membersCollection)
        .doc(memberInfo.id)
        .update({conversationLastSeenKey: convosLastSeen});
  }
}
