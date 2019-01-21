import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/common/utils/SnackBar.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/InputWidget.dart';
import 'package:flutter/material.dart';

///登录和注册页面
class LoginAndRegister extends StatefulWidget {
  static final String sName = "login";
  final bool isLogin;
//  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginAndRegister(this.isLogin);

  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  var _userName = "";
  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);

    print("存储的用户名：${_userName},密码为${_password}");

    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
//        key: widget._scaffoldKey,
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
                        hintText: "请输入用户名",
                        iconData: Icons.person,
                        onChanged: (String value) {
                          _userName = value;
                          print("onChanged 姓名---------------：$_userName");
                        },
                        controller: userController,
                      ),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new InputWidget(
                        hintText: "请输入密码",
                        iconData: Icons.lock,
                        obscureText: true,
                        onChanged: (String value) {
                          _password = value;
                        },
                        controller: pwController,
                      ),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new InputWidget(
                        hintText: "再次确认密码",
                        iconData: Icons.lock,
                        obscureText: true,
                        onChanged: (String value) {
                          _password = value;
                        },
                        controller: pwController,
                        visible: widget.isLogin,

                        ///判断是否需要显示
                      ),
                      new Padding(padding: new EdgeInsets.all(30.0)),
                      new FlexButton(
                        text: widget.isLogin ? "登录" : "注册",
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPress: () {
                          if (widget.isLogin) {
                            if (_userName == null || _userName.length == 0) {
                              return;
                            }
                            if (_password == null || _password.length == 0) {
                              return;
                            }

                            ///  dao 存入
                            bool isLoginSuccess = UserDao.login(
                                _userName.trim(), _password.trim());
                            if (isLoginSuccess) {
                              Navigator.pushNamed(context, '/home');
                            } else {
//                              TextSnackBar.getSnackBar(context,widget._scaffoldKey,"登录失败");
//                              final snackBar = new SnackBar(content: new Text('登录失败'));
//                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          } else {
//                            TextSnackBar.getSnackBar(context,widget._scaffoldKey,"注册");
//                            final snackBar = new SnackBar(content: new Text('注册'));
//                            Scaffold.of(context).showSnackBar(snackBar);
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
  }
}
