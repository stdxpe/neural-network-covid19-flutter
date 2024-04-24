import 'package:flutter/material.dart';

class XYInputField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final Function onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoFocus;

  const XYInputField({
    Key key,
    this.icon,
    this.hintText,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintMaxLines: 2,
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 19,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        icon: icon,
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      autofocus: autoFocus,
    );
  }
}
