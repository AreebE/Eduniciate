//Rishitha Ravi
//Code for displaying people/members in individual class screens

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Code for the listings of people
class PeopleTile extends StatelessWidget {
  late String title;
  final bool isOwner;
  Color color;

  PeopleTile(this.title, this.isOwner, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: color,
              ),
              if (isOwner)
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildOwnerIcon(Colors.white),
                )
            ],
          ),
          title: Text(title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color.fromARGB(255, 58, 27, 103),
                fontFamily: 'Lato',
                fontSize: 18.0,
              )),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
              borderRadius: BorderRadius.circular(5)),
          trailing: GestureDetector(
              child: const Icon(CupertinoIcons.ellipsis),
              onTapDown: (details) => showPopupMenu(context, details))),
    );
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

  Widget buildOwnerIcon(Color color) => buildCircle(
      color: Colors.grey,
      all: 0.5,
      child: buildCircle(
        color: color,
        all: 0.5,
        child:
            Icon(Icons.star, color: Color.fromARGB(255, 58, 27, 103), size: 10),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ));
}
