import 'dart:async';

import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/InputWidget.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';

///登录和注册页面
class Login extends StatefulWidget {
  static final String sName = "login";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginState();
  }

}

class _LoginState extends State<Login> {
  var _phoneNumber = "";
  var _user_password = "";
  var _netRoom_password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();
  final TextEditingController netPwController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initParams();
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  initParams() async {
//    _phoneNumber = await LocalStorage.get(Config.USER_PHONE_KEY);
//    _user_password = await LocalStorage.get(Config.PW_KEY);

    print("存储的用户名：${_phoneNumber},密码为${_user_password}");

    userController.value = new TextEditingValue(text: _phoneNumber ?? "");
    pwController.value = new TextEditingValue(text: _user_password ?? "");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new StoreBuilder<ReduxState>(
      builder: (context, store) {
        return new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
              appBar: new AppBar(
                title:  new Text("登录"),
                centerTitle: true,
              ),
              body: new ListView(
                children: <Widget>[
                  new Container(
                      child: new Center(
                    child: new Padding(
                      padding: new EdgeInsets.only(
                          left: 30.0, top: 30.0, right: 30.0, bottom: 0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image(
                              image: new AssetImage(AppIcons.DEFAULT_USER_ICON),
                              width: 90.0,
                              height: 90.0),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "请输入手机号",
                            iconData: Icons.phone_iphone,
                            onChanged: (String value) {
                              _phoneNumber = value;
                              print("onChanged 姓名---------------：$_phoneNumber");
                            },
                            controller: userController,
                            keyboardType: TextInputType.number,
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "请输入6-12位密码",
                            iconData: Icons.lock,
                            obscureText: true,
                            onChanged: (String value) {
                              _user_password = value;
                            },
                            controller: pwController,
                          ),
                          
                          new Padding(padding: new EdgeInsets.all(30.0)),
                          new FlexButton(
                            text:  "登录",
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPress: () {

                                if (_phoneNumber == null ||
                                    _phoneNumber.length == 0 || !CommonUtils.isChinaPhoneLegal(_phoneNumber.trim())) {
                                  Toast.toast(context, '请输入正确的手机号！');
                                  return;
                                }
                                if (_user_password == null ||
                                    _user_password.length == 0) {
                                  Toast.toast(context, '请输入密码！');
                                  return;
                                }
                                CommonUtils.showLoadingDialog(context);
                                UserDao.login(_phoneNumber.trim(), _user_password.trim(), store,context).then((res){
                                  print("login " + res.toString());
                                  Toast.toast(context, "登录成功！");
                                  if(res.data != null && res.result){
                                    new Future.delayed(const Duration(seconds: 1), () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(context, '/managerHome');
                                    });

                                  }else if(res.data != null){
                                    Navigator.pop(context);
                                    Toast.toast(context, res.data.toString());
                                  }else{
                                    Navigator.pop(context);
                                    Toast.toast(context, '网络错误！');
                                  }
                                });

                            },
                          ),
                          new Padding(padding: new EdgeInsets.only(top:10.0)),
                          new FlexButton(
                            text:  "注册",
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                              onPress: () {
                                Navigator.pushReplacementNamed(context, '/register');
                              }

                          )
                        ],
                      ),
                    ),
                  )),
                ],
              )),
        );
      },
    );
  }
}
