import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/RowLayoutWidget.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:dio/dio.dart';
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

  String message = '提交审核';
  int userExamineStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _getUserInfo();
  }
  void _getUserInfo()async{
    UserDao.getUserById(context).then((res){
      if(res != null && res.result) {
        Data data = res.data;
        print("提交审核的状态：${data.userExamineStatus}");
        setState(() {
          userExamineStatus = data.userExamineStatus;
          switch(userExamineStatus){
          /// 0 待提交 1 审核中 2 审核不通过 3  审核成功
            case 0:
              message = '提交审核';
              break;
            case 1:
              message = '审核中';
              break;
            case 2:
              message = '审核不通过';
              break;
            case 3:
              message = '审核成功';
              break;
          }
        });

      }
    });
  }

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
                  /*new Padding(padding: EdgeInsets.all(30.0)),
                  new Container(
                    margin: EdgeInsets.all(10),
                    child: new FlexButton(
                      textColor: Colors.white,
                      color: userExamineStatus == 0 ?Theme.of(context).primaryColor:Colors.grey,
                      text: message,
                      onPress: () {
                        if(userExamineStatus == 0){
                          FormData formData = new FormData();
                          formData.add('id', store.state.userInfo.userID);
                          formData.add('state', 1);
                          UserDao.getUpdateUserExamineState(formData,context).then((res){
                            if(res.data != null && res.result){
                              print("点击了提交审核按钮");
                              Toast.toast(context, res.data);
                            }else if(!res.result){
                              Toast.toast(context, res.data.toString());
                            }
                          });
                        }

                      },
                    ),
                  ),*/
                ],
              ),
            );
          },
        )

    );
  }
}
