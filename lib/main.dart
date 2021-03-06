import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/page/Login.dart';
import 'package:debit/page/ManagerHome.dart';
import 'package:debit/page/PersonBankCardInfo.dart';
import 'package:debit/page/PersonBasicInfo.dart';
import 'package:debit/page/PersonCustomerService2.dart';
import 'package:debit/page/PersonDebit.dart';
import 'package:debit/page/PersonInfo.dart';
import 'package:debit/page/PersonModifyPassword.dart';
import 'package:debit/page/PersonPhoneNumber.dart';
import 'package:debit/page/PersonReferenceInfo.dart';
import 'package:debit/page/PersonRepayment.dart';
import 'package:debit/page/Register.dart';
import 'package:debit/page/WelcomePage.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//  String url = 'http://c105.pop800.com/web800/c.do?n=428632&type=1&url=http%3A%2F%2Ft5k7m4x2.gotoip3.com%2Findex.php%3Fm%3DHelp%26a%3Dindex&l=cn&at=0';
  String url = 'http://c105.pop800.com/web800/c.do?n=428632&type=1&url=http%3A%2F%2Ft5k7m4x2.gotoip3.com%2Findex.php%3Fm%3DHelp%26a%3Dindex&l=cn&at=0';

  final store = new Store<ReduxState>(
    appReducer,
    initialState: new ReduxState(userInfo: User.empty())
  );


  @override
  Widget build(BuildContext context) {


    return new StoreProvider(
      store:store,
      child:new StoreBuilder<ReduxState>(builder:(context,store){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,///整个APP的默认颜色
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
            '/personCustomerService':(BuildContext context) => new PersonCustomerService2(),
            '/personModifyPassword':(BuildContext context) => new PersonModifyPassword(),
            '/personDebit':(BuildContext context) => new PersonDebit(),
            '/personRepayment':(BuildContext context) => new PersonRepayment(),
            '/login':(BuildContext context) => new Login(),
            '/register':(BuildContext context) => new Register(),
          },
        );
      })
    );
  }
}


