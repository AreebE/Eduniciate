import 'dart:typed_data';

import 'package:edunciate/firebaseAccessor/details_firebase.dart';
import 'package:flutter/cupertino.dart';

class ClassDetailsItem {
  String _classID;
  String _name;
  String _desc;
  String _code;
  bool _isPrivate;
  late MemoryImage _photo;

  late ClassDetailsFirebaseAccessor _detailsFirebase;

  ClassDetailsItem(this._classID, this._name, this._isPrivate, this._desc,
      Uint8List photoBytes, this._code) {
    _photo = MemoryImage(photoBytes);
    _detailsFirebase = ClassDetailsFirebaseAccessor();
  }

  String getName() {
    return _name;
  }

  String getDesc() {
    return _desc;
  }

  bool isPrivate() {
    return _isPrivate;
  }

  MemoryImage getPhoto() {
    return _photo;
  }

  String getCode() {
    return _code;
  }

  void updateName(String newName) {
    this._name = newName;
    _detailsFirebase.updateName(_classID, _name);
  }

  void updateDesc(String newDesc) {
    this._desc = newDesc;
    _detailsFirebase.updateDesc(_classID, _desc);
  }

  void updatePrivacy(bool newPrivacy) {
    this._isPrivate = newPrivacy;
    _detailsFirebase.updatePrivacy(_classID, _isPrivate);
  }

  void updatePhoto(MemoryImage newPhoto) {
    this._photo = newPhoto;
    _detailsFirebase.updatePhoto(_classID, newPhoto.bytes);
  }
}
