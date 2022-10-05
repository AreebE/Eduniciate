// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_local_variable, must_be_immutable, no_logic_in_create_state

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/firebaseAccessor/users_firebase.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/signUpScreen/registration_alternator.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebaseAccessor/homepage_firebase.dart';
import '../homepage/class_list_tile.dart';
import '../homepage/items/class_item.dart';

class ClickListener {
  createUserPopup(UserCredential info) {}
}

class SignUpScreen extends StatelessWidget {
  SignUpScreen(this.listener, {Key? key}) : super(key: key);
  RegistrationListener listener;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().whenComplete(() {
      // HomepageFirebaseAccessor().createClass(
      //     userID, "EEEEEEEE", FirebaseListener((items) {}, (message) {}));
    });
    return MaterialApp(
        title: 'LEAP',
        home: Scaffold(
          body: MyCustomForm(listener),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm(this.listener, {super.key});
  RegistrationListener listener;

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm>
    implements ClickListener, DisplayWidgetListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/images/purple2.jpeg", fit: BoxFit.fill),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text('Welcome to Leap!',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w600)),
                    Divider(color: Colors.black),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text('New user?',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    AlternateButtons('Sign up with Google', this, this),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  ])))
        ]));
  }

  void createUserPopup(UserCredential info) {
    String pronouns = "";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Confirm"))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sorry, seems like you're new here! What are your pronouns?",
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
                    pronouns = value;
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
        }).then((value) {
      UsersFirebaseAccessor().createNewUser(
          info.user!.email!,
          "",
          pronouns,
          info.user!.displayName!,
          FirebaseListener((id) {
            HomepageFirebaseAccessor().getClasses(
                id[0],
                FirebaseListener((classes) {
                  List<ClassList> items = [];
                  for (int i = 0; i < classes.length; i++) {
                    ClassItem item = classes[i] as ClassItem;
                    items.insert(
                        0,
                        ClassList(
                            item.getClassName(),
                            item.getDesc(),
                            item.getID(),
                            id[0],
                            UserRole.student,
                            item.getImage(),
                            this));
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return MainDisplay(items, id[0], UserRole.student);
                  }))).then((value) {
                    GoogleSignIn().disconnect();
                    FirebaseAuth.instance.signOut();
                  });
                }, (message) {}));
          }, (message) {}));
    });
  }

  @override
  BuildContext getContext() {
    return context;
  }
}

class AlternateButtons extends StatelessWidget {
  final String buttonText;
  ClickListener listener;
  DisplayWidgetListener widgetListener;

  AlternateButtons(this.buttonText, this.listener, this.widgetListener);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .06,
          width: MediaQuery.of(context).size.width * .7,
          child: ElevatedButton(
            onPressed: () {
              signInWithGoogle().then((value) async {
                await UsersFirebaseAccessor().doesUserExist(
                    value.user!.email!,
                    FirebaseListener((result) {
                      if (result.isEmpty) {
                        listener.createUserPopup(value);
                      } else {
                        HomepageFirebaseAccessor().getClasses(
                            result[0],
                            FirebaseListener((classes) {
                              List<ClassList> items = [];
                              for (int i = 0; i < classes.length; i++) {
                                ClassItem item = classes[i] as ClassItem;
                                items.insert(
                                    0,
                                    ClassList(
                                        item.getClassName(),
                                        item.getDesc(),
                                        item.getID(),
                                        result[0],
                                        UserRole.student,
                                        item.getImage(),
                                        widgetListener));
                              }
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return MainDisplay(items, result[0],
                                    UserRole.getRole(result[1]));
                              }))).then((value) {
                                GoogleSignIn().disconnect();
                                FirebaseAuth.instance.signOut();
                              });
                            }, (message) {}));
                      }
                    }, (message) {}));
              });
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                side: BorderSide(color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/google_logo.png'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(buttonText,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        color: Colors.black))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  String accountType = "";
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // print("f");
  // Create a new credential

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
