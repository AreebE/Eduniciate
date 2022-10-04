import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../firebaseAccessor/homepage_firebase.dart';

class CreateClassScreen extends StatelessWidget {
  String userId;
  CreateClassScreen(this.userId, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MyClassCreate(userId),
        ));
  }
}

class MyClassCreate extends StatefulWidget {
  String userID;
  MyClassCreate(this.userID);

  @override
  State<MyClassCreate> createState() => _MyClassCreate(userID);
}

class _MyClassCreate extends State<MyClassCreate> {
  String userID;
  bool privateClass = true;
  String finalClassName = "";
  String finalClassDescription = "";

  _MyClassCreate(this.userID);

  TextEditingController className = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    className.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text('Create New Group',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Divider(color: Color.fromARGB(255, 43, 22, 79), thickness: 0.5),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.height * 0.12,
                child: Image.asset("assets/images/basicProfile.png"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //       primary: Theme.of(context).scaffoldBackgroundColor,
              //       elevation: 0.0,
              //       shadowColor: Colors.transparent),
              //   child: Text("Edit Profile Picture",
              //       style: TextStyle(
              //           fontSize: 17, fontFamily: 'Lato', color: Colors.black)),
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                  width: MediaQuery.of(context).size.width * .80,
                  child: Text('Class Name',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left)),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  height: 35,
                  width: MediaQuery.of(context).size.width * .80,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: className,
                        decoration: InputDecoration(
                          hintText: ' e.g. Physics Club, TSA, Tennis Club',
                          isCollapsed: true,
                        ),
                        onChanged: ((value) {
                          finalClassName = value;
                          print(finalClassName);
                        }),
                      ))),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                  width: MediaQuery.of(context).size.width * .80,
                  child: Text('Class Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left)),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.width * .40,
                  width: MediaQuery.of(context).size.width * .80,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                          minLines: 1,
                          maxLines: 8,
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.center,
                          controller: description,
                          onChanged: (value) {
                            finalClassDescription = value;
                          },
                          decoration: InputDecoration(
                              hintText:
                                  'Tell members what your group is about!\n Min: 1, Max: 300')))),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor)),
              Container(
                  color: Colors.white,
                  child: TextButton(
                      onPressed: () {
                        privateClass = !privateClass;
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).scaffoldBackgroundColor,
                          elevation: 0.0,
                          shadowColor: Colors.transparent),
                      child: Text(
                          (privateClass) ? "Make Public" : "Make Private",
                          style: TextStyle(color: Colors.deepPurple)))),
              Container(
                  height: 10,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor)),

              Container(
                color: Colors.white,
                child: ElevatedButton(
                    onPressed: () {
                      print(finalClassName + " = finale");
                      HomepageFirebaseAccessor().createClass(
                          userID,
                          finalClassName,
                          finalClassDescription,
                          privateClass,
                          FirebaseListener((values) {
                            Navigator.pop(context, values[0]);
                          }, (message) {}));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0.0,
                        shadowColor: Colors.transparent),
                    child: Text("Create Class",
                        style: TextStyle(color: Colors.deepPurple))),
              ),
            ])));
  }
}

Container displayCodeLetter(String codeLetter) {
  return Container(
      height: 30,
      width: 30,
      child: Text(codeLetter,
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'Josefin Sans',
              fontWeight: FontWeight.w600,
              color: Colors.black)));
}

String codeGenerator() {
  String code = ""; //have to save in firebase
  String alphabet = "abcdefghijklmnopqrstuvwxyz";
  Random random = new Random();
  for (int num = 0; num < 8; num++) {
    if (num % 2 == 1) {
      code += alphabet[random.nextInt(26)];
    } else {
      int randomNumber = random.nextInt(10);
      code += randomNumber.toString();
    }
  }
  return code;
}
