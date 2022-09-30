class FirebaseListener {
  Function(List) _successFunction;
  Function(String) _failFunction;

  FirebaseListener(this._successFunction, this._failFunction);
  void onSuccess(List objects) {
    _successFunction.call(objects);
  }

  void onFailure(String reason) {
    _failFunction(reason);
  }
}
