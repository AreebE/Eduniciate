class Event {
  String _message;
  int _dayOfMonth;
  int _month;
  int _year;

// Testing the settings
  Event(this._message, this._dayOfMonth, this._month, this._year);

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
}
