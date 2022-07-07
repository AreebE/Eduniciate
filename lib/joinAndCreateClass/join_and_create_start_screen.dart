import 'package:flutter/material.dart';

class JoinAndCreateScreen extends StatelessWidget {
  JoinAndCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        JoinButton(), // join a new class
        SizedBox(
          height: 10,
        ),
        NewButton(), // create a new class
      ],
    ));
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.0,
        width: 250.0,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 58, 27, 103),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(9.0)),
          ),
          child: Text('Join a class',
              style: TextStyle(color: Colors.white, fontFamily: 'Lato')),
        ));
  }
}

class NewButton extends StatelessWidget {
  const NewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.0,
        width: 250.0,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 148, 97, 225),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(9.0)),
          ),
          child: Text('Create a new class',
              style: TextStyle(color: Colors.white, fontFamily: 'Lato')),
        ));
  }
}
