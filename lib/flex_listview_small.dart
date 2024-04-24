import 'package:flutter/material.dart';

class FlexListViewSmall extends StatelessWidget {
  final int index;
  final Color color;
  final String text;
  final int itemCount;
  final double height;
  final Function function;
  final double fontSize;

  const FlexListViewSmall(
      {Key key,
      this.index,
      this.color,
      this.text,
      this.itemCount,
      this.height,
      this.function,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        // padding: EdgeInsets.only(bottom: 10),
        color: Colors.black.withOpacity(0.7),
        child: ListView.builder(
          // dragStartBehavior: DragStartBehavior.start,
          itemExtent: 100,
          // shrinkWrap: true,

          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 3, left: 3),
              child: Container(
                height: height,
                width: 100,
                color: color,
                child: Center(
                  child: Text(
                    function(index),
                    style: TextStyle(fontSize: fontSize, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
