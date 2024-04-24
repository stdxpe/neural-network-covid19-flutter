import 'package:flutter/material.dart';
import 'constants.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color color;

  const RoundedButton(
      {Key key,
      @required this.buttonText,
      @required this.color,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(bottom: kDefaultMargin),
      decoration: BoxDecoration(
        color: color,
        borderRadius: kBorderRadiusSmall,
      ),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
