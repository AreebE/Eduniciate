//Rishitha Ravi
//Code for displaying people/members in individual class screens

import 'dart:html';

import 'package:edunciate/firebaseAccessor/details_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../firebaseAccessor/homepage_firebase.dart';

class ClassList extends StatelessWidget {
  late String title;
  late String description;
  String classId;
  String userId;
  UserRole role;
  MemoryImage image;

  ClassList(this.title, this.classId, this.userId, this.description, this.role, this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
        child: Material(
            elevation: 1.5,
            shadowColor: Colors.grey,
            child: ListTile(
              onTap: (() {
                HomepageFirebaseAccessor()
                    .isAMember(userId, classId
                              FirebaseListener(
                                  (isMember)
                                  {
                                    if (isMember[0])
                                    {
                                        openClassPage();
                                    }
                                    else 
                                    {
                                        HomepageFirebaseAccessor().isClassPrivate(classId, FirebaseListener(
                                            (willGiveCode)
                                            {
                                                if (willGiveCode.isNotEmpty)
                                                {
                                                    String code = willGiveCode[0];
                                                    HomepageFirebaseAccessor()
                                                        .joinClass(
                                                            userId,
                                                            classId,
                                                            code,
                                                            role, 
                                                            FirebaseListener(
                                                                (values){
                                                                    openClassPage(values[0]);
                                                                },
                                                                (error){
                                                                    
                                                                }
                                                            )
                                                        );
                                                }
                                                else 
                                                {
                                                    
                                                }
                                            },
                                            (error)
                                            {
                                                
                                            }
                                        ));
                                    }
                                  },
                                  (error)
                                  {
                                      
                                  }
                              )
                              );
              }),
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              leading: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image(
                    height: 50.0,
                    width: 50.0,
                    image: image,
                  ),
                ),
              ]),
              title: Column(children: [
                Text(title,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: (FontWeight.bold),
                      fontSize: 18.0,
                    )),
                Text(description,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                    ))
              ]),
              tileColor: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                  side:
                      //BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
                      BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  borderRadius: BorderRadius.circular(2)),
              trailing: GestureDetector(
                  child: Icon(CupertinoIcons.ellipsis,
                      color: Color.fromARGB(255, 58, 27, 103)),
                  onTapDown: (details) => showPopupMenu(context, details)),
            )));
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
        PopupMenuItem<String>(child: const Text('Leave group'), value: '1'),
      ],
      elevation: 8.0,
    );

    (String itemSelected) {
      // ignore: unnecessary_null_comparison
      if (itemSelected == null) return;
      if (itemSelected == "1") {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text("Leave group"),
                content: Text("Are you sure you want to leave this group?"),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
                ],
                elevation: 24.0),
            barrierDismissible: true);
      } else {}
    };
  }

    void askForCode()
    {
        String code = "";
        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                      HomepageFirebaseAccessor()
                        .joinClass(
                            userId,
                            classId,
                            code,
                            role, 
                            FirebaseListener(
                                (values){
                                    Navigator.pop(context);
                                    openClassPage(values[0]);
                                },
                                (error){
                                    print("Need a valid code!");
                                }
                            )
                        );
                  },
                  child: Text("Confirm"))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You'll need a code to enter. Please enter here.",
                  style: FontStandards.getTextStyle(
                      CustomColorScheme.defaultColors,
                      Style.normHeader,
                      FontSize.medium),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  onChanged: ((value) {
                    code = value;
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          );
        });
    }
    
    void openClassPage(String memberID)
    {
         DetailsFirebaseAccessor()
             .getName(classId, FirebaseListener((name) {
                
             }, (message) {}));
    }
    
  Widget buildProfileIcon({
    required Color color,
  }) =>
      ClipRRect(
          child: Container(
        padding: EdgeInsets.all(.5),
        color: color,
      ));
}
