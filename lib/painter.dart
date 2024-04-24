import 'package:flutter/material.dart';

import 'constants.dart';

// class LinePainter extends CustomPainter {
//   Offset offsetX;
//   Offset offsetY;
//   LinePainter({this.offsetX, this.offsetY});
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Define a paint object
//     //kalem
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5
//       ..color = Colors.white;

//     canvas.drawLine(offsetX, offsetY, paint);
//   }

//   @override
//   bool shouldRepaint(LinePainter oldDelegate) => false;
// }

class LinePainter extends CustomPainter {
  final String hintText;
  final String list1;
  final String list2;

  LinePainter({this.hintText, this.list1, this.list2});
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    //kalem
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    for (int i = 0; i < inputs.length; i++) {
      for (int j = 0; j < hiddens.length; j++) {
        Offset offsetX = offsetsPositionsMap['inputs$i'];
        Offset offsetY = offsetsPositionsMap['hiddens$j'];

        // print('Input $offsetX - Hidden $offsetY');
        canvas.drawLine(offsetX, offsetY, paint);
      }
    }

    for (int j = 0; j < hiddens.length; j++) {
      for (int k = 0; k < outputs.length; k++) {
        Offset offsetX = offsetsPositionsMap['hiddens$j'];
        Offset offsetY = offsetsPositionsMap['outputs$k'];

        // print('Hidden $offsetX - Output $offsetY');
        canvas.drawLine(offsetX, offsetY, paint);
      }
    }

    final paintRed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = Colors.red;

    if (hintText != '?') {
      int shreddedHintTextX = int.parse(hintText[1]);
      int shreddedHintTextY = int.parse(hintText[4]);
      Offset redOffsetX = offsetsPositionsMap['$list1$shreddedHintTextX'];
      Offset redOffsetY = offsetsPositionsMap['$list2$shreddedHintTextY'];

      canvas.drawLine(redOffsetX, redOffsetY, paintRed);
    }

    // print('inputs$shreddedHintTextX');
    // print('hiddens$shreddedHintTextY');

    // print('Input $offsetX - Hidden $offsetY');
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}

class LinePainter2 extends CustomPainter {
  final String hintText;
  final String list1;
  final String list2;

  LinePainter2({this.hintText, this.list1, this.list2});
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    //kalem
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    for (int i = 0; i < inputs.length; i++) {
      for (int j = 0; j < hiddens.length; j++) {
        Offset offsetX = offsetsPositionsMap['inputs$i'];
        Offset offsetY = offsetsPositionsMap['hiddens$j'];

        // print('Input $offsetX - Hidden $offsetY');
        canvas.drawLine(offsetX, offsetY, paint);
      }
    }

    for (int j = 0; j < hiddens.length; j++) {
      for (int k = 0; k < hiddens2.length; k++) {
        Offset offsetX = offsetsPositionsMap['hiddens$j'];
        Offset offsetY = offsetsPositionsMap['hiddens2$k'];

        // print('Hidden $offsetX - Output $offsetY');
        canvas.drawLine(offsetX, offsetY, paint);
      }
    }

    for (int k = 0; k < hiddens2.length; k++) {
      for (int m = 0; m < outputs.length; m++) {
        Offset offsetX = offsetsPositionsMap['hiddens2$k'];
        Offset offsetY = offsetsPositionsMap['outputs$m'];

        // print('Hidden $offsetX - Output $offsetY');
        canvas.drawLine(offsetX, offsetY, paint);
      }
    }

    // final paintRed = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 6
    //   ..color = Colors.red;

    // if (hintText != '?') {
    //   int shreddedHintTextX = int.parse(hintText[1]);
    //   int shreddedHintTextY = int.parse(hintText[4]);
    //   Offset redOffsetX = offsetsPositionsMap['$list1$shreddedHintTextX'];
    //   Offset redOffsetY = offsetsPositionsMap['$list2$shreddedHintTextY'];

    //   canvas.drawLine(redOffsetX, redOffsetY, paintRed);
    // }

    // print('inputs$shreddedHintTextX');
    // print('hiddens$shreddedHintTextY');

    // print('Input $offsetX - Hidden $offsetY');
  }

  @override
  bool shouldRepaint(LinePainter2 oldDelegate) => false;
}

class MyCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    //kalem
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white;

    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = Colors.green;

    // canvas.drawOval(
    //   Rect.fromLTWH(-40, -20, circleRadius, circleRadius),
    //   paint2,
    // );

    // canvas.drawOval(
    //   Rect.fromLTWH(-40, -20, circleRadius, circleRadius),
    //   paint,
    // );
    canvas.drawCircle(Offset(0, 0), circleRadius, paint2);
    canvas.drawCircle(Offset(0, 0), circleRadius, paint);
  }

  @override
  bool shouldRepaint(MyCircle oldDelegate) => false;
}
