import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementItem {
  String _content;
  String _senderName;
  Timestamp _sendTime;
  String _senderID;
  String _title;
  String _classID;

  AnnouncementItem(this._content, this._senderName, this._sendTime,
      this._senderID, this._title, this._classID) {}

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
}
