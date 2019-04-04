import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserBorrowRepay.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonBankCardInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonBankCardInfoState();
  }
}

class PersonBankCardInfoState extends State<PersonBankCardInfo> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final String key0 = 'bankCardUsername';
  static final String key1 = 'bankCardIdcard';
  static final String key2 = 'bankCardBankName';
  static final String key3 = 'bankCardNumber';
  static final String keyID = 'userId';

  Map<String,dynamic> _formData = {
    key0:null,
    key1:null,
    key2:null,
    key3:null,
    keyID:null,
  };
  Map<String,TextEditingController> textController = {
    key0: new TextEditingController(),
    key1: new TextEditingController(),
    key2: new TextEditingController(),
    key3: new TextEditingController(),
  };
  FocusNode _focusNode = new FocusNode();

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

  ///带各个银行功能的表单
  Widget formWidget2(String title,String desc,String key){

    return new Container(
      margin: EdgeInsets.only(left: 5,top: 1,right: 5,bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(6.0))
      ),
      child: new Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            flex: 4,
            child: new Padding(
              padding: EdgeInsets.all(5),
              child: new Text(title,style: TextStyle(fontSize: 16,color: Colors.blue),),
            ),
          ),
          new Expanded(
              flex: 7,
              child: new Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: new TextField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  controller: textController[key],
                  decoration: new InputDecoration(
                    hintText: desc,
                  ),
                  focusNode: _focusNode,
                  obscureText: false,
                  onTap: (){
                    _focusNode.unfocus();//隐藏键盘

                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return new Container(
                            height: 200,
                            child: buildPicker(key),
                          );
                        }
                    );

                  },
                ),
              )
          )
        ],
      ),
    );

  }

  final banks =<String>[
    "工商银行","中国银行","招商银行","建设银行","广发银行","邮储银行", "农业银行",
    "兴业银行","平安银行","中信银行","华夏银行","光大银行","浦发银行","民生银行",];
  Widget buildPicker(String key){
    return new CupertinoPicker(
      children: <Widget>[
        new Text(banks[0]),
        new Text(banks[1]),
        new Text(banks[2]),
        new Text(banks[3]),
        new Text(banks[4]),
        new Text(banks[5]),
        new Text(banks[6]),
        new Text(banks[7]),
        new Text(banks[8]),
        new Text(banks[9]),
        new Text(banks[10]),
        new Text(banks[11]),
        new Text(banks[12]),
        new Text(banks[13]),
      ],
      onSelectedItemChanged:(int i){
        textController[key].value = new TextEditingValue(text:banks[i]);
        _formData[key] = banks[i];
      },
      itemExtent: 50,
    );
  }


  void _formSubmitted(store) {
    var _form = _formKey.currentState;
    print("form状态：${_form.validate()}");
    bool validateFromSelect;
    ///检验 开户银行 是否进行了设置
    if(_formData[key2] == null){
      validateFromSelect = false;
    }else{
      validateFromSelect = true;
    }
    if (_form.validate() && validateFromSelect) {
      _form.save();

      print('-----------------------------验证完成后的属性值------------------------------：');
      print("持卡人姓名：${_formData[key0]}");

      _formData.forEach((key,value){
        print(key+":"+value.toString());
      });

      User user = store.state.userInfo;
      _formData[keyID] = user.userID;

      CommonUtils.showLoadingDialog(context,text:'正在上传...');
      UserDao.getUserBankCardInfo(_formData,context).then((res){
        String msg= res.data;
        if(res.result){
          Toast.toast(context, "信息上传成功！");
          new Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
//            Navigator.pushReplacementNamed(context, '/personInfo');
            Navigator.pop(context);//销毁当前页
            return true;
          });
          User newUser = new User(userID:user.userID,phoneNumber:user.phoneNumber,userPassword:user.userPassword,
              flagOne: user.flagOne,flagTwo: user.flagTwo,flagThree: 1,flagFour: user.flagFour);
          store.dispatch(new UpdateUserAction(newUser));
        }else{
          Navigator.pop(context);
          Toast.toast(context,msg);
        }
      });

    }else{
      Toast.toast(context,'请填写完整表单！');
    }
  }

  void _getBankCardInfo(){
    UserDao. getQueryBankCardInfo(context).then((res) {
      if (res.result) {
        Data data = res.data;
        textController[key0].text = data.bankCardUsername;
        textController[key1].text = data.bankCardIdcard;
        textController[key2].text = data.bankCardBankName;
        textController[key3].text = data.bankCardNumber;
      }else{
        String msg = res.data;
        Toast.toast(context,msg);
      }
    });
  }

  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
    if(!isFirst){
      _getBankCardInfo();
      isFirst = true;
    }
    _formData[key2] =  textController[key2].text;


    return new Scaffold(
        appBar: new AppBar(
          title: new Text('收款银行卡'),
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
                        formWidget('持卡人姓名', '请输入持卡人的姓名', key0),
                        formWidget('持卡人身份证号', '请输入持卡人身份证号', key1),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        formWidget2('开户银行', '请选择开户银行', key2),
                        formWidget('银行卡号', '请输入银行卡号', key3),
                        new Container(
                          padding: new EdgeInsets.only(left:10,top: 10),
                          child: new Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("温馨提示:",style: new TextStyle(color: Colors.black45),),
                              new Text("填写的银行卡须是本人名下的借记卡(储蓄卡)！",style: new TextStyle(color: Colors.black45))
                            ],
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(20.0)),
                        new Container(
                          margin: EdgeInsets.all(10),
                          child: new FlexButton(
//                            visible: user.flagThree == 1?true:false,
                            textColor: Colors.white,
                            color: user.flagThree == 1?Colors.grey:Theme.of(context).primaryColor,
                            text: user.flagThree == 1?"审核通过":"提交",
                            onPress: () {
                              if(user.flagThree == 1){
                                Toast.toast(context, '审核以通过，如需修改信息请联系客服');
                              }else{
                                _formSubmitted(store);
                              }

                            },
                          ),
                        ),
                      ],
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
