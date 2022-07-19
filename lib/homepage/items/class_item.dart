import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class ClassItem {
  late Image _icon;
  String _className;

  ClassItem(List<int> imageBytes, this._className) {
    Uint8List imageList = Uint8List.fromList(imageBytes);
    _icon = Image.memory(imageList);
  }

  Image getImage() {
    return _icon;
  }

  String getClassName() {
    return _className;
  }
}
