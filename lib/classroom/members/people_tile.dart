//Rishitha Ravi
//Code for displaying people/members in individual class screens

import 'dart:typed_data';

import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/firebaseAccessor/members_firebase.dart';
import 'package:edunciate/firebaseAccessor/personal_profile_firebase.dart';
import 'package:edunciate/firebaseAccessor/users_firebase.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/personal_profile/ineditable_profile_page.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Code for the listings of people

class PeopleTile extends StatefulWidget {
  late String title;
  final bool isOwner;
  MemoryImage image;
  String thisMemberID;
  ClassRole userRole;
  DisplayWidgetListener widgetListener;

  PeopleTile(this.title, this.isOwner, this.image, this.userRole,
      this.thisMemberID, this.widgetListener,
      {Key? key})
      : super(key: key);

  @override
  State<PeopleTile> createState() => _PeopleTileState(
      title, isOwner, image, userRole, thisMemberID, widgetListener);
}

class _PeopleTileState extends State<PeopleTile> {
  late String title;
  bool isOwner;
  MemoryImage image;
  String thisMemberID;
  ClassRole userRole;
  DisplayWidgetListener widgetListener;

  _PeopleTileState(this.title, this.isOwner, this.image, this.userRole,
      this.thisMemberID, this.widgetListener);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: ListTile(
          leading: Stack(
            children: [
              Image(
                image: image,
              ),
              if (isOwner)
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildOwnerIcon(Colors.white),
                )
            ],
          ),
          onTap: (() {
            PersonalProfileFirebaseAccessor().getUserInfoFromMember(
                thisMemberID,
                FirebaseListener((values) {
                  UserInfoItem user = UserInfoItem(
                      id: values[PersonalProfileFirebaseAccessor.idArrayKey],
                      imageBytes: Uint8List.fromList(values[
                          PersonalProfileFirebaseAccessor.photoArrayKey]),
                      name:
                          values[PersonalProfileFirebaseAccessor.nameArrayKey],
                      pronouns: values[
                          PersonalProfileFirebaseAccessor.pronounsArrayKey],
                      email:
                          values[PersonalProfileFirebaseAccessor.emailArrayKey],
                      about:
                          values[PersonalProfileFirebaseAccessor.bioArrayKey]);
                  Navigator.push(widgetListener.getContext(),
                      MaterialPageRoute(builder: (context) {
                    return MaterialApp(
                      home: Scaffold(
                        body: IneditableProfilePage(user),
                      ),
                    );
                  }));
                }, (message) {}));
          }),
          title: Text(title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color.fromARGB(255, 58, 27, 103),
                fontFamily: 'Lato',
                fontSize: 18.0,
              )),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
              borderRadius: BorderRadius.circular(5)),
          trailing: GestureDetector(
              child: const Icon(CupertinoIcons.ellipsis),
              onTapDown: (details) => showPopupMenu(context, details))),
    );
  }

  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy),
      items: [
        PopupMenuItem<String>(child: const Text('Promote'), value: '1'),
        PopupMenuItem<String>(child: const Text('Remove'), value: '2'),
      ],
      elevation: 8.0,
    );

    (String itemSelected) {
      // ignore: unnecessary_null_comparison
      if (itemSelected == null) return;
      if (itemSelected == "1" && userRole == ClassRole.owner) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text("Promote"),
                content: Text(isOwner
                    ? "Do you want to demote this member?"
                    : "Do you want to promote this member?"),
                actions: [
                  IconButton(
                      onPressed: () {
                        MembersFirebaseAccessor().updateRole(thisMemberID,
                            isOwner ? ClassRole.member : ClassRole.owner);
                        isOwner = !isOwner;
                        setState(() {});
                      },
                      icon: Icon(Icons.check)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
                ],
                elevation: 24.0),
            barrierDismissible: true);
      } else if (itemSelected == "2") {
      } else {}
    };
  }

  Widget buildOwnerIcon(Color color) => buildCircle(
      color: Colors.grey,
      all: 0.5,
      child: buildCircle(
        color: color,
        all: 0.5,
        child:
            Icon(Icons.star, color: Color.fromARGB(255, 58, 27, 103), size: 10),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ));
}
