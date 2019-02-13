import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/RowLayoutWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonInfo extends StatefulWidget {
  @override
  PersonInfoState createState() => PersonInfoState();
}

class PersonInfoState extends State<PersonInfo> {
  final String idCard = "assets/images/my_IDCard.png";
  final String personInfo = "assets/images/my_personInfo.png";
  final String bankCard = "assets/images/my_bankCark.png";
  final String phone = "assets/images/my_phone.png";

  /**
   * new StoreBuilder<ReduxState>(
      builder: (context, store) {
   */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("我的资料"),
          centerTitle: true,
        ),
        body: new StoreBuilder<ReduxState>(
          builder: (context,store){
            return new Container(
              decoration: new BoxDecoration(color: AppColors.backgroundColor),
              child: new ListView(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    child: new Column(
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.all(10.0)),
                        new Text("只需3分钟完成资料验证，即可申请借款哦~")
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Container(
                    decoration: new BoxDecoration(color: Colors.white),
                    margin: EdgeInsets.all(10),
                    child: new Column(
                      children: <Widget>[
                        new RowLayoutWidget(
                          AppImage.getAssetIcon(idCard,30,30),
                          "身份信息",
                          Icons.chevron_right,
                          routeName:'/personBasicInfo',
                          isShowRightString:false,
                          bottomString: '*让我们了解您的基本情况',
                          code: store.state.userInfo.flagOne,),
                        AppDivider.thinDivider(),
                        new RowLayoutWidget(
                          AppImage.getAssetIcon(personInfo,30,30),
                          "资料信息",
                          Icons.chevron_right,
                          routeName:'/personReferenceInfo',
                          isShowRightString:false,
                          bottomString: '*让我们了解您的资料信息',
                          code: store.state.userInfo.flagTwo,
                        ),
                        AppDivider.thinDivider(),
                        new RowLayoutWidget(
                          AppImage.getAssetIcon(bankCard,30,30),
                          "收款银行卡",
                          Icons.chevron_right,
                          routeName:'/personBankCardInfo',
                          isShowRightString:false,
                          bottomString: '*您借的钱将打到该银行卡',
                          code: store.state.userInfo.flagThree,
                        ),
                        AppDivider.thinDivider(),
                        new RowLayoutWidget(
                          AppImage.getAssetIcon(phone,30,30),
                          "手机号认证",
                          Icons.chevron_right,
                          routeName:'/personPhoneNumber',
                          isShowRightString:false,
                          bottomString: '*认证您本人的手机号',
                          code: store.state.userInfo.flagFour,
                        ),
                      ],
                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(30.0)),
                  new Container(
                    margin: EdgeInsets.all(10),
                    child: new FlexButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      text: "提交审核",
                      onPress: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        )

    );
  }
}
