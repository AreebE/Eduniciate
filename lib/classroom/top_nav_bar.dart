//Rishitha Ravi
//Code for top navigation bar (appbar)

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'updates_page_1.dart';
import 'messages_page.dart';
import 'people_page.dart';
import 'details_page.dart';

class TopNavBar extends StatelessWidget {
  final double _fontSize = 15.0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 10,
            title: Column(children: [
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.topLeft,
                child: AppTitle(SettingsPage.className, 19.0),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppTitle('Organization', 19.0),
                  ),

                  //Button to lead back to list of class pages
                  IconButton(
                      color: Color.fromARGB(255, 58, 27, 103),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {}),
                ],
              ),
            ]),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Color.fromARGB(225, 148, 97, 225),
                child: _tabBar,
              ),
            ),
          ),
          body: TabBarView(children: [
            UpdatesPage(),
            MessagesPage(),
            PeoplePage(),
            SettingsPage()
          ])),
    );
  }

  TabBar get _tabBar => TabBar(
          indicator: BoxDecoration(color: Color.fromARGB(255, 95, 55, 154)),
          tabs: [
            Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Updates",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          fontSize: _fontSize,
                        )))),
            Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Messages',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          fontSize: _fontSize,
                        )))),
            Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('People',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          fontSize: _fontSize,
                        )))),
            Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Settings',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          fontSize: _fontSize,
                        ))))
          ]);
}
