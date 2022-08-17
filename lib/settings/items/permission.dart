// ignore_for_file: prefer_final_fields

class Permission {
  String _name;
  String _link;
  bool _enabled;

  Permission(this._name, this._link, this._enabled);

  String getName() {
    return _name;
  }

  String getLink() {
    return _link;
  }

  bool isEnabled() {
    return _enabled;
  }

  void changeEnabled(bool isEnabled) {
    _enabled = isEnabled;
  }
}
