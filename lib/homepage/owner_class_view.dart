import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class OwnerClassDisplay extends StatefulWidget {
  const OwnerClassDisplay({Key? key}) : super(key: key);

  @override
  State<OwnerClassDisplay> createState() => _OwnerClassDisplayState();
}

class _OwnerClassDisplayState extends State<OwnerClassDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
    );
  }
}
