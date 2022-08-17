//Rishitha Ravi
//Code for the Updates tab of individual class screens
// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'message_bubble.dart';

void main() {
  runApp(UpdatesPage());
}

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  //gets user input
  final _textController = TextEditingController();

  List updates = [];
  String userPost = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables

        children: [
          //display text
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return SentMessages(message: updates[index]);
            },
            itemCount: updates.length,
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
        ],
      ),
      bottomSheet: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: TextField(
              maxLines: 1,
              maxLength: 200,
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What\'s the update?',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      userPost = _textController.text;
                      updates.add(_textController.text);
                    });
                    _textController.clear();
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ))),
    );
  }
}
