import 'package:flutter/material.dart';

/// 带图标的输入框
class InputWidget extends StatefulWidget {
  final bool obscureText;

  final String hintText;

  final IconData iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  final bool visible;

  InputWidget({Key key, this.hintText, this.iconData, this.onChanged, this.textStyle, this.controller, this.obscureText = false,this.visible = false}) : super(key: key);

  @override
  _InputWidgetState createState() => new _InputWidgetState();
}

/// State for [GSYInputWidget] widgets.
class _InputWidgetState extends State<InputWidget> {

  _InputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return new Offstage(
      child: new TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        decoration: new InputDecoration(
          hintText: widget.hintText,
          icon: widget.iconData == null ? null : new Icon(widget.iconData),
        ),
      ),
      offstage: widget.visible,///可控制 widget的显示(false)和隐藏(true)
    );
  }
}
