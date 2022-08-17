//Rishitha Ravi
//Code for the Messages tab of individual class screens
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'message_bubble.dart';
import 'title_block.dart';

void main() {
  runApp(MessagesPage());
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  //gets user input
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  List updates = [];
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        // ignore: prefer_const_literals_to_create_immutables

        children: [
          TitleBlock("Create New Message", 10.0, 0.0),
          Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: TextField(
                  autofocus: true,
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
                    hintText: 'To:',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController1.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: TextField(
                  autofocus: true,
                  maxLines: 5,
                  maxLength: 300,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
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
                    hintText: 'Message:',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController2.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  message = _textController2.text;
                });
                _textController1.clear();
                _textController2.clear();
              },
              color: Color.fromARGB(255, 148, 97, 225),
              child: Text('Send',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    fontSize: 20.0,
                  )),
            ),
          ),
          TitleBlock("Message Chains", 0.0, 10.0),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: Text('Message with Owner A',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lato',
                  fontSize: 18.0,
                )),
            subtitle: Text("I don't understand ...",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize: 8.0,
                )),
            tileColor: Color.fromARGB(255, 235, 221, 255),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          ),
        ],
      ),
    ));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            title: Text("Convo with Owner A",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Josefin Sans',
                  fontSize: 20.00,
                ))),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SentMessages(message: "When is the club meeting?"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SentMessages(message: "Is there anything I should bring?"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RecievedMessages(message: "It will be this Thursday"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RecievedMessages(message: "Please bring your folder."),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SentMessages(message: "Should I bring my teammates?"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child:
                  RecievedMessages(message: "Yes, please tell them to attend."),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SentMessages(message: "When is the final deadline?"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RecievedMessages(message: "The sooner the better."),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SentMessages(
                  message: "I don't understand how to submit the project."),
            ),
          ],
        ));
  }
}
