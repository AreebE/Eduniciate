// ignore_for_file: implementation_imports, unnecessary_import

import 'package:edunciate/signUpScreen/loginscreen.dart';
import 'package:edunciate/signUpScreen/signupscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum RegistrationState { login, signUp }

class RegistrationListener {
  void setRegState(RegistrationState newState) {}
}

class RegistrationAlternator extends StatefulWidget {
  const RegistrationAlternator({Key? key}) : super(key: key);

  @override
  State<RegistrationAlternator> createState() => _RegistrationAlternatorState();
}

class _RegistrationAlternatorState extends State<RegistrationAlternator>
    implements RegistrationListener {
  RegistrationState current = RegistrationState.login;

  @override
  Widget build(BuildContext context) {
    Widget body = (current == RegistrationState.signUp)
        ? SignUpScreen(this)
        : LogInScreen(this);
    return body;
  }

  @override
  void setRegState(RegistrationState newState) {
    current = newState;
    // print("Trying to change");
    setState(() {});
  }
}
