import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edunciate/classroom/items/message_item.dart';
import 'package:edunciate/firebaseAccessor/discussions_firebase.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/firebaseAccessor/indiv_conversation_firebase.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/member_item.dart';
import 'package:flutter/material.dart';

import 'individualMessagesScreen.dart';

class ConversationList extends StatefulWidget {
  String name;
  String time;
  bool isMessageRead;
  String discussionID;
  String currentUserID;
  String currentMemberID;
  DisplayWidgetListener widgetListener;

  ConversationList(this.discussionID, this.currentUserID, this.currentMemberID,
      this.widgetListener,
      {required this.name, required this.time, required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState(
      discussionID, currentUserID, currentMemberID, this.widgetListener);
}

class _ConversationListState extends State<ConversationList> {
  String discussionID;
  String currentUserID;
  String currentMemberID;
  DisplayWidgetListener widgetListener;

  _ConversationListState(this.discussionID, this.currentUserID,
      this.currentMemberID, this.widgetListener);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        IndivConversationFirebase().getParticipants(
            discussionID,
            FirebaseListener((users) {
              ChatUser activeUser;
              ChatUser otherUser;
              if ((users[0] as ChatUser).id == currentUserID) {
                activeUser = users[0];
                otherUser = users[1];
              } else {
                otherUser = users[0];
                activeUser = users[1];
              }
              // print(currentUserID);
              print(activeUser.id + " , " + otherUser.id);
              ClassDiscussionsFirebase()
                  .onDiscussionOpened(currentMemberID, discussionID);
              IndivConversationFirebase().getItems(
                  discussionID,
                  FirebaseListener((messages) {
                    List<ChatMessage> chatMessages = [];
                    for (int i = 0; i < messages.length; i++) {
                      MessageItem currentItem = messages[i];
                      print(currentItem.getId());
                      bool madeByUser = currentItem.getId() == activeUser.id;
                      chatMessages.insert(
                          0,
                          ChatMessage(
                              user: (madeByUser) ? activeUser : otherUser,
                              createdAt: currentItem.getTimeSent().toDate(),
                              text: currentItem.getContent()));
                    }
                    Navigator.push(
                      widgetListener.getContext(),
                      MaterialPageRoute(
                          builder: (context) => MessagesScreen(activeUser,
                              otherUser, discussionID, chatMessages)),
                    );
                  }, (eMessage) {}));
            }, (error) {}));
      },
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        maxRadius: 20,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
            SizedBox(height: 6),
            Divider(color: Colors.deepPurple)
          ])),
    );
  }
}
