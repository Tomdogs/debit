import 'package:flutter/material.dart';

///充满的button
class FlexButton extends StatelessWidget {
  final String text;

  final Color color;

  final Color textColor;

  final VoidCallback onPress;

  final double fontSize;
  final int maxLines;

  final MainAxisAlignment mainAxisAlignment;
  final bool visible;
  FlexButton(
      {Key key, this.text, this.color, this.textColor, this.onPress, this.fontSize = 20.0, this.mainAxisAlignment = MainAxisAlignment.center, this.maxLines = 1,this.visible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      child: new RaisedButton(
          padding: new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
          textColor: textColor,
          color: color,
          child: new Flex(
            mainAxisAlignment: mainAxisAlignment,
            direction: Axis.horizontal,
            children: <Widget>[new Text(text, style: new TextStyle(fontSize: fontSize), maxLines: maxLines, overflow:TextOverflow.ellipsis)],
          ),
          onPressed: () {
            this.onPress?.call();
          }),
      offstage: visible ,
    );
  }
}
