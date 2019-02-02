import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/common/utils/SnackBar.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/InputWidget.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///登录和注册页面
class LoginAndRegister extends StatefulWidget {
  static final String sName = "login";
  final bool isLogin;

  LoginAndRegister(this.isLogin);

  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
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

  initParams() async {
    _phoneNumber = await LocalStorage.get(Config.USER_PHONE_KEY);
    _user_password = await LocalStorage.get(Config.PW_KEY);

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
                title: widget.isLogin ? new Text("登录") : new Text("注册"),
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
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "请输入网厅密码",
                            iconData: Icons.lock,
                            obscureText: true,
                            onChanged: (String value) {
                              _netRoom_password = value;
                            },
                            controller: netPwController,
                            visible: widget.isLogin,
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new InputWidget(
                            hintText: "请输入用户密码",
                            iconData: Icons.lock,
                            obscureText: true,
                            onChanged: (String value) {
                              _user_password = value;
                            },
                            controller: pwController,
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
                          new FlexButton(
                            text: widget.isLogin ? "登录" : "注册",
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPress: () {

                              if (widget.isLogin) {
                                if (_phoneNumber == null ||
                                    _phoneNumber.length == 0) {
                                  return;
                                }
                                if (_user_password == null ||
                                    _user_password.length == 0) {
                                  return;
                                }

                                ///  dao 存入
                                UserDao.login(_phoneNumber.trim(), _user_password.trim(), store).then((res){
                                  print("login " + res.toString());
                                  Navigator.pop(context);

                                  if(res.data != null && res.result){
                                    new Future.delayed(const Duration(seconds: 1), () {
                                      Navigator.pushReplacementNamed(
                                          context, '/managerHome');
                                    });


                                  }else if(res.data != null){
                                    Toast.toast(context, res.data.toString());
                                  }else{
                                    Toast.toast(context, '网络错误！');
                                  }
                                });



                              } else {
                                if (_phoneNumber == null ||
                                    _phoneNumber.length == 0) {
                                  return;
                                }
                                if (_user_password == null ||
                                    _user_password.length == 0) {
                                  return;
                                }
                                if (_netRoom_password == null ||
                                    _netRoom_password.length == 0) {
                                  return;
                                }
                                UserDao.register(_phoneNumber.trim(), _netRoom_password.trim(), _user_password.trim(), store).then((res){

                                  print("register " + res.toString());
                                  Navigator.pop(context);
                                  if(res.data != null && res.result){
                                    new Future.delayed(const Duration(seconds: 1), () {
                                      Navigator.pushReplacementNamed(context, '/managerHome');
                                      return true;
                                    });

                                  }else if(res.data != null){
                                    Toast.toast(context, res.data.toString());
                                  }else{
                                    Toast.toast(context, '网络错误！');
                                  }
                                  print("注册时：执行了2");
                                });
                              }
                            },
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
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
