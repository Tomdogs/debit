import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonPhoneNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonPhoneNumberState();
  }
}

class PersonPhoneNumberState extends State<PersonPhoneNumber> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final String key0 = 'user_netroom_phonenum';
  static final String key1 = 'user_netroom_password';
  static final String keyID = 'userId';

  Map<String,dynamic> _formData = {
    key0:null,
    key1:null,
    keyID:null,
  };
  Map<String,TextEditingController> textController = {
    key0: new TextEditingController(),
    key1: new TextEditingController(),
  };

  bool isCheck = true;
  ///表单
  Widget formWidget(String title, String desc, String key) {
    return new Container(
      margin: EdgeInsets.only(left: 5, top: 1, right: 5, bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(6.0))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            flex: 4,
            child: new Padding(
              padding: EdgeInsets.all(5),
              child: new Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ),
          new Expanded(
              flex: 7,
              child: new Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: new TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  controller: textController[key],
                  decoration: new InputDecoration(
                    hintText: desc,
                  ),
                  validator: (String value) {
//                    print("---validator---");
                    print("validator key为:$key , value 为：$value");
                    //删除首尾空格
                    if (value == null || value.isEmpty || value.trim().length == 0) {
                      print('$title 验证不能通过：$value');
                      return '此处不能为空!';
                    }
                  },
                  onSaved: (String value) {
                    ///当调用FormState.save方法的时候调用
                    print("---onSaved---");
                    print("onSaved保存的key为:$key , value 为：$value");
                    _formData[key] = value;
                  },
                ),
              ))
        ],
      ),
    );
  }

  void _formSubmitted(store) {
    var _form = _formKey.currentState;
    print("form状态：${_form.validate()}");

    if (_form.validate()) {
      _form.save();

      print('-----------------------------验证完成后的属性值------------------------------：');
      print("手机号认证：${_formData[key0]}");

      _formData.forEach((key,value){
        print(key+":"+value.toString());
      });

      User user = store.state.userInfo;
      _formData[keyID] = user.userID;

      UserDao.getUserPhoneNumberInfo(_formData).then((res){
        String msg= res.data;
        if(res.result){
          Navigator.pop(context);
          new Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, '/managerHome');
            return true;
          });

          User newUser = new User(userID:user.userID,phoneNumber:user.phoneNumber,userPassword:user.userPassword,
              flagOne: user.flagOne,flagTwo: user.flagTwo,flagThree: user.flagThree,flagFour: 1);
          store.dispatch(new UpdateUserAction(newUser));
        }else{
          Toast.toast(context,msg);
        }
      });

    }else{
      Toast.toast(context,'请填写完整表单！');
    }
  }

  final TapGestureRecognizer recognizer = new TapGestureRecognizer();


  void _getPhoneNumber()async{
    UserDao. getQueryPhoneNumberInfo().then((res) {
      if (res.result) {
        Data data = res.data;
        textController[key0].text = data.userNetroomPhonenum;
        textController[key1].text = data.userNetroomPassword ;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPhoneNumber();
  }
  @override
  Widget build(BuildContext context) {
    recognizer.onTap = (){
      print("点击了用户协议书");
    };
    return new StoreBuilder<ReduxState>(
      builder: (context,store){
        return new Scaffold(
            appBar: new AppBar(
              title: new Text('手机号认证'),
              centerTitle: true,
            ),
            body: new Container(
              decoration: BoxDecoration(color: AppColors.backgroundColor),
              child: new ListView(
                children: <Widget>[
                  new Form(
                    key: _formKey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Container(
                          padding: new EdgeInsets.only(left:10,top: 10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("请确认网厅登录密码是否正确，以免运营商锁定密码带来不便！",style: new TextStyle(color: Colors.black45))
                            ],
                          ),
                        ),

                        formWidget('手机号码', '请输入手机号码', key0),
                        formWidget('网厅登录密码', '请输入网厅登录密码', key1),
//                    formWidget('图片验证码', '请输入图片验证码', key1),
                        new Row(
                          children: <Widget>[
                            new Checkbox(
                                value: isCheck,
                                onChanged: (bool){
                                  print("选择的$bool");
                                  setState(() {
                                    isCheck = bool;
                                  });
                                }
                            ),
                            new RichText(
                                text: new TextSpan(
                                    text: "同意",
                                    style: new TextStyle(color: Colors.blue),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: '《用户使用协议》',
                                        style: new TextStyle(color: Colors.red),
                                        recognizer:recognizer,
                                      )
                                    ]
                                )
                            )
                          ],
                        ),


                        new Padding(padding: EdgeInsets.all(20.0)),
                        new Container(
                          margin: EdgeInsets.all(10),
                          child: new FlexButton(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            text: "提交认证",
                            onPress: () {
                              _formSubmitted(store);
                            },
                          ),
                        ),
                        new Container(
                          padding: new EdgeInsets.only(left:10,top: 10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("温馨提示:",style: new TextStyle(color: Colors.black45),),
                              new Text("手机服务密码是运营商网站登录密码，若忘记密码，请您到运营商网站找回来！",style: new TextStyle(color: Colors.black45))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
