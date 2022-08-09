//Rishitha Ravi
//Code for the Settings tab of individual class screen
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'title_block.dart';
import 'people_tile.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  static String className = 'Class Name';
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //define variables here
  String bullet = "•";
  String classDetails = 'Class Details';
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  void submit1() {
    Navigator.of(context).pop();
    setState(() {
      SettingsPage.className = _textController1.text;
    });
    _textController1.clear();
  }

  void submit2() {
    Navigator.of(context).pop();
    setState(() {
      classDetails = _textController2.text;
    });
    _textController2.clear();
  }

  Future openDialog1() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: AppTitle('Class Name', 20.0),
              content: TextField(
                  autofocus: true,
                  maxLines: 1,
                  maxLength: 80,
                  controller: _textController1,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 221, 255),
                    border: OutlineInputBorder(),
                    hintText: 'Class name',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController1.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  )),
              actions: [
                TextButton(
                  child: AppTitle("SUBMIT", 10.0),
                  onPressed: submit1,
                ),
              ]));

  Future openDialog2() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: AppTitle('Class Description', 20.0),
              content: TextField(
                  autofocus: true,
                  maxLines: 5,
                  maxLength: 500,
                  controller: _textController2,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 221, 255),
                    border: OutlineInputBorder(),
                    hintText: 'Details about class',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController2.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  )),
              actions: [
                TextButton(
                  child: AppTitle("SUBMIT", 10.0),
                  onPressed: submit2,
                ),
              ]));

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 50,
              )),
        ),
        TitleBlock("Class Details", 10.0, 10.0),
        Row(
          children: [
            //Changes Organization Name
            Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 58, 27, 103),
                child: TextButton(
                    child: Text("Select Organization",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          fontSize: 15.0,
                        )),
                    onPressed: () {
                      openDialog2();
                    })),

            //Changes Class Name
            Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 58, 27, 103),
                child: TextButton(
                    child: Text("Set Class Name",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          fontSize: 15.0,
                        )),
                    onPressed: () {
                      openDialog1();
                    })),
            //Changes Class Description
            Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 58, 27, 103),
                child: TextButton(
                    child: Text("Edit Class Description",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          fontSize: 15.0,
                        )),
                    onPressed: () {
                      openDialog2();
                    })),
          ],
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Text(classDetails,
                style: TextStyle(
                  color: Color.fromARGB(255, 58, 27, 103),
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Lato',
                  fontSize: 15.0,
                ))),
        TitleBlock("Class Owners", 10.0, 0.0),
        PeopleTile("Owner A"),
        PeopleTile("Owner B"),
        PeopleTile("Owner C"),
        TitleBlock("Class Resources", 10.0, 10.0),
        Text(" " + bullet + " a random link",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Lato',
              fontSize: 18.0,
            )),

        //Leave Class Button
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            color: Color.fromARGB(255, 224, 20, 20),
            child: TextButton(
                child: Text("LEAVE CLASS",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      fontSize: 15.0,
                    )),
                onPressed: () {}))
      ],
    );
  }
}

//Dropdown Menu for Organization
class DropdownButton extends StatefulWidget {
  @override
  _DropdownButtonState createState() => _DropdownButtonState();
}

//Dropdown for Settings page
class _DropdownButtonState extends State<DropdownButton> {
  String selectedValue = "North Creek HS";

  @override
  Widget build(BuildContext context) {
    return DropdownButton();
  }

  //Creates options for the dropdown menu
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: AppTitle("North Creek HS", 10.0), value: "North Creek HS"),
      DropdownMenuItem(
          child: AppTitle("Bothell HS", 10.0), value: "North Creek HS"),
      DropdownMenuItem(
          child: AppTitle("Woodinville HS", 10.0), value: "North Creek HS"),
    ];
    return menuItems;
  }
}

//Purple Text Titles
class AppTitle extends StatelessWidget {
  late String name;
  late double size;

  AppTitle(this.name, this.size);

  @override
  Widget build(BuildContext context) {
    return Text(name,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Color.fromARGB(255, 58, 27, 103),
          fontWeight: FontWeight.bold,
          fontFamily: 'Josefin Sans',
          fontSize: size,
        ));
  }
}
