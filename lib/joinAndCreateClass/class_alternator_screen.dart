// ignore_for_file: unnecessary_import, implementation_imports

import 'package:edunciate/classroom/top_nav_bar.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/joinAndCreateClass/join_and_create_start_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum ClassState { joinAndCreate, classroom }

class ClassChangeListener {
  void changeState(ClassState newState) {}
}

class ClassAlternator extends StatefulWidget {
  const ClassAlternator({Key? key}) : super(key: key);

  @override
  State<ClassAlternator> createState() => _ClassAlternatorState();
}

class _ClassAlternatorState extends State<ClassAlternator>
    implements ClassChangeListener {
  ClassState state = ClassState.joinAndCreate;

  @override
  Widget build(BuildContext context) {
    // Widget body = (state == ClassState.joinAndCreate)
    // ? JoinAndCreateScreen(this)
    // : ClassPageContainer("", ClassRole.member);
    return JoinAndCreateScreen(this);
  }

  @override
  void changeState(ClassState newState) {
    state = newState;
    setState(() {});
  }
}
