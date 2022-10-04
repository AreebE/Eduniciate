import 'package:edunciate/classroom/discussion/chatUserModels.dart';
import 'package:edunciate/classroom/discussion/conversationlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:paginated_search_bar/paginated_search_bar.dart';

import 'package:flutter/material.dart';

//source: https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel", lastmessageText: "Awesome Setup", time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        lastmessageText: "That's Great",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        lastmessageText: "Hey where are you?",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        lastmessageText: "Busy! Call me in 20 mins",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        lastmessageText: "Thankyou, It's awesome",
        time: "23 Mar"),
    ChatUsers(
        name: "Jacob Pena",
        lastmessageText: "will update you in evening",
        time: "17 Mar"),
    ChatUsers(
        name: "Andrey Jones",
        lastmessageText: "Can you please share the file?",
        time: "24 Feb"),
    ChatUsers(
        name: "John Wick", lastmessageText: "How are you?", time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Align(
                alignment: Alignment.center,
                child: Text('Messages',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            SizedBox(height: 10),
            Container(
              child: PaginatedSearchBar<ExampleItem>(
                onSearch: ({
                  required pageIndex,
                  required pageSize,
                  required searchQuery,
                }) async {
                  // Call your search API to return a list of items

                  return [];
                },
                itemBuilder: (
                  context, {
                  required item,
                  required index,
                }) {
                  return Text(item.title);
                },
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  lastmessageText: chatUsers[index].lastmessageText,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}
