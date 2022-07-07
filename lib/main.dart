// Tanya Bhandari
// Join a Class and/or Create a new class page
//ignore_for_file: prefer_const_constructors
import 'package:edunciate/joinAndCreateClass/join_and_create_start_screen.dart';
import 'package:edunciate/settings/settings.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

void main() {
  runApp(NewClass());
}

class NewClass extends StatelessWidget {
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
      CustomColorScheme.createFromHex("#B7CFFF"),
      CustomColorScheme.createFromHex("#0244C5"),
      CustomColorScheme.createFromHex("#5F379A"),
    ],
  );

  NewClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Expanded(
                    child: AddNewTaskbarButton()), // plus sign (current page)
                Expanded(
                    child:
                        HomeTaskbarButton()), // home page (list of classes) and default page
                Expanded(child: ProfileTaskbarButton()), // personal profile
                Expanded(child: SettingsTaskbarButton()), // settings
              ]),
          body: JoinAndCreateScreen()),
    );
  }
}

// Tanya Bhandari
// Taskbar
// Plus sign
class AddNewTaskbarButton extends StatelessWidget {
  const AddNewTaskbarButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 58, 27, 103),
            side: BorderSide(color: Colors.white)),
        onPressed: () {},
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
  const HomeTaskbarButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide(color: Colors.white)),
        onPressed: () {},
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
  const ProfileTaskbarButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide(color: Colors.white)),
        onPressed: () {},
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
  const SettingsTaskbarButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide(color: Colors.white)),
        onPressed: () {},
        child: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }
}
