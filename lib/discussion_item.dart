import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DiscussionItem {
  String _discussionID;
  String _name;
  Timestamp _timeLastUpdated;
  late MemoryImage _profile;

  DiscussionItem(
      this._discussionID, this._name, this._timeLastUpdated, photoBytes) {
    _profile = MemoryImage(photoBytes);
  }

  String getDiscussionID() {
    return _discussionID;
  }

  String getName() {
    return _name;
  }

  MemoryImage getImage() {
    return _profile;
  }

  Timestamp getTimeLastUpdated() {
    return _timeLastUpdated;
  }
}
