import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

DateTime get _now => DateTime.now();

//DateTime get _now => DateTime.now();

void main() {
  runApp(CalendarPage());
}

class CalendarPage extends StatelessWidget {
  final event = CalendarEventData(
    title: "Regionals",
    date: DateTime(2022, 9, 10),
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                "Day View",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DayPage()),
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              child: Text(
                "Week View",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WeekPage()),
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              child: Text(
                "Month View",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MonthPage()),
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ))));
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
              body: DayView(
                controller: EventController(),
                eventTileBuilder: (date, events, boundry, start, end) {
                  // Return your widget to display as event tile.
                  return Container();
                },
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

class MonthPage extends StatelessWidget {
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
              body: MonthView(
                borderColor: Colors.deepPurple,
                borderSize: 0.2,
                controller: EventController(),
                // to provide custom UI for month cells.
                cellBuilder: (date, events, isToday, isInMonth) {
                  // Return your widget to display as month cell.
                  return Container();
                },
                minMonth: DateTime(1990),
                maxMonth: DateTime(2050),
                initialMonth: DateTime(2021),
                cellAspectRatio: 1,
                onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
                onCellTap: (events, date) {
                  // Implement callback when user taps on a cell.
                  print(events);
                },
                startDay:
                    WeekDays.sunday, // To change the first day of the week.
                // This callback will only work if cellBuilder is null.
                onEventTap: (event, date) => print(event),
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
