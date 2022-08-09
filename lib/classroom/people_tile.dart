//Rishitha Ravi
//Code for displaying people/members in individual class screens

import 'package:flutter/material.dart';

//Code for the listings of people
class PeopleTile extends StatelessWidget {
  late String title;

  PeopleTile(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
        ),
        title: Text(title,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Lato',
              fontSize: 18.0,
            )),
        tileColor: Color.fromARGB(255, 235, 221, 255),
      ),
    );
  }
}
