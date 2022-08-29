// Tanya Bhandari
// Join a Class and/or Create a new class page
//ignore_for_file: prefer_const_constructors, unused_import, must_be_immutable
import 'package:edunciate/classroom/top_nav_bar.dart';
import 'package:edunciate/homepage/homepage.dart';
import 'package:edunciate/joinAndCreateClass/class_alternator_screen.dart';
import 'package:edunciate/joinAndCreateClass/join_and_create_start_screen.dart';
import 'package:edunciate/settings/settings.dart';
import 'package:edunciate/signUpScreen/registration_alternator.dart';
import 'package:edunciate/signUpScreen/loginscreen.dart';
import 'package:edunciate/signUpScreen/signupscreen.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

enum Page {
  settings,
  login,
  joinClass,
  homepage,
  // personalInfo
}

class OnPageChangeListener {
  void changePage(Page newPage) {}
}

void main() {
  runApp(MainDisplay());
}

class MainDisplay extends StatefulWidget {
  const MainDisplay({Key? key}) : super(key: key);

  @override
  State<MainDisplay> createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay>
    implements OnPageChangeListener {
  Page current = Page.login;

  @override
  Widget build(BuildContext context) {
    final CustomColorScheme defaultColors = CustomColorScheme(
      [
        CustomColorScheme.createFromHex("#3A1B67"),
        CustomColorScheme.createFromHex("#5F379A"),
        CustomColorScheme.createFromHex("#EBDDFF"),
        CustomColorScheme.createFromHex("#D4B7FF"),
        CustomColorScheme.createFromHex("#9461E1"),
        CustomColorScheme.createFromHex("#000000"),
        CustomColorScheme.createFromHex("#FFFFFF"),
        CustomColorScheme.createFromHex("#B90000"),
        CustomColorScheme.createFromHex("#DDDDDD"),
        CustomColorScheme.createFromHex("#0244C5"),
        CustomColorScheme.createFromHex("#5F379A"),
      ],
    );

    Widget body = getBody(current, defaultColors);

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

  Widget getBody(Page current, CustomColorScheme defaultColors) {
    switch (current) {
      case Page.homepage:
        return Homepage(defaultColors);
      case Page.joinClass:
        return ClassAlternator();
      case Page.login:
        return RegistrationAlternator();
      case Page.settings:
        return Settings(
          colorScheme: defaultColors,
        );
      // case Page.personalInfo:
      //   return PersonalInfoPage();
    }
  }

  @override
  void changePage(Page newPage) {
    if (newPage != current) {
      current = newPage;
      setState(() {});
    }
  }
}

// Tanya Bhandari
// Taskbar
// Plus sign
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
            backgroundColor: (current == Page.joinClass)
                ? Color.fromARGB(255, 58, 27, 103)
                : CustomColorScheme.defaultColors
                    .getColor(CustomColorScheme.lightSecondVariant),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.joinClass);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// home
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
            backgroundColor: (current == Page.homepage)
                ? Color.fromARGB(255, 58, 27, 103)
                : CustomColorScheme.defaultColors
                    .getColor(CustomColorScheme.lightSecondVariant),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.homepage);
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
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
            backgroundColor:
                // (current == Page.personalProfile)
                // ? Color.fromARGB(255, 58, 27, 103)
                // :
                CustomColorScheme.defaultColors
                    .getColor(CustomColorScheme.lightSecondVariant),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          // listener.changePage(Page.personalProfile);
        },
        child: Icon(
          Icons.person,
          color: Colors.white,
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
            backgroundColor: (current == Page.settings)
                ? Color.fromARGB(255, 58, 27, 103)
                : CustomColorScheme.defaultColors
                    .getColor(CustomColorScheme.lightSecondVariant),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          listener.changePage(Page.settings);
        },
        child: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }
}
