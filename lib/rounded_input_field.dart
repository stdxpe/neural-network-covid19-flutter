import 'package:flutter/material.dart';
import 'textfield_container.dart';

class RoundedInputField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final Function onChanged;
  final TextEditingController controller;

  const RoundedInputField(
      {Key key, this.icon, this.hintText, this.onChanged, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF817889),
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
          border: InputBorder.none,
          icon: icon,
        ),
        // keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
