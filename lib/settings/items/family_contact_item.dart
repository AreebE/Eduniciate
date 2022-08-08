import 'package:edunciate/settings/res/strings.dart';

enum Relationship { mom, dad, guardian, parent }

extension RelationshipString on Relationship {
  String get stringRep {
    switch (this) {
      case Relationship.mom:
        return StringList.mom;
      case Relationship.dad:
        return StringList.dad;
      case Relationship.guardian:
        return StringList.guardian;
      case Relationship.parent:
        return StringList.parent;
    }
  }
}

class FamilyContact {
  String _firstName;
  String _lastName;
  Relationship _relationship;
  String _phoneNumber;

  FamilyContact(
      this._firstName, this._lastName, this._relationship, this._phoneNumber);

  String getName() {
    return _firstName + "\n" + _lastName;
  }

  String getRelationship() {
    return _relationship.stringRep;
  }

  String getPhoneNumber() {
    return _phoneNumber;
  }

  static Relationship relation(String type) {
    switch (type) {
      case StringList.mom:
        return Relationship.mom;
      case StringList.dad:
        return Relationship.dad;
      case StringList.guardian:
        return Relationship.guardian;
      case StringList.parent:
        return Relationship.parent;
    }
    return Relationship.parent;
  }
}
