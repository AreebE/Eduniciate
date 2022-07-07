// Tanya Bhandari
// Join a Class and/or Create a new class page
//ignore_for_file: prefer_const_constructors
import 'package:edunciate/joinAndCreateClass/join_and_create_start_screen.dart';
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
                Expanded(child: AddNew()), // plus sign (current page)
                Expanded(
                    child:
                        Home()), // home page (list of classes) and default page
                Expanded(child: Profile()), // personal profile
                Expanded(child: Settings()), // settings
              ]),
          body: JoinAndCreateScreen()),
    );
  }
}
