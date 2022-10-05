//Rishitha Ravi
//Code for the People tab of individual class screens
// ignore_for_file: prefer_const_constructors

import 'package:edunciate/homepage/items/class_item.dart';
import 'package:flutter/material.dart';
import 'title_block.dart';
import 'people_tile.dart';

void main() {
  // runApp(PeoplePage());
}

class PeoplePage extends StatefulWidget {
  List<PeopleTile> members;

  PeoplePage(this.members, {Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState(members);
}

class _PeoplePageState extends State<PeoplePage> {
  List<PeopleTile> members;

  _PeoplePageState(this.members);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      TitleBlock('Class Members', 10.0, 0.0),
    ];
    for (int i = 0; i < members.length; i++) {
      children.add(members[i]);
    }
    return Scaffold(
      body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: children),
    );
  }
}
