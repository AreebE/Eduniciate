//Rishitha Ravi
//Code for top navigation bar (appbar)

// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:edunciate/calendar/calendar.dart';
import 'package:edunciate/calendar/custom_calendar_event_data.dart';
import 'package:edunciate/calendar/firebase_event.dart';
import 'package:edunciate/class_details_item.dart';
import 'package:edunciate/classroom/announcements/announcement_item.dart';
import 'package:edunciate/classroom/announcements/announcements.dart';
import 'package:edunciate/classroom/calendar/class_calendar.dart';
import 'package:edunciate/classroom/discussion/ChatPage.dart';
import 'package:edunciate/classroom/members/people_tile.dart';
import 'package:edunciate/discussion_item.dart';
import 'package:edunciate/firebaseAccessor/calendar_firebase.dart';
import 'package:edunciate/firebaseAccessor/details_firebase.dart';
import 'package:edunciate/firebaseAccessor/discussions_firebase.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/firebaseAccessor/updates_firebase.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/member_item.dart';
import 'package:flutter/material.dart';
import '../color_scheme.dart';
import '../firebaseAccessor/members_firebase.dart';
import 'members/people_page.dart';
import 'messages_page.dart';
import 'details/details_page.dart';

enum ClassPage {
  announcements,
  discussions,
  members,
  calendar,
  details,
}

class OnClassPageChangeListener {
  changePage(ClassPage newPage) {}
}

class ClassPageContainer extends StatefulWidget {
  String classID;
  String className;
  String thisUserID;

  ClassRole thisMemberRole;
  String thisMemberID;
  String username;
  List<ChatMessage> messages;

  ClassPageContainer(this.classID, this.className, this.thisUserID,
      this.thisMemberRole, this.thisMemberID, this.username, this.messages,
      {Key? key})
      : super(key: key);

  @override
  State<ClassPageContainer> createState() => _ClassPageContainerState(
      className,
      classID,
      this.thisUserID,
      thisMemberRole,
      thisMemberID,
      username,
      this.messages);
}

class _ClassPageContainerState extends State<ClassPageContainer>
    implements
        OnClassPageChangeListener,
        FirebaseListener,
        DisplayWidgetListener {
  ClassPage currentPage = ClassPage.announcements;
  String classID;
  String className;
  ClassRole thisMemberRole;
  String thisMemberID;
  String thisUserID;
  String username;
  late Widget body;

  _ClassPageContainerState(
      this.className,
      this.classID,
      this.thisUserID,
      this.thisMemberRole,
      this.thisMemberID,
      this.username,
      List<ChatMessage> messages) {
    body = AnnouncementsScreen(
        messages,
        ChatUser(
            id: thisUserID,
            firstName: username.split(" ").first,
            lastName: username.split(" ").last),
        thisMemberRole,
        classID,
        thisUserID);
  }

  static const double fontSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            bottomNavigationBar: Row(children: [
              Expanded(child: AnnouncementsTaskButton(this, currentPage)),
              Expanded(child: DiscussionsTaskbarButton(this, currentPage)),
              Expanded(child: MembersTaskbarButton(this, currentPage)),
              Expanded(child: CalendarTaskbarButton(this, currentPage)),
              Expanded(child: ClassDetailsTaskbarButton(this, currentPage)),
            ]),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 10,
              title: Column(children: [
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: AppTitle(className, 19.0),
                ),
                //   Row(
                //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Align(
                //         alignment: Alignment.topLeft,
                //         child: AppTitle(Organization, 19.0),
                //       ),

                //       //Button to lead back to list of class pages
                //       IconButton(
                //           color: Color.fromARGB(255, 58, 27, 103),
                //           icon: const Icon(Icons.arrow_back),
                //           onPressed: () {}),
                //     ],
                //   ),
              ]),
              // bottom: PreferredSize(
              //   preferredSize: _tabBar.preferredSize,
              //   child: Material(
              //     color: Color.fromARGB(225, 148, 97, 225),
              //     child: _tabBar,
              //   ),
              // ),
            ),
            body: body));
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
                          fontSize: fontSize,
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
                          fontSize: fontSize,
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
                          fontSize: fontSize,
                        )))),
            Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Details',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Josefin Sans',
                          fontSize: fontSize,
                        ))))
          ]);

  @override
  changePage(ClassPage newPage) {
    currentPage = newPage;
    print("newPage " + newPage.name);
    switch (newPage) {
      case ClassPage.announcements:
        UpdatesFirebaseAccessor().getAnnouncements(classID, this);
        break;
      case ClassPage.calendar:
        CalendarFirebaseAccessor().getClassEvents(classID, this);
        break;
      case ClassPage.details:
        ClassDetailsFirebaseAccessor().getClassInfo(classID, this);
        break;
      case ClassPage.discussions:
        ClassDiscussionsFirebase().getAllDiscussions(thisMemberID, this);
        break;
      case ClassPage.members:
        MembersFirebaseAccessor().getMembers(classID, this);
        break;
    }
  }

  @override
  void onFailure(String reason) {}

  @override
  void onSuccess(List objects) {
    print("finished with " + currentPage.name);
    switch (currentPage) {
      case ClassPage.announcements:
        List<ChatMessage> messages = [];
        for (int i = 0; i < objects.length; i++) {
          messages.insert(
              0, (objects.elementAt(i) as AnnouncementItem).toMessage());
        }
        body = AnnouncementsScreen(messages, ChatUser(id: thisUserID),
            thisMemberRole, classID, thisUserID);
        break;
      case ClassPage.calendar:
        List<CustomCalendarEventData> events = [];
        for (int i = 0; i < objects.length; i++) {
          events.add(
              (objects.elementAt(i) as FirebaseEvent).toCustomCalendarEvent());
        }
        ClassDetailsFirebaseAccessor().getClassInfo(
            classID,
            FirebaseListener((photo) {
              ClassDetailsItem classDetailsItem = photo[0];
              body = ClassCalendarPage(events, classDetailsItem.getPhoto(),
                  classID, className, this);
              setState(() {});
            }, (message) {}));
        return;
      case ClassPage.details:
        ClassDetailsItem details = objects[0];
        body = DetailsPage(
            details.getName(),
            details.getDesc(),
            details.getID(),
            details.getCode(),
            details.getPhoto(),
            thisMemberID,
            thisMemberRole);
        break;
      case ClassPage.discussions:
        MembersFirebaseAccessor().getResponsesToConvos(
            thisMemberID,
            FirebaseListener((mapOfValues) {
              Map<String, Timestamp> userInfo =
                  (mapOfValues[0] as Map).cast<String, Timestamp>();
              body = ChatPage(objects.cast<DiscussionItem>(), userInfo,
                  thisMemberID, thisUserID, this);
              setState(() {});
            }, (message) {}));
        return;
      case ClassPage.members:
        List<PeopleTile> people = [];
        for (int i = 0; i < objects.length; i++) {
          MemberItem item = objects.elementAt(i) as MemberItem;
          people.insert(
              0,
              PeopleTile(item.getName(), item.getRole() == ClassRole.owner,
                  item.getPicture(), thisMemberRole, item.getMemberID(), this));
        }
        body = PeoplePage(people);
        setState(() {});
        break;
    }
    setState(() {});
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
}

class AnnouncementsTaskButton extends StatelessWidget {
  OnClassPageChangeListener listener;
  ClassPage current;
  AnnouncementsTaskButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == ClassPage.announcements)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(ClassPage.announcements);
        },
        child: Icon(
          Icons.add_alert,
          color: CustomColorScheme.defaultColors.getColor(
              (current != ClassPage.announcements)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// calendar page sign
class CalendarTaskbarButton extends StatelessWidget {
  OnClassPageChangeListener listener;
  ClassPage current;

  CalendarTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current ==
                        ClassPage.calendar) // calendarPage needs to be updated
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(ClassPage.calendar);
        },
        child: Icon(
          Icons.calendar_month,
          color: CustomColorScheme.defaultColors.getColor(
              (current != ClassPage.calendar)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// indvidual profile
class DiscussionsTaskbarButton extends StatelessWidget {
  OnClassPageChangeListener listener;
  ClassPage current;

  DiscussionsTaskbarButton(this.listener, this.current, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == ClassPage.discussions)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(ClassPage.discussions);
        },
        child: Icon(
          Icons.add_comment,
          color: CustomColorScheme.defaultColors.getColor(
              (current != ClassPage.discussions)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// settings
class MembersTaskbarButton extends StatelessWidget {
  OnClassPageChangeListener listener;
  ClassPage current;

  MembersTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == ClassPage.members)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(ClassPage.members);
        },
        child: Icon(
          Icons.group,
          color: CustomColorScheme.defaultColors.getColor(
              (current != ClassPage.members)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

class ClassDetailsTaskbarButton extends StatelessWidget {
  OnClassPageChangeListener listener;
  ClassPage current;

  ClassDetailsTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == ClassPage.details)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(ClassPage.details);
        },
        child: Icon(
          Icons.settings,
          color: CustomColorScheme.defaultColors.getColor(
              (current != ClassPage.details)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}
