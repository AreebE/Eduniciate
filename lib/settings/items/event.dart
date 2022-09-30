// ignore_for_file: prefer_final_fields

class Event {
  String _message;
  int _dayOfMonth;
  int _month;
  int _year;
  String _className;

// Testing the settings
  Event(this._message, this._dayOfMonth, this._month, this._year,
      this._className);

  String getMessage() {
    return _message;
  }

  int getDayOfMonth() {
    return _dayOfMonth;
  }

  int getMonth() {
    return _month;
  }

  int getYear() {
    return _year;
  }

  String getClassName() {
    return _className;
  }
}
