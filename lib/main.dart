import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/page/ManagerHome.dart';
import 'package:debit/page/PersonBankCardInfo.dart';
import 'package:debit/page/PersonBasicInfo.dart';
import 'package:debit/page/PersonCustomerService.dart';
import 'package:debit/page/PersonDebit.dart';
import 'package:debit/page/PersonInfo.dart';
import 'package:debit/page/PersonModifyPassword.dart';
import 'package:debit/page/PersonPhoneNumber.dart';
import 'package:debit/page/PersonReferenceInfo.dart';
import 'package:debit/page/PersonRepayment.dart';
import 'package:debit/page/PersonSignOut.dart';
import 'package:debit/page/WelcomePage.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String url = 'http://c105.pop800.com/web800/c.do?n=428632&type=1&url=http%3A%2F%2Ft5k7m4x2.gotoip3.com%2Findex.php%3Fm%3DHelp%26a%3Dindex&l=cn&at=0';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,///整个APP的默认颜色
        backgroundColor: AppColors.backgroundColor,
      ),
      routes: <String,WidgetBuilder>{

        "/":(BuildContext context) => new WelcomePage(),
        '/personInfo':(BuildContext context) => new PersonInfo(),
        '/managerHome':(BuildContext context) => new ManagerHome(),
        '/personBasicInfo':(BuildContext context) => new PersonBasicInfo(),
        '/imagePickerWidget':(BuildContext context) => new ImagePickerWidget(),
        '/personReferenceInfo':(BuildContext context) => new PersonReferenceInfo(),
        '/personBankCardInfo':(BuildContext context) => new PersonBankCardInfo(),
        '/personPhoneNumber':(BuildContext context) => new PersonPhoneNumber(),
        '/personCustomerService':(BuildContext context) => new PersonCustomerService(url,'客服'),
        '/personModifyPassword':(BuildContext context) => new PersonModifyPassword(),
        '/personDebit':(BuildContext context) => new PersonDebit(),
        '/personSignOut':(BuildContext context) => new PersonSignOut(),
        '/personRepayment':(BuildContext context) => new PersonRepayment(),
      },
    );
  }
}


