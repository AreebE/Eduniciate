import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edunciate/classroom/items/message_item.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/indiv_conversation_firebase.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  ChatUser thisUser;
  ChatUser otherUser;
  String discussionID;
  List<ChatMessage> messages;

  MessagesScreen(
      this.thisUser, this.otherUser, this.discussionID, this.messages);

  @override
  _MessagesScreenState createState() =>
      _MessagesScreenState(thisUser, otherUser, discussionID, messages);
}

class _MessagesScreenState extends State<MessagesScreen> {
  ChatUser thisUser;
  ChatUser otherUser;
  String discussionID;
  List<ChatMessage> messages;

  _MessagesScreenState(
      this.thisUser, this.otherUser, this.discussionID, this.messages);

  @override
  Widget build(BuildContext context) {
    String title = otherUser.firstName! + " " + otherUser.lastName!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(title),
      ),
      body: DashChat(
        messageOptions: MessageOptions(
            currentUserContainerColor: CustomColorScheme.defaultColors
                .getColor(CustomColorScheme.darkPrimary)),
        currentUser: thisUser,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
            MessageItem item = MessageItem(
                Timestamp.fromDate(m.createdAt), thisUser.id, m.text);
            IndivConversationFirebase().addMessage(discussionID, item);
          });
        },
        messages: messages,
      ),
    );
  }
}
