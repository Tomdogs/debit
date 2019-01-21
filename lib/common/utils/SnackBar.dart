import 'package:flutter/material.dart';

class TextSnackBar{

  static getSnackBar(BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey,String text){
    final snackbar = new SnackBar(content: new Text(text));
//    Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}