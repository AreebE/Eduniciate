// Tanya Bhandari
// Join a Class and/or Create a new class page
//ignore_for_file: prefer_const_constructors, unused_import, must_be_immutable
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/calendar/calendar.dart';
import 'package:edunciate/calendar/custom_calendar_event_data.dart';
import 'package:edunciate/classroom/top_nav_bar.dart';
import 'package:edunciate/firebaseAccessor/calendar_firebase.dart';
import 'package:edunciate/firebaseAccessor/details_firebase.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/firebaseAccessor/homepage_firebase.dart';
import 'package:edunciate/firebaseAccessor/personal_profile_firebase.dart';
import 'package:edunciate/firebaseAccessor/settings_firebase.dart';
import 'package:edunciate/firebaseAccessor/users_firebase.dart';
import 'package:edunciate/homepage/class_list_tile.dart';
import 'package:edunciate/homepage/homepage.dart';
import 'package:edunciate/homepage/items/class_item.dart';
import 'package:edunciate/joinAndCreateClass/class_alternator_screen.dart';
import 'package:edunciate/joinAndCreateClass/join_and_create_start_screen.dart';
import 'package:edunciate/calendar/firebase_event.dart';
import 'package:edunciate/personal_profile/profile_page.dart';
import 'package:edunciate/settings/items/settings_item.dart';
import 'package:edunciate/settings/items/time_range.dart';
import 'package:edunciate/settings/settings.dart';
import 'package:edunciate/signUpScreen/registration_alternator.dart';
import 'package:edunciate/signUpScreen/signupscreen.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'color_scheme.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Page { settings, homepage, calendar, personalProfile }

class BlankListener extends FirebaseListener {
  BlankListener() : super((items) {}, (message) {});

  @override
  void onSuccess(List items) {
    // print(items);
  }
}

class OnPageChangeListener {
  void changePage(Page newPage) {}
}

void main() {
  runApp(RegistrationAlternator());
}

abstract class DisplayWidgetListener {
  BuildContext getContext();
}

class MainDisplay extends StatefulWidget {
  String _userID;
  UserRole _userRole;
  List<ClassList> _userItems;

  MainDisplay(this._userItems, this._userID, this._userRole, {Key? key})
      : super(key: key);

  @override
  State<MainDisplay> createState() =>
      _MainDisplayState(_userID, _userRole, _userItems);
}

class _MainDisplayState extends State<MainDisplay>
    implements OnPageChangeListener, FirebaseListener, DisplayWidgetListener {
  Page current = Page.homepage;
  late Widget body;
  String _userID;
  UserRole _userRole;

  _MainDisplayState(this._userID, this._userRole, List<ClassList> items) {
    body = ClassBody(items, _userID, _userRole, this);
  }

  @override
  Widget build(BuildContext context) {
    // print("started");

    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: AddNewTaskbarButton(
                    this, current)), // plus sign (current page)
            Expanded(
                child: HomeTaskbarButton(this,
                    current)), // home page (list of classes) and default page
            Expanded(
                child: ProfileTaskbarButton(this, current)), // personal profile
            Expanded(child: SettingsTaskbarButton(this, current)), // settings
          ]),
      body: body,
    ));
  }

  void setBody() {
    switch (current) {
      case Page.homepage:
        HomepageFirebaseAccessor().getClasses(_userID, this);
        break;
      case Page.settings:
        FirebaseSettingsAccessor().getSettingsInfo(_userID, this);
        break;
      case Page.calendar:
        CalendarFirebaseAccessor().getUserEvents(_userID, this);
        break;
      case Page.personalProfile:
        PersonalProfileFirebaseAccessor().getUserInfo(_userID, this);
    }
  }

  @override
  void changePage(Page newPage) {
    print("called");
    if (newPage != current) {
      current = newPage;
      setBody();
      setState(() {});
    }
  }

  @override
  void onFailure(String reason) {}

  @override
  void onSuccess(List objects) {
    switch (current) {
      case Page.homepage:
        List<ClassList> items = [];
        for (int i = 0; i < objects.length; i++) {
          ClassItem item = objects[i] as ClassItem;
          items.insert(
              0,
              ClassList(item.getClassName(), item.getDesc(), item.getID(),
                  _userID, _userRole, item.getImage(), this));
        }
        body = ClassBody(items, this._userID, this._userRole, this);
        setState(() {});
        break;
      case Page.personalProfile:
        UserInfoItem user = UserInfoItem(
            id: objects[PersonalProfileFirebaseAccessor.idArrayKey],
            imageBytes: Uint8List.fromList(
                objects[PersonalProfileFirebaseAccessor.photoArrayKey]),
            name: objects[PersonalProfileFirebaseAccessor.nameArrayKey],
            pronouns: objects[PersonalProfileFirebaseAccessor.pronounsArrayKey],
            email: objects[PersonalProfileFirebaseAccessor.emailArrayKey],
            about: objects[PersonalProfileFirebaseAccessor.bioArrayKey]);
        body = ProfilePage(user, this);
        setState(() {});
        break;
      case Page.settings:
        SettingsItem item = SettingsItem(
            objects[FirebaseSettingsAccessor.notifStatusArrayKey],
            objects[FirebaseSettingsAccessor.textArrayKey],
            (objects[FirebaseSettingsAccessor.workHoursStatusArrayKey] as List)
                .cast<TimeRange>(),
            objects[FirebaseSettingsAccessor.langArrayKey],
            "uSDrCPEvRKmTQHPrbP5N");
        body = SettingsPage(this,
            settingsItem: item, colorScheme: CustomColorScheme.defaultColors);
        setState(() {});
        break;

      case Page.calendar:
        List<CustomCalendarEventData> events = [];
        for (dynamic o in objects) {
          events.insert(0, (o as FirebaseEvent).toCustomCalendarEvent());
        }
        body = CalendarPage(events);
        setState(() {});
        return;
    }
  }

  @override
  BuildContext getContext() {
    return context;
  }
}

// Tanya Bhandari
// Taskbar
// Home page sign
class AddNewTaskbarButton extends StatelessWidget {
  OnPageChangeListener listener;
  Page current;
  AddNewTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == Page.homepage)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.homepage);
        },
        child: Icon(
          Icons.home,
          color: CustomColorScheme.defaultColors.getColor(
              (current != Page.homepage)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// calendar page sign
class HomeTaskbarButton extends StatelessWidget {
  OnPageChangeListener listener;
  Page current;

  HomeTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == Page.calendar) // calendarPage needs to be updated
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.calendar);
        },
        child: Icon(
          Icons.calendar_month,
          color: CustomColorScheme.defaultColors.getColor(
              (current != Page.calendar)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// indvidual profile
class ProfileTaskbarButton extends StatelessWidget {
  OnPageChangeListener listener;
  Page current;

  ProfileTaskbarButton(this.listener, this.current, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == Page.personalProfile)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.personalProfile);
        },
        child: Icon(
          Icons.person,
          color: CustomColorScheme.defaultColors.getColor(
              (current != Page.personalProfile)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}

// settings
class SettingsTaskbarButton extends StatelessWidget {
  OnPageChangeListener listener;
  Page current;

  SettingsTaskbarButton(this.listener, this.current, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.defaultColors.getColor(
                (current == Page.settings)
                    ? CustomColorScheme.darkPrimary
                    : CustomColorScheme.backgroundAndHighlightedNormalText),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.settings);
        },
        child: Icon(
          Icons.settings,
          color: CustomColorScheme.defaultColors.getColor(
              (current != Page.settings)
                  ? CustomColorScheme.darkPrimary
                  : CustomColorScheme.backgroundAndHighlightedNormalText),
        ),
      ),
    );
  }
}
