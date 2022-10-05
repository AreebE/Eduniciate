import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/firebaseAccessor/members_firebase.dart';
import 'package:flutter/material.dart';

import 'homepage/items/class_item.dart';

class MemberItem {
  String _name;
  String _userID;
  String _memberID;
  ClassRole _role;
  Map<String, Timestamp> _convoTimestamps;
  late MemoryImage _profilePic;
  late MembersFirebaseAccessor membersAccessor;

  MemberItem(this._name, this._userID, this._memberID, this._role,
      List<int> photoBytes, this._convoTimestamps) {
    Uint8List photoInBytes = Uint8List.fromList(photoBytes);
    _profilePic = MemoryImage(photoInBytes);
    membersAccessor = MembersFirebaseAccessor();
  }

  String getName() {
    return _name;
  }

  String getUserID() {
    return _userID;
  }

  ClassRole getRole() {
    return _role;
  }

  MemoryImage getPicture() {
    return _profilePic;
  }

  Map<String, Timestamp> getConvoTimestamps() {
    return _convoTimestamps;
  }

  String getMemberID() {
    return _memberID;
  }

  void updateRole(ClassRole newRole) {
    _role = newRole;
    membersAccessor.updateRole(_memberID, newRole);
  }
}
