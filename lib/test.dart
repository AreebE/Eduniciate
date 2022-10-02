import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassList extends StatelessWidget {
  late String title;
  late String description;
  Color color;
  ClassList(this.title, this.description, this.color);
  @override
  Widget build(BuildContext context) {
    int index = 0;
    index += 1;
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
        child: Material(
            elevation: 1.5,
            shadowColor: Colors.grey,
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                ],
              ),
              title: Column(children: [
                Text(title,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Color.fromARGB(255, 58, 27, 103),
                      fontFamily: 'Lato',
                      fontWeight: (FontWeight.bold),
                      fontSize: 18.0,
                    )),
                Text(description,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Color.fromARGB(255, 58, 27, 103),
                      fontFamily: 'Lato',
                      fontSize: 10.0,
                    ))
              ]),
              tileColor: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                  side:
                      //BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
                      BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  borderRadius: BorderRadius.circular(2)),
              trailing: GestureDetector(
                  child: Icon(CupertinoIcons.ellipsis,
                      color: Color.fromARGB(255, 58, 27, 103)),
                  onTapDown: (details) => GestureDetector()),
            )));
  }
}
