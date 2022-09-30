// ignore_for_file: prefer_final_fields

import 'dart:typed_data';

import 'package:flutter/widgets.dart';

enum ClassRole {
  nonMember,
  member,
  owner;

  static ClassRole getRole(String name) {
    switch (name) {
      case "member":
        return ClassRole.member;
      case "owner":
        return ClassRole.owner;
      case "nonMember":
      default:
        return ClassRole.nonMember;
    }
  }
}

class ClassItem {
  late MemoryImage _icon;
  String _className;
  ClassRole _role;

  ClassItem(List<int> imageBytes, this._className, this._role) {
    Uint8List imageList = Uint8List.fromList(imageBytes);
    _icon = MemoryImage(imageList);
  }

  MemoryImage getImage() {
    return _icon;
  }

  String getClassName() {
    return _className;
  }

  ClassRole getRole() {
    return _role;
  }
}
