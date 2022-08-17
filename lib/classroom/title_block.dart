//Rishitha Ravi
//Code for the solid purple headings

// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/widgets.dart';

class TitleBlock extends StatelessWidget {
  late String title;
  late double top;
  late double bottom;

  TitleBlock(this.title, this.top, this.bottom);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, top, 0.0, bottom),
      child: Container(
          height: 40.0,
          color: Color.fromARGB(255, 148, 97, 225),
          child: Text('\t ' + title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontFamily: 'Josefin Sans',
                fontSize: 20.0,
              )),
          alignment: Alignment.centerLeft),
    );
  }
}
