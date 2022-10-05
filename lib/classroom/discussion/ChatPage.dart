import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/classroom/discussion/chatUserModels.dart';
import 'package:edunciate/classroom/discussion/conversationlist.dart';
import 'package:edunciate/classroom/discussion/individualMessagesScreen.dart';
import 'package:edunciate/discussion_item.dart';
import 'package:edunciate/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:paginated_search_bar/paginated_search_bar.dart';

import 'package:flutter/material.dart';

//source: https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/

class ChatPage extends StatefulWidget {
  Map<String, Timestamp> lastResponses;
  List<DiscussionItem> items;
  String memberID;
  String userID;
  DisplayWidgetListener widgetListener;

  ChatPage(this.items, this.lastResponses, this.memberID, this.userID,
      this.widgetListener);

  @override
  _ChatPageState createState() => _ChatPageState(
      items, lastResponses, memberID, userID, this.widgetListener);
}

class _ChatPageState extends State<ChatPage> {
  Map<String, Timestamp> lastResponses;
  List<DiscussionItem> items;
  String memberID;
  String userID;
  DisplayWidgetListener widgetListener;

  _ChatPageState(this.items, this.lastResponses, this.memberID, this.userID,
      this.widgetListener);

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
                  List<ExampleItem> users = [];
                  for (int i = 0; i < items.length; i++) {
                    if (items[i].getName().toString().contains(searchQuery)) {
                      ExampleItem n =
                          new ExampleItem(items[i].getName().toString());
                      users.add(n);
                    }
                  }

                  return users;
                },
                itemBuilder: (
                  context, {
                  required item,
                  required index,
                }) {
                  return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: 40,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                item.title,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.left,
                              ))));
                },
              ),
            ),
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  items[index].getDiscussionID(),
                  userID,
                  memberID,
                  widgetListener,
                  name: items[index].getName(),
                  time: items[index].getTimeLastUpdated().toDate().toString(),
                  isMessageRead: items[index]
                          .getTimeLastUpdated()
                          .toDate()
                          .compareTo(
                              lastResponses[items[index].getDiscussionID()]!
                                  .toDate()) >
                      0,
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

  ExampleItem(
    this.title,
  );
}
