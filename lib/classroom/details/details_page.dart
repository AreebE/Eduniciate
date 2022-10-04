//Rishitha Ravi
//Code for the Settings tab of individual class screen
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, sort_child_properties_last, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, must_be_immutable

import '../members/title_block.dart';
import '../top_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DetailsPage());
}

class DetailsPage extends StatefulWidget {
  String className = 'Class Name';
  String organization = 'Organization';

  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //define variables here
  String bullet = "•";
    String classID;
  String classDesc = "";
  String className = "";  
    String organization = "";

    _DetailsPageState(this.classID, this.classDesc, this.className)
    final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  void submit1() {
    Navigator.of(context).pop();
    setState(() {
      className = _textController1.text;
        ClassDetailsFirebaseAccessor()
        .updateName(classID, className);

    });
    _textController1.clear();
  }

  void submit2() {
    Navigator.of(context).pop();
    setState(() {
      classInfo = _textController2.text;
        ClassDetailsFirebaseAccessor()
            .updateDesc(classID, classInfo);
    });
    _textController2.clear();
  }

  void submit3() {
    Navigator.of(context).pop();
    setState(() {
      organization = _DropdownState().selectedValue;
    });
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

  Future openDialog3() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: AppTitle('Code', 20.0),
              content: Text(classCode, ),
              actions: [
                TextButton(
                  child: AppTitle("Finished Viewing", 10.0),
                  onPressed: submit3,
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
        TitleBlock("Class Information", 10.0, 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                        openDialog3();
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
        ),

        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Text(classInfo,
                style: TextStyle(
                  color: Color.fromARGB(255, 58, 27, 103),
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Lato',
                  fontSize: 15.0,
                ))),
        TitleBlock("Class Owners", 10.0, 0.0),

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
class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() => _DropdownState();
}

//Dropdown for Settings page
class _DropdownState extends State<Dropdown> {
  List<String> listitems = ["North Creek HS", "Bothell HS", "Woodinville HS"];
  String selectedValue = "North Creek HS";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      hint: Text("Select School",
          style: TextStyle(
            color: Color.fromARGB(255, 58, 27, 103),
            fontWeight: FontWeight.normal,
            fontFamily: 'Lato',
            fontSize: 10.0,
          )),
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          TopNavBar.Organization = value.toString();
        });
      },
      items: listitems.map((itemone) {
        return DropdownMenuItem(value: itemone, child: Text(itemone));
      }).toList(),
    );
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
