import 'package:basit_dogrusal_regresyon_01/constants.dart';
import 'package:flutter/material.dart';

class ListileTop extends StatelessWidget {
  final String title;
  final String subtitle;
  final String result;
  final String photoUrl;

  const ListileTop(
      {Key key, this.title, this.subtitle, this.result, this.photoUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        dense: true,
        title: Text(
          title,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              letterSpacing: 0,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
        ),
        leading: Container(
          height: 50,
          width: 50,
          child: Image.asset(
            'assets/images/$photoUrl',
            fit: BoxFit.cover,
            alignment: Alignment(0.0, 0),
          ),
        ),
        trailing: Container(
          constraints: BoxConstraints(maxWidth: 120),
          child: Text(
            result,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 35,
                // fontFamily: 'Montserrat-Bold',
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
