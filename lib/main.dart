import 'package:debit/page/ManagerHome.dart';
import 'package:debit/page/PersonBankCardInfo.dart';
import 'package:debit/page/PersonBasicInfo.dart';
import 'package:debit/page/PersonInfo.dart';
import 'package:debit/page/PersonPhoneNumber.dart';
import 'package:debit/page/PersonReferenceInfo.dart';
import 'package:debit/page/WelcomePage.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     /* title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      routes: <String,WidgetBuilder>{

        "/":(BuildContext context) => new WelcomePage(),
        '/personInfo':(BuildContext context) => new PersonInfo(),
        '/managerHome':(BuildContext context) => new ManagerHome(),
        '/personBasicInfo':(BuildContext context) => new PersonBasicInfo(),
        '/imagePickerWidget':(BuildContext context) => new ImagePickerWidget(),
        '/personReferenceInfo':(BuildContext context) => new PersonReferenceInfo(),
        '/personBankCardInfo':(BuildContext context) => new PersonBankCardInfo(),
        '/personPhoneNumber':(BuildContext context) => new PersonPhoneNumber(),
      },
//      home: TabBarBottomPageWidget(),
//      home: new WelcomePage(),
    );
  }
}


