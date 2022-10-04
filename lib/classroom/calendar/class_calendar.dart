import 'package:edunciate/calendar/events_list.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

import '../../calendar/firebase_event.dart';

DateTime get _now => DateTime.now();

//DateTime get _now => DateTime.now();

void main() {
  // runApp(MonthPage());
}

class ClassCalendarPage extends StatelessWidget {
    String classID;
    String className;
    MemoryImage classPhoto;
  List<CustomCalendarEventData> _events;

  ClassCalendarPage(this._events, this.classPhoto, this.classID, this.className);

  final event = CalendarEventData(
    title: "Regionals",
    date: DateTime(2022, 10, 10),
    event: "Regionals",
  );

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.bold,
      fontFamily: 'Josefin Sans',
      fontSize: 15.0,
    ));

    return Scaffold(
      body: MonthPage(_events, classID, className, classPhoto),
    );
  }
}

class DayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: DayView(
                controller: EventController(),

                showVerticalLine:
                    true, // To display live time line in day view.
                showLiveTimeLineInAllDays:
                    true, // To display live time line in all pages in day view.
                minDay: DateTime(1990),
                maxDay: DateTime(2050),
                initialDay: DateTime(2021),
                heightPerMinute: 1, // height occupied by 1 minute time span.
                eventArranger:
                    SideEventArranger(), // To define how simultaneous events will be arranged.
                onEventTap: (events, date) => print(events),
                onDateLongPress: (date) => print(date),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.add),
              ),
            )));
  }
}

class WeekPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
                title: const Text('Leap'),
                backgroundColor: Colors.deepPurple,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.change_circle),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]),
            body: WeekView(
              controller: EventController(),
              eventTileBuilder: (date, events, boundry, start, end) {
                // Return your widget to display as event tile.
                return Container();
              },
              showLiveTimeLineInAllDays:
                  true, // To display live time line in all pages in week view.
              width: 400, // width of week view.
              minDay: DateTime(1990),
              maxDay: DateTime(2050),
              initialDay: DateTime(2021),
              heightPerMinute: 1, // height occupied by 1 minute time span.
              eventArranger:
                  SideEventArranger(), // To define how simultaneous events will be arranged.
              onEventTap: (events, date) => print(events),
              onDateLongPress: (date) => print(date),
              startDay: WeekDays.sunday, // To change the first day of the week.
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }
}

class MonthPage extends StatefulWidget {
  List<CustomCalendarEventData> _events;

  MonthPage(this._events, {Key? key}) : super(key: key);

  @override
  State<MonthPage> createState() => _MonthPageState(_events);
}

class _MonthPageState extends State<MonthPage> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  List<CustomCalendarEventData> _allEvents;
      String classID;
    String className;
    MemoryImage classPhoto;
    
  late List<CustomCalendarEventData> _currentEvents;

  _MonthPageState(this._allEvents, this.classID, this.className, this.classPhoto) {
    _currentEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    EventList dayEventDisplay = EventList(_currentEvents);

    MonthView monthView = MonthView(
      borderColor: Colors.deepPurple,
      borderSize: 0.2,
      controller: EventController()..addAll(_allEvents),
      // to provide custom UI for month cells.
      minMonth: DateTime(1990),
      maxMonth: DateTime(2050),
      initialMonth: DateTime(selectedYear, selectedMonth),
      cellAspectRatio: 1,
      onPageChange: (date, pageIndex) {
        selectedMonth = date.month;
        selectedYear = date.year;
      },
      onCellTap: (events, date) {
        // Implement callback when user taps on a cell.
        selectedDay = date.day;
        selectedMonth = date.month;
        _currentEvents = events.cast<CustomCalendarEventData>();
        print(_currentEvents.toString() + ", " + events.toString());
        setState(() {});
      },
      startDay: WeekDays.sunday, // To change the first day of the week.
      // This callback will only work if cellBuilder is null.
      onEventTap: (event, date) {},
      onDateLongPress: (date) => print(date),
    );
    print("iiiii");
    return CalendarControllerProvider(
        controller: EventController()..addAll(_allEvents),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Leap'),
              backgroundColor: Colors.deepPurple,
            ),
            body: Column(children: [
              Flexible(
                child: monthView,
                flex: 3,
              ),
              Flexible(child: dayEventDisplay)
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                  showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050))
                      .then((date) {
                                            String details = "";

                  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Confirm"))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Now, add your event details.",
                  style: FontStandards.getTextStyle(
                      CustomColorScheme.defaultColors,
                      Style.normHeader,
                      FontSize.medium),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  onChanged: ((value) {
                    details = value;
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          );
        }).then((value) {
            FirebaseEvent fe = FirebaseEvent(details, date.dayOfMonth, date.month, date.year,
                                 className, classPhoto.bytes);
            _allEvents.add(fe);
            CalendarFirebaseAccessor()
                .addEvent(
                    FirebaseEvent(details, date.dayOfMonth, date.month, date.year,
                                 className, classPhoto.bytes)
                );
            setState(() {});
        });
                      });
                // monthView.controller!.add(CalendarEventData(
                //   title: "Regionals",
                //   date: DateTime(2022, 10, 10),
                //   event: "Regionals",
                // ));
              },
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.add),
            )));
  }
}
