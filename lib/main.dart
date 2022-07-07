// Tanya Bhandari
// Join a Class and/or Create a new class page
//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

void main() => runApp(NewClass());

class NewClass extends StatelessWidget {
  const NewClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded (child: AddNew()), // plus sign (current page)
                Expanded (child: Home()), // home page (list of classes) and default page
                Expanded (child: Profile()), // personal profile
                Expanded (child: Settings()), // settings
              ]
              
            ) ,
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              JoinButton(), // join a new class
              SizedBox(
                height: 10,
              ),
              NewButton(), // create a new class
            ],
          )
        ),
      ),
    );
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox (
      height: 50.0,
      width: 250.0,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 58, 27, 103),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(9.0)
          ),
          ),
          
          child: Text(
              'Join a class',
              style: TextStyle( 
                color: Colors.white,
                fontFamily: 'Lato'
              )
          ),
      )
    );
  }
}  


class NewButton extends StatelessWidget {
  const NewButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox (
      height: 50.0,
      width: 250.0,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 148, 97, 225),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(9.0)
          ),
          ),
          
          child: Text(
              'Create a new class',
              style: TextStyle( 
                color: Colors.white,
                fontFamily: 'Lato'
              )
          ),
      )
    );
  }
}  

// Taskbar
// Plus sign
class AddNew extends StatelessWidget {
  const AddNew({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox (
        height: 50.0,
        child: OutlinedButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 58, 27, 103),
            side: BorderSide (color: Colors.white)
          ),
          onPressed: () {},
        ),
    );
  }
}

// home
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox (
        height: 50.0,
        child: OutlinedButton(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide (color: Colors.white)
          ),
          onPressed: () {},
        ),
    );
  }
}

// indvidual profile
class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox (
        height: 50.0,
        child: OutlinedButton(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide (color: Colors.white)
          ),
          onPressed: () {},
        ),
    );
  }
}

// settings
class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox (
        height: 50.0,
        child: OutlinedButton(
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 148, 97, 225),
            side: BorderSide (color: Colors.white)
          ),
          onPressed: () {},
        ),
    );
  }
}
