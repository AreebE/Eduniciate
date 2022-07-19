import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ClassDisplay extends StatefulWidget {
  const ClassDisplay({Key? key}) : super(key: key);

  @override
  State<ClassDisplay> createState() => _ClassDisplayState();
}

class _ClassDisplayState extends State<ClassDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
    );
  }
}
