//Rishitha Ravi
//Code for displaying people/members in individual class screens

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
int index = 0;


class ClassList extends StatelessWidget {
  late String title;
  late String description;
  Color color;

  ClassList(this.title, this.description, this.color);

  @override
  Widget build(BuildContext context) {
    index += 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
      
      child: Material (
        elevation: 1.5,
        shadowColor: Colors.grey,
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0), // TODO: increase padding
            leading: Stack(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: color,
                  ),
              ),
              ]),

           title:           
            Column(
              children: [
              Text(title,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: (FontWeight. bold),
                  fontSize: 18.0,
                )),
                Text(description,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                   ))
                ]),

            tileColor: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
                side:
                    //BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
                    BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1),
                borderRadius: BorderRadius.circular(2)),
            
            trailing: GestureDetector(
                child: 
                Icon(
                  CupertinoIcons.ellipsis, 
                  color: Color.fromARGB(255, 58, 27, 103)),

                onTapDown: (details) => showPopupMenu(context, details)),
    )));
  }


  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy),
      items: [
        PopupMenuItem<String>(child: const Text('Promote'), value: '1'),
        PopupMenuItem<String>(child: const Text('Remove'), value: '2'),
        PopupMenuItem<String>(child: const Text('Message'), value: '3'),
      ],
      elevation: 8.0,
    );

    (String itemSelected) {
      // ignore: unnecessary_null_comparison
      if (itemSelected == null) return;
      if (itemSelected == "1") {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text("Promote"),
                content:
                    Text("Are you sure you want to promote to student owner?"),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
                ],
                elevation: 24.0),
            barrierDismissible: true);
      } else if (itemSelected == "2") {
      } else {}
    };
  }

  Widget buildProfileIcon({
    required Color color,
  }) =>
      ClipRRect(
          child: Container(
            padding: EdgeInsets.all(.5),
            color: color,
      ));
}