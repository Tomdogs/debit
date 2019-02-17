import 'dart:async';

import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
    ///防止多次进入
    if(hadInit) {
      return;
    }
    hadInit = true;
    Store<ReduxState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);

    new Future.delayed(const Duration(seconds: 1),(){
      UserDao.initUserInfo(store).then((res) {

        print('在欢迎页：res:${res.result}');
        if(res != null && res.result){
          Toast.toast(context,'已经登录了！');
        }else{
          Toast.toast(context,'还没有登录！');
        }

        Navigator.pushReplacementNamed(context, '/managerHome');
      });

    });
  
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
        child: new Image.asset('assets/images/guidePage.png'),
      ),
    );
  }

}
