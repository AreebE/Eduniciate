import 'package:flutter/material.dart';
import 'package:edunciate/signUpScreen/signupscreen.dart';


class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

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
            Text( 'Log In', style: TextStyle(fontSize: 24, fontFamily: 'Josefin Sans'))
            ] 
          ),
        backgroundColor: Color(0xffF9461E1),
        ),
        body: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: <Widget>[
        EmailPasswordBox('Email'),

        EmailPasswordBox('Password'),
        
          SizedBox(height: 30),
          SizedBox (
          height: 30,
          width: 90,            
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom (primary: Color(0xffF5A2E9C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0))),
            child: Text('Log In', style: TextStyle( fontSize: 15, fontFamily: 'Lato', color: Colors.white),
            ),
          ),
          ),
          AlternateButtons('OR', 'LOG IN WITH GOOGLE'),
          AlternateButtons('DON\'T HAVE AN ACCOUNT?', 'CONTINUE TO SIGN UP PAGE'),
        ],
      ),
    );
  }
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
        Container(
          decoration:BoxDecoration(border: Border.all()),
          height: 30,
          width: MediaQuery. of(context). size. width *.80,
          padding: EdgeInsets.symmetric(horizontal:2),
          child: TextField(textAlignVertical: TextAlignVertical.center)
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
                if (buttonText == 'CONTINUE TO SIGN UP PAGE') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
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


