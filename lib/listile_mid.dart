import 'package:flutter/material.dart';

class ListileMid extends StatelessWidget {
  final String title;
  final String subtitle;
  final String result;
  final String photoUrl;
  final Color backgroundColor;

  const ListileMid(
      {Key key,
      this.title,
      this.subtitle,
      this.result,
      this.photoUrl,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.withOpacity(0.1),
      child: ListTile(
        // contentPadding: EdgeInsets.symmetric(horizontal: 30),
        dense: true,
        title: Text(
          title,
          softWrap: false,
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.left,
        ),

        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 10,
        ),
        trailing: Container(
          constraints: BoxConstraints(maxWidth: 110),
          child: Text(
            result,
            softWrap: false,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1.5,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
