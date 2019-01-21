import 'dart:async';
import 'dart:io';

import 'package:debit/page/HomePage.dart';
import 'package:debit/page/LoginAndRegister.dart';
import 'package:debit/page/PersonInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 导航栏
 *
 */
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginAndRegister.sName);
  }

  ///个人中心
  static goPerson(BuildContext context, String userName) {
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new PersonInfo()));
  }

  ///仓库详情
  static Future<Null> goReposDetail(BuildContext context, String userName, String reposName) {
//    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => new RepositoryDetailPage(userName, reposName)));
  }



  ///仓库详情通知
  static Future<Null> goNotifyPage(BuildContext context) {
//    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => new NotifyPage()));
  }

  ///搜索
  static Future<Null> goSearchPage(BuildContext context) {
//    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => new SearchPage()));
  }



}
