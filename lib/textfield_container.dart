import 'package:flutter/material.dart';
import 'constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: kDefaultPadding * 1, vertical: 18),
      margin: EdgeInsets.only(bottom: kDefaultMargin * 0.6),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: kTextFieldBgColor.withOpacity(0.9),
        borderRadius: kBorderRadiusSmall,
      ),
      child: child,
    );
  }
}
