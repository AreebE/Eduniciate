// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_local_variable, must_be_immutable, no_logic_in_create_state

import 'package:edunciate/signUpScreen/registration_alternator.dart';
import 'package:flutter/material.dart';
import 'package:edunciate/signUpScreen/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LogInScreen extends StatelessWidget {
  RegistrationListener listener;

  LogInScreen(this.listener, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   title: 'Flutter Demo',
        //   home: Scaffold(
        //     appBar: AppBar(
        //       title: Row(children: <Widget>[
        //         Text('Edunicate',
        //             style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans')),
        //         Spacer(),
        //         Text('Login',
        //             style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans'))
        //       ]),
        //       backgroundColor: Color(0xffF9461E1),
        //     ),
        // body:
        Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text('Edunicate',
              style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans')),
          Spacer(),
          Text('Login',
              style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans'))
        ]),
        backgroundColor: Color(0xffF9461E1),
      ),
      body: MyCustomForm(listener),
    );
    // MyCustomForm()
    // ,
    // ));
    // ;
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm(this.listener, {super.key});
  RegistrationListener listener;

  @override
  State<MyCustomForm> createState() => _MyCustomFormState(listener);
}

class _MyCustomFormState extends State<MyCustomForm> {
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
  final RegistrationListener listener;
  _MyCustomFormState(this.listener);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailLogin.dispose();
    passwordLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EmailPasswordBox('Email'),
          Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 30,
              width: MediaQuery.of(context).size.width * .80,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: emailLogin)),
          EmailPasswordBox('Password'),
          Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 30,
              width: MediaQuery.of(context).size.width * .80,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: passwordLogin)),
          SizedBox(height: 30),
          SizedBox(
            height: 30,
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                LoginHelp(context, emailLogin.text, passwordLogin.text);
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffF5A2E9C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0))),
              child: Text(
                'Log in',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Lato', color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffF5A2E9C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0))),
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                          color: Colors.white)))),
          AlternateButtons('OR', 'SIGN UP WITH GOOGLE', listener),
          AlternateButtons(
              'DON\'T HAVE AN ACCOUNT?', 'CONTINUE TO SIGN UP PAGE', listener),
        ],
      ),
    ));
  }
}

Future<bool> passwordReset(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    showAlertDialog(context, 'PROBLEM WITH EMAIL',
        'Try to make sure your email is typed correctly!');
    return false;
  }
  return true;
}

forgotPasswordDialog(BuildContext context) {
  final emailController = TextEditingController();

  Widget emailGetter = Container(
      decoration: BoxDecoration(border: Border.all()),
      height: 30,
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: emailController));

  Widget submit = TextButton(
    child: Text("Submit"),
    onPressed: () {
      passwordReset(context, emailController.text);
    },
  );

  AlertDialog alert = AlertDialog(
      title: Text(
          'Type in you email and we will send a password reset link to your email.'),
      actions: [emailGetter, submit]);

  // show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

class EmailPasswordBox extends StatelessWidget {
  EmailPasswordBox(this.aboveText);
  final String aboveText;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(height: 30),
        SizedBox(
            width: MediaQuery.of(context).size.width * .80,
            child: Text(
              aboveText,
              style: TextStyle(fontSize: 15, fontFamily: 'Lato'),
              textAlign: TextAlign.left,
            )),
      ],
    ));
  }
}

class AlternateButtons extends StatelessWidget {
  AlternateButtons(this.specifier, this.buttonText, this.listener);
  final String specifier;
  final String buttonText;
  final RegistrationListener listener;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(height: 30),
        Divider(color: Colors.black),
        Text(specifier, style: TextStyle(fontSize: 15, fontFamily: 'Lato')),
        Container(height: 15),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * .80,
            child: ElevatedButton(
                onPressed: () {
                  if (buttonText == 'CONTINUE TO SIGN UP PAGE') {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignUpScreen()));
                    listener.setRegState(RegistrationState.signUp);
                  } else if (buttonText == 'SIGN IN WITH GOOGLE') {
                    signInWithGoogle();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffF9461E1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0))),
                child: Text(buttonText,
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'Lato', color: Colors.white),
                    textAlign: TextAlign.left))),
      ],
    ));
  }
}

Future<bool> LoginHelp(
    BuildContext context, String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showAlertDialog(context, 'USER NOT FOUND',
          'Please check that your email address is typed correctly');
    } else if (e.code == 'wrong-password') {
      showAlertDialog(context, 'PASSWORD WRONG',
          'Please check that your password is typed corrrectly');
    }
  }
  return true;
}
