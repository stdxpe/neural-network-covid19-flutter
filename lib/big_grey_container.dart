import 'package:flutter/material.dart';
import 'constants.dart';

class BigGreyContainer extends StatelessWidget {
  final Widget child;

  const BigGreyContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: kDefaultPadding * 1, vertical: 18),
      margin: EdgeInsets.only(
          bottom: kDefaultMargin * 0.6,
          left: kDefaultMargin * 0.5,
          right: kDefaultMargin * 0.5),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: kTextFieldBgColor.withOpacity(0.9),
        borderRadius: kBorderRadiusMini,
      ),
      child: child,
    );
  }
}
