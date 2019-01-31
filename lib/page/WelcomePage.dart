import 'dart:async';

import 'package:debit/common/utils/CommonUtils.dart';
import 'package:flutter/material.dart';

/**
 * 欢迎页
 *
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>  {

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(hadInit) {
      return;
    }
    hadInit = true;
    ///防止多次进入
//    Store<GSYState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);

    new Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/managerHome');
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
        child: new Text("欢迎您"),
      ),
    );
  }

}
