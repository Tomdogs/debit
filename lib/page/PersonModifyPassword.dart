import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PersonModifyPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonModifyPasswordState();
  }
}

class PersonModifyPasswordState extends State<PersonModifyPassword> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final String key0 = 'phoneNumber';
  static final String key1 = 'pictureVerificationCode';
  static final String key2 = 'messageVerificationCode';
  static final String key3 = 'newPassword';

  Map<String,dynamic> _formData = {
    key0:null,
    key1:null,
    key2:null,
    key3:null,
  };
  Map<String,TextEditingController> textController = {
    key0: new TextEditingController(),
    key1: new TextEditingController(),
    key2: new TextEditingController(),
    key3: new TextEditingController(),
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
            flex: 3,
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

  void _formSubmitted() {
    var _form = _formKey.currentState;
    print("form状态：${_form.validate()}");

    if (_form.validate()) {
      _form.save();

      print('-----------------------------验证完成后的属性值------------------------------：');
      print("手机号：${_formData[key0]}");

      _formData.forEach((key,value){
        print(key+":"+value.toString());
      });

    }else{
      Toast.toast(context,'请填写完整表单！');
    }
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('修改密码'),
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

                    formWidget('手机号码', '请输入手机号码', key0),
                    formWidget('图片验证码', '请输入图片验证码', key1),
                    formWidget('短信验证', '请输入验证码', key2),
                    formWidget('新密码', '请设置6-16位密码', key3),

                    new Padding(padding: EdgeInsets.all(20.0)),
                    new Container(
                      margin: EdgeInsets.all(10),
                      child: new FlexButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        text: "完成",
                        onPress: () {
                          _formSubmitted();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
