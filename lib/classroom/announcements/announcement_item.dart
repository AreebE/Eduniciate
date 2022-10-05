import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../discussion/chatUserModels.dart';

class AnnouncementItem {
  String _content;
  String _senderName;
  Timestamp _sendTime;
  String _senderID;
  String _title;
  String _classID;
  late ChatUser sender;

  AnnouncementItem(this._content, this._senderName, this._sendTime,
      this._senderID, this._title, this._classID) {
    sender = ChatUser(
        id: _senderID,
        firstName: _senderName.split(" ")[0],
        lastName: _senderName.split(" ")[1]);
  }

  String getContent() {
    return _content;
  }

  String getSenderName() {
    return _senderName;
  }

  String getSenderID() {
    return _senderID;
  }

  String getTitle() {
    return _title;
  }

  Timestamp getSendtime() {
    return _sendTime;
  }

  String getClassID() {
    return _classID;
  }

  ChatMessage toMessage() {
    return ChatMessage(
        user: sender, createdAt: _sendTime.toDate().toLocal(), text: _content);
  }
}
