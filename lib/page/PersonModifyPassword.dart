import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonModifyPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonModifyPasswordState();
  }
}

class PersonModifyPasswordState extends State<PersonModifyPassword> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final String key0 = 'userNetroomPhonenum';
  static final String key1 = 'userNetroomPassword';
  static final String key2 = 'userPassWord';
  static final String keyID = 'userId';

  Map<String,dynamic> _formData = {
    key0:null,
    key1:null,
    key2:null,
    keyID:null
  };
  Map<String,TextEditingController> textController = {
    key0: new TextEditingController(),
    key1: new TextEditingController(),
    key2: new TextEditingController(),
  };
  bool isCheck = true;
  ///表单
  Widget formWidget(String title, String desc, String key,bool isEnable) {



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
                  enabled: isEnable == true ? true:false,//是否不可编辑
                  controller: textController[key],
                  decoration: new InputDecoration(
                    hintText: desc,
                  ),
                  validator: (String value) {
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
      print("手机号：${_formData[key0]}");

      _formData.forEach((key,value){
        print(key+":"+value.toString());
      });

      User user = store.state.userInfo;
      _formData[keyID] = user.userID;
      CommonUtils.showLoadingDialog(context,text:'正在上传...');
      UserDao.getUpdatePassword(_formData,context).then((res){
        String msg= res.data;
        if(res.result){
          Toast.toast(context, "信息上传成功！");
          new Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
//            Navigator.pushReplacementNamed(context, '/managerHome');
            Navigator.pop(context);//销毁当前页
            return true;
          });
        }else{
          Navigator.pop(context);
          Toast.toast(context,msg);
        }
      });

    }else{
      Toast.toast(context,'请填写完整表单！');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();

  }

  void _getUserInfo() async{

    UserDao.getUserById(context).then((res){
      if(res != null && res.result) {
        Data data = res.data;
        print("修改密码1：${data.userName}");
        print("修改密码2：${data.userNetroomPhonenum}");

//        textController[key0].text = data.userName;
        textController[key0].text = data.userNetroomPhonenum;

      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('修改密码'),
          centerTitle: true,
        ),
        body: new StoreBuilder<ReduxState>(
          builder: (context,store){
            User user = store.state.userInfo;
            return new Container(
              decoration: BoxDecoration(color: AppColors.backgroundColor),
              child: new ListView(
                children: <Widget>[
                  new Form(
                    key: _formKey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(top: 10)),

                        formWidget('手机号码', '请输入手机号码', key0,false),
//                    formWidget('图片验证码', '请输入图片验证码', key1),
                        formWidget('网厅密码', '请输入网厅密码', key1,true),
                        formWidget('新密码', '请设置6-16位密码', key2,true),

                        new Padding(padding: EdgeInsets.all(20.0)),
                        new Container(
                          margin: EdgeInsets.all(10),
                          child: new FlexButton(
                            textColor: Colors.white,
                            color:  Theme.of(context).primaryColor,
                            text: "完成",
                            onPress: () {

                                _formSubmitted(store);

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        )
    );
  }
}
