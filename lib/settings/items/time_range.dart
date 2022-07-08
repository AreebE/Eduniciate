class TimeRange {
  String _start;
  String _end;

  TimeRange(this._start, this._end);

  String getStart() {
    return _start;
  }

  String getEnd() {
    return _end;
  }

  void changeStart(String newStart) {
    _start = newStart;
  }

  void changeEnd(String newEnd) {
    _end = newEnd;
  }
}
