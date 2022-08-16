import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edunciate/signUpScreen/loginscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold (
        appBar: AppBar(
          title: Row(
          children: <Widget>[
            Text('Edunicate', style: TextStyle(fontSize:24, fontFamily: 'Josefin Sans')),
            Spacer(),
            Text( 'Sign In', style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans'))
            ] 
          ),
        backgroundColor: Color(0xffF9461E1),
        ),
        body: MyCustomForm(),
      )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm>{
  final eController = TextEditingController();
  final pController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    eController.dispose();
    pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: <Widget>[
        EmailPasswordBox('Email'),
        Container(
          decoration:BoxDecoration(border: Border.all()),
          height: 30,
          width: MediaQuery. of(context). size. width *.80,
          padding: EdgeInsets.symmetric(horizontal:2),
          child: TextField(textAlignVertical: TextAlignVertical.center, controller: eController)
        ),
      
        EmailPasswordBox('Password'),
        Container(
          decoration:BoxDecoration(border: Border.all()),
          height: 30,
          width: MediaQuery. of(context). size. width *.80,
          padding: EdgeInsets.symmetric(horizontal:2),
          child: TextField(textAlignVertical: TextAlignVertical.center, controller: pController,)
        ),
        SizedBox(height: 30),
         
        SizedBox (
          height: 30,
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              if(!eController.text.endsWith('nsd.org')) {
                showAlertDialog(context,'WRONG EMAIL', 'Only \'apps.nsd\' or \'.nsd\' emails!');
              }
              else {
                AuthenticationHelp(context, eController.text, pController.text);
              }
            },
            style: ElevatedButton.styleFrom (primary: Color(0xffF5A2E9C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0))),
            child: Text('Sign Up', style: TextStyle( fontSize: 15, fontFamily: 'Lato', color: Colors.white),
            ),
          ),
        ),
  
          AlternateButtons('OR', 'SIGN UP WITH GOOGLE'),
          AlternateButtons('ALREADY HAVE AN ACCOUNT?', 'CONTINUE TO LOGIN PAGE'),
        ],
    ),
    );
  }
}

showAlertDialog(BuildContext context, String titleText, String contentText){
  AlertDialog alert = AlertDialog(
    title: Text(titleText),
    content: Text(contentText),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}

class EmailPasswordBox extends StatelessWidget {
  EmailPasswordBox(this.aboveText);
  final String aboveText;

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Column (
        children: <Widget> [
        SizedBox(height:30),
        SizedBox(
          width:  MediaQuery. of(context). size. width *.80,
          child:Text(aboveText, style: TextStyle(fontSize: 15, fontFamily: 'Lato'), textAlign: TextAlign.left,)
        ),
        ],
      )
    );
  }
}

class AlternateButtons extends StatelessWidget {
  AlternateButtons(this.specifier, this.buttonText);
  final String specifier;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Column (
        children: <Widget> [
        Container(height:30),
          Divider(color: Colors.black),
          Text(specifier, style: TextStyle(fontSize : 15, fontFamily: 'Lato')),
          Container(height: 15),
          SizedBox(
            height: 40,
            width: MediaQuery. of(context). size. width *.80,
            child: ElevatedButton (
              onPressed: () {
                if (buttonText == 'CONTINUE TO LOGIN PAGE') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                }
                else if(buttonText == 'SIGN UP WITH GOOGLE') {
                  signInWithGoogle();
                }
              },
              style: ElevatedButton.styleFrom(primary: Color(0xffF9461E1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0))),
                child:Text(buttonText, style: TextStyle( fontSize: 15, fontFamily: 'Lato', color: Colors.white), textAlign: TextAlign.left)
            ) 
          ),
        ],
      )
    );
  }
}

Future<bool> AuthenticationHelp(BuildContext context,String emailAddress, String password) async {
  try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showAlertDialog(context, 'Password too weak', 'Must have 1 lowercase, 1 uppercase, 1 special character, and be at least 8 characters');
    } else if (e.code == 'email-already-in-use') {
      showAlertDialog(context, 'Email already in use', 'Please, continue to login page!');
    }
  } catch (e) {
    return false;
  }
  return true;
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}



