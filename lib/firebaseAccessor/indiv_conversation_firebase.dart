import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edunciate/classroom/discussion/ChatPage.dart';
import 'package:edunciate/classroom/items/message_item.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class IndivConversationFirebase {
  static const String messageCollection = "Messages";
  static const String contentKey = "content";
  static const String senderKey = "sender";
  static const String timeSentKey = "timeSent";

  static const String discussionCollection = "Discussions";
  static const String nameKey = "name";
  static const String descriptionKey = "description";
  static const String messagesKey = "messages";
  static const String classesKey = "class";
  static const String discussionMembersKey = "members";
  static const String mostRecentUpdateKey = "mostRecentUpdate";

  static const String usersCollection = "Users";
  static const String usernameKey = "name";

  static const String membersCollection = "Members";
  static const String personIDKey = "personID";

  late FirebaseFirestore _storage;

  IndivConversationFirebase() {
    _storage = FirebaseFirestore.instance;
  }

  Future<void> getItems(String convoID, FirebaseListener listener) async {
    DocumentSnapshot<Map<String, dynamic>> discussion =
        await _storage.collection(discussionCollection).doc(convoID).get();
    List<DocumentReference> messages =
        (discussion.get(messagesKey) as List).cast<DocumentReference>();

    List returnValues = [];
    for (int i = 0; i < messages.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> message = await _storage
          .collection(messageCollection)
          .doc(messages.elementAt(i).id)
          .get();
      returnValues.add(MessageItem(message.get(timeSentKey),
          message.get(senderKey), message.get(contentKey)));
    }
    listener.onSuccess(returnValues);
  }

  Future<void> addMessage(String classID, MessageItem message) async {
    Map<String, dynamic> newData = Map();
    newData.putIfAbsent(contentKey, () => message.getContent());
    newData.putIfAbsent(senderKey, () => message.getId());
    newData.putIfAbsent(timeSentKey, () => message.getTimeSent());
    DocumentReference messageRef =
        await _storage.collection(messageCollection).add(newData);

    DocumentSnapshot<Map<String, dynamic>> classInfo =
        await _storage.collection(discussionCollection).doc(classID).get();
    Map<String, dynamic> classData = classInfo.data()!;
    List<DocumentReference> messageList =
        (classData[messagesKey] as List).cast<DocumentReference>();
    messageList.add(messageRef);
    classData[mostRecentUpdateKey] = message.getTimeSent();
    _storage.collection(discussionCollection).doc(classID).update(classData);
  }

  Future<void> getParticipants(
      String discussionID, FirebaseListener listener) async {
    List<ChatUser> users = [];
    DocumentSnapshot user =
        await _storage.collection(discussionCollection).doc(discussionID).get();
    List<DocumentReference> discussionMembers =
        (user.get(discussionMembersKey) as List).cast<DocumentReference>();
    for (int i = 0; i < discussionMembers.length; i++) {
      DocumentReference discussionMemberID = discussionMembers[i];
      DocumentSnapshot member = await _storage
          .collection(membersCollection)
          .doc(discussionMemberID.id)
          .get();
      DocumentSnapshot user = await _storage
          .collection(usersCollection)
          .doc(member.get(personIDKey))
          .get();
      List<String> splitName = user.get(nameKey).toString().split(" ");
      users.add(ChatUser(
          id: user.id, firstName: splitName.first, lastName: splitName.last));
    }
    List<String> splitName = (user.get(nameKey) as String).split(" ");
    // print(users[0].id + ", " + users[1].id);
    listener.onSuccess(users);
  }
}
