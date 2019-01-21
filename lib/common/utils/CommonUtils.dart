
import 'package:flutter/cupertino.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';

class CommonUtils{
  static double sStaticBarHeight = 0.0;
  static void initStatusBarHeight(context) async {
    sStaticBarHeight = await FlutterStatusbar.height / MediaQuery.of(context).devicePixelRatio;
  }
}