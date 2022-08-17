//Rishitha Ravi
//Code for sent and recieved messages
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(SentMessages(
    message: 'hello world',
  ));
}

class RecievedMessages extends StatelessWidget {
  final String message;
  const RecievedMessages({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 191, 191, 191),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              )),
          child: Text(message,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontFamily: 'Josefin Sans',
                fontSize: 15.0,
              )),
        )),
        CustomPaint(painter: Triangle(Color.fromARGB(255, 191, 191, 191))),
      ],
    );
  }
}

//Creates the chat bubble triangle
class Triangle extends CustomPainter {
  final Color backgroundColor;
  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class SentMessages extends StatelessWidget {
  final String message;
  const SentMessages({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,

          //180 degrees
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: Triangle(Color.fromARGB(255, 148, 97, 225)),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 148, 97, 225),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontFamily: 'Josefin Sans',
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
