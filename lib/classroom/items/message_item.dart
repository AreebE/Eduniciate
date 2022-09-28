import 'package:cloud_firestore/cloud_firestore.dart';

class MessageItem {
  Timestamp _timeSent;
  String _idOfSender;
  String _content;

  MessageItem(this._timeSent, this._idOfSender, this._content);

  String getId() {
    return _idOfSender;
  }

  String getContent() {
    return _content;
  }

  Timestamp getTimeSent() {
    return _timeSent;
  }
}
