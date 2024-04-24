import 'package:flutter/material.dart';

class StandartText extends StatelessWidget {
  final String text;
  const StandartText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }
}
