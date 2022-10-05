import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/updates_firebase.dart';
import 'package:flutter/material.dart';

import '../../homepage/items/class_item.dart';
import 'announcement_item.dart';

class AnnouncementsScreen extends StatefulWidget {
  List<ChatMessage> _messages;
  ChatUser _thisUser;
  ClassRole _role;
  String _classID;
  String _userID;

  AnnouncementsScreen(
      this._messages, this._thisUser, this._role, this._classID, this._userID);

  @override
  State createState() => _AnnouncementsScreenState(
      _messages, this._thisUser, this._role, this._classID, this._userID);
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  List<ChatMessage> _messages;
  ChatUser _thisUser;
  ClassRole _role;
  String _classID;
  String _userID;

  _AnnouncementsScreenState(
      this._messages, this._thisUser, this._role, this._classID, this._userID);

  @override
  Widget build(BuildContext context) {
    String title = "Announcements";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(title),
      ),
      body: DashChat(
        readOnly: _role == ClassRole.member,
        currentUser: _thisUser,
        messageOptions: MessageOptions(
            currentUserContainerColor: CustomColorScheme.defaultColors
                .getColor(CustomColorScheme.darkPrimary)),
        onSend: (ChatMessage m) {
          setState(() {
            _messages.add(m);
            AnnouncementItem item = AnnouncementItem(
                m.text,
                m.user.firstName! + " " + m.user.lastName!,
                Timestamp.fromDate(m.createdAt),
                _userID,
                "",
                _classID);
            UpdatesFirebaseAccessor().addAnnouncement(item);
          });
        },
        messages: _messages,
      ),
    );
  }
}
