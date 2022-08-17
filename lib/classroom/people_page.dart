//Rishitha Ravi
//Code for the People tab of individual class screens
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'title_block.dart';
import 'people_tile.dart';

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
          TitleBlock('Class Owners', 10.0, 0.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                //not displaying image
                backgroundColor: Colors.purple,
              ),
              title: Text('Owner A',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                  )),
              tileColor: Color.fromARGB(255, 235, 221, 255),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
          ),
          PeopleTile("Owner B"),
          PeopleTile("Owner C"),
          TitleBlock("Class Members", 8.0, 0.0),
          PeopleTile("Scarlet Witch"),
          PeopleTile("Dr. Strange"),
          PeopleTile("Spiderman"),
          PeopleTile("Falcon"),
          PeopleTile("Winter Soldier"),
          PeopleTile("Black Widow"),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 148, 97, 225),
          title: Text("Profile of Owner A",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontFamily: 'Josefin Sans',
                fontSize: 20.00,
              ))),
    );
  }
}
