import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/page/LoginAndRegister.dart';
import 'package:debit/page/PersonInfo.dart';
import 'package:debit/widgets/RowLayoutWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///“我的” 页面
class MinePage extends StatefulWidget {
  @override
  _MinePageStateless createState() => _MinePageStateless();
}

class _MinePageStateless extends State<MinePage> {
  bool isLogin = false;
  final String userInfo = 'assets/images/user_info.png';
  final String userBorrow = 'assets/images/user_borrow.png';
  final String userRepay = 'assets/images/user_repay.png';
  final String userPassword = 'assets/images/user_password.png';
  final String userExit = 'assets/images/user_exit.png';

  @override
  Widget build(BuildContext context) {


    TapGestureRecognizer _recognizer(bool isLogin){

      final TapGestureRecognizer recognizer = new TapGestureRecognizer();
      recognizer.onTap=(){
        Navigator.of(context).push(new MaterialPageRoute(builder: (context){
          return new LoginAndRegister(isLogin);
        }));
      };
      return recognizer;
    }

    return new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(color: AppColors.backgroundColor),

              child: new Column(
                children: <Widget>[
                  new Expanded(
                    flex:1,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: new Center(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImage.getAssetIcon(AppIcons.DEFAULT_USER_ICON,60.0,60.0),
                            new Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new RichText(
                                      text: new TextSpan(
                                          text: "登录",
                                          recognizer: _recognizer(true),
                                          style: new TextStyle(
                                              fontSize: 18, color: Colors.white))),
                                  new Text(
                                    '/',
                                    style: new TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  new RichText(
                                      text: new TextSpan(
                                          text: "注册",
                                          recognizer: _recognizer(false),
                                          style: new TextStyle(
                                              fontSize: 18, color: Colors.white)))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  new Expanded(
                      flex:2,
                      child: new ListView(
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(color: Colors.white),
                            margin: EdgeInsets.only(top: 10.0),
                            child: new Column(
                              children: <Widget>[
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userInfo), "我的资料",
                                    Icons.chevron_right, '/personInfo'),
                                AppDivider.thinDivider(),
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userBorrow), "我的借贷",
                                    Icons.chevron_right, '/personDebit'),
                                AppDivider.thinDivider(),
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userRepay), "我的还款",
                                    Icons.chevron_right, '/personRepayment'),
                                AppDivider.thinDivider(),
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userInfo), "客服",
                                    Icons.chevron_right, '/personCustomerService'),
                                AppDivider.thinDivider(),
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userPassword), "修改密码",
                                    Icons.chevron_right, '/personModifyPassword'),
                                AppDivider.thinDivider(),
                                new RowLayoutWidget(AppImage.getAssetIconFrom(userExit), "退出登录",
                                    Icons.chevron_right, '/personSignOut'),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),

                ],
              )
        )
    );
  }
}
