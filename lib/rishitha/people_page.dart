//Rishitha Ravi
//Code for the People tab of individual class screens
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'title_block.dart';
import 'people_tile.dart';
import '../personal_profile/profile_page.dart';

void main() {
  runApp(PeoplePage());
}

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TitleBlock('Class Members', 10.0, 0.0),
          PeopleTile("Yelena Belova", true, Colors.green),
          PeopleTile("Owner B", true, Colors.blue),
          PeopleTile("Owner C", true, Colors.black),
          PeopleTile("Scarlet Witch", false, Colors.orange),
          PeopleTile("Dr. Strange", false, Colors.pink),
          PeopleTile("Spiderman", false, Colors.deepOrange),
          PeopleTile("Falcon", false, Colors.red),
          PeopleTile("Winter Soldier", false, Colors.yellow),
          PeopleTile("Black Widow", false, Colors.lightGreen),
        ],
      ),
    );
  }
}
