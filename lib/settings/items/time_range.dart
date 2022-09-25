import 'package:cloud_firestore/cloud_firestore.dart';

class TimeRange {
  Timestamp _start;
  Timestamp _end;
  String _firebaseID;

  TimeRange(this._firebaseID, this._start, this._end);

  String getStart() {
    return _constructTimeString(_start.toDate());
  }

  String getEnd() {
    return _constructTimeString(_end.toDate());
  }

  DateTime getTime(bool isStart, bool isUtc) {
    DateTime chosen = ((isStart) ? _start : _end).toDate();
    return (isUtc) ? chosen.toUtc() : chosen.toLocal();
  }

  String _constructTimeString(DateTime time) {
    time = time.toLocal();
    int hr = time.hour;
    String min = time.minute.toString();
    if (min.length == 1) {
      min = "0$min";
    }
    String mPart = (hr < 12) ? "\nA.M." : "\nP.M.";
    hr = (hr % 12);
    if (hr == 0) {
      hr = 12;
    }

    return ("$hr:$min$mPart");
  }

  void changeStart(DateTime newStart) {
    _start = Timestamp.fromDate(newStart.toUtc());
  }

  void changeEnd(DateTime newEnd) {
    _end = Timestamp.fromDate(newEnd.toUtc());
  }

  String getID() {
    return _firebaseID;
  }
}
