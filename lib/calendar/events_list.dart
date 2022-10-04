import 'package:calendar_view/src/calendar_event_data.dart';
import 'package:edunciate/calendar/custom_calendar_event_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(EventList());
// }

class EventList extends StatelessWidget {
  List<CustomCalendarEventData> _events;

  EventList(this._events, {Key? key}) : super(key: key) {
    // print("EL " + _events.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    print("REEE" + _events.toString());

    for (int i = 0; i < _events.length; i++) {
      CustomCalendarEventData current = _events.elementAt(0);
      children.add(Event(
          current.title, current.description, current.date, current.image));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.vertical, child: Column(children: children));
  }
}

class Event extends StatelessWidget {
  late String className;
  late String title;
  late DateTime date;
  late MemoryImage image;

  Event(this.className, this.title, this.date, this.image);

  @override
  Widget build(BuildContext context) {
    String formattedDate = CustomCalendarEventData.getDayName(date.weekday) +
        ", " +
        CustomCalendarEventData.getMonth(date.month) +
        " " +
        CustomCalendarEventData.getDayNum(date.day);
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: ListTile(
          //shows class icon
          leading: Stack(
            children: [
              Image(
                image: image,
              ),
            ],
          ),
          title: Column(
            children: [
              Text(className,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Color.fromARGB(255, 58, 27, 103),
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                  )),
              Text(title,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Color.fromARGB(255, 58, 27, 103),
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                  )),
              Text(formattedDate,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Color.fromARGB(255, 58, 27, 103),
                    fontFamily: 'Lato',
                    fontSize: 15.0,
                  )),
            ],
          ),
          tileColor: Color.fromARGB(97, 229, 236, 239),
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
              borderRadius: BorderRadius.circular(5)),
        ));
  }
}
