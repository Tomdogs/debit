import 'dart:convert';

import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:debit/widgets/city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonReferenceInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonReferenceInfoState();
  }
}

class PersonReferenceInfoState extends State<PersonReferenceInfo> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static final String key0 = 'unitName';
  static final String key1 = 'unitPosition';
  static final String key2 = 'unitPhoneNumber';
  static final String key3 = 'unitWorkAges';
  static final String key4 = 'unitAddress';
  static final String key5 = 'unitDetailAdress';
  static final String key6 = 'unitMonthlyIncome';
  static final String key7 = 'unitLifeAddress';
  static final String key8 = 'unitDetailLifeAddress';
  static final String key9 = 'immediateName';
  static final String key10 = 'immediatePhoneNumber';
  static final String key11 = 'immediateRelation';
  static final String key12 = 'otherName';
  static final String key13 = 'otherPhoneNumber';
  static final String key14 = 'otherRelation';
  static final String keyID = 'id';

  Map<String,TextEditingController> textController ={
    key0:new TextEditingController(),
    key1:new TextEditingController(),
    key2:new TextEditingController(),
    key3:new TextEditingController(),
    key4:new TextEditingController(),
    key5:new TextEditingController(),
    key6:new TextEditingController(),
    key7:new TextEditingController(),
    key8:new TextEditingController(),
    key9:new TextEditingController(),
    key10:new TextEditingController(),
    key11:new TextEditingController(),
    key12:new TextEditingController(),
    key13:new TextEditingController(),
    key14:new TextEditingController(),
  };
  Map<String,dynamic> _formData = {
    key0:null,
    key1:null,
    key2:null,
    key3:null,
    key4:null,
    key5:null,
    key6:null,
    key7:null,
    key8:null,
    key9:null,
    key10:null,
    key11:null,
    key12:null,
    key13:null,
    key14:null,
    keyID:null,

  };

  final _relationShip =<String>["父母","兄妹","朋友","同事"];


  ///表单
  Widget formWidget(String title,String desc,String key){
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
            flex: 3,
            child: new Padding(
              padding: EdgeInsets.all(5),
              child: new Text(title,style: TextStyle(fontSize: 16,color: Colors.blue),),
            ),
          ),
          new Expanded(
              flex: 7,
              child: new Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: new TextFormField(
//                  textAlign: TextAlign.end,
//                  initialValue: "",
                  enabled: true,
                  enableInteractiveSelection: true,
                  controller: textController[key],
//                  initialValue: _formData[key],
                  decoration: new InputDecoration(
                    hintText: desc,
                  ),
                  validator: (String value) {

                    //删除首尾空格
                    if (value == null || value.isEmpty || value.trim().length == 0) {
                      print('$title 验证不能通过：$value');
                      return '此处不能为空!';
                    }
                  },
                  onSaved: (String value){///当调用FormState.save方法的时候调用
                    _formData[key] = value;
                  },
                ),
              )
          )
        ],
      ),
    );

  }

  String province;
  String city;
  String area;
  FocusNode _focusNode = new FocusNode();
  ///带城市选择功能的表单
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
            flex: 3,
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
                    CityPicker.showCityPicker(
                      context,
                      selectProvince: (province) {
                        this.province = '${province['name']}';
                        if(Config.DEBUG){
                          print('选择的省：${province['name']}');
                        }
                      },
                      selectCity: (city) {
                        this.city = '${city['name']}';
                        if(Config.DEBUG){
                          print('选择的市：${city['name']}');
                        }
                      },
                      selectArea: (area) {
                        this.area = '${area['name']}';
                        if(Config.DEBUG){
                          print('选择的区：${area['name']}');
                        }
                        String address = '$province $city ${this.area}';
                        textController[key].value = new TextEditingValue(text:address);
                        _formData[key] = address;
                      },
                    );
                    print('$province+$city+$area');
                  },
                  ///如果设置 onTap 下面两个 将不执行
                  onSubmitted: (String value){
                    print("onSubmitted 选择省市区---------------：${value.length}");
                    _formData[key] = value;
                  },
                  onChanged: (String value){
                    print("onChanged 选择省市区---------------：${value.length}");
                    _formData[key] = value;
                  },
                ),
              )
          )
        ],
      ),
    );

  }

  ///带底部弹出选择框功能的表单
  Widget formWidget3(String title,String desc,String key){

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
            flex: 3,
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
  Widget buildPicker(String key){
    return new CupertinoPicker(
      children: <Widget>[
        new Text(_relationShip[0]),
        new Text(_relationShip[1]),
        new Text(_relationShip[2]),
        new Text(_relationShip[3]),
      ],
      onSelectedItemChanged:(int i){
        textController[key].value = new TextEditingValue(text:_relationShip[i]);
        _formData[key] = _relationShip[i];
      },
      itemExtent: 50,
    );
  }



  void _formSubmitted(store) {
    var _form = _formKey.currentState;
    print("form状态：${_form.validate()}");
    bool validateFromSelect;
    ///检验 城市区域 和 人际关系 是否进行了设置
    /*if(_formData[key4] == null || _formData[key7] == null || _formData[key11] == null || _formData[key14] == null){
      validateFromSelect = false;
    }else{
      validateFromSelect = true;
    }*/
    for(int i=0;i<15;i++){
      if(textController[key0].text != null){
        validateFromSelect = true;
      }else{
        validateFromSelect = false;
      }
    }

    if (_form.validate() && validateFromSelect) {
      _form.save();

      print('-----------------------------验证完成后的属性值------------------------------：');
      print("单位名称：${_formData[key0]}");

      _formData.forEach((key,value){
        print(key+":"+value.toString());
      });
      User user = store.state.userInfo;
      _formData[keyID] = user.userID;

      CommonUtils.showLoadingDialog(context,text:'正在上传...');
      ///更新用户资料信息
      UserDao.updateUserDataInfo(_formData,context).then((res){
        String msg= res.data;
        if(res.result){
          Toast.toast(context, "信息上传成功！");
          new Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/personInfo');
            return true;
          });

          User user = store.state.userInfo;
          User newUser = new User(userID:user.userID,phoneNumber:user.phoneNumber,userPassword:user.userPassword,
              flagOne: user.flagOne,flagTwo: 1,flagThree: user.flagThree,flagFour: user.flagFour);
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


  ///查询用户信息,如果以前有信息就按以前的填写
  void _getUserInfo(context){
    UserDao. getUserDataInfo(context).then((res) {
      if (res.result) {
        Data data = res.data;
///_formData[key4] == null || _formData[key7] == null || _formData[key11] == null || _formData[key14] == null
        textController[key0].text = data.unitName;
        textController[key1].text = data.unitPosition;
        textController[key2].text = data.unitPhoneNumber;
        textController[key3].text = data.unitWorkAges;
        textController[key4].text = data.unitAddress;
        textController[key5].text = data.unitDetailAdress;
        textController[key6].text = data.unitMonthlyIncome;
        textController[key7].text = data.unitLifeAddress;
        textController[key8].text = data.unitDetailLifeAddress;
        textController[key9].text = data.immediateName;
        textController[key10].text = data.immediatePhoneNumber;
        textController[key11].text = data.immediateRelation;
        textController[key12].text = data.otherName;
        textController[key13].text = data.otherPhoneNumber;
        textController[key14].text = data.otherRelation;

       /* _formData[key4] =  data.unitAddress;
        _formData[key7] = data.unitLifeAddress;
        _formData[key11] = data.immediateRelation;
        _formData[key14] = data.otherRelation;*/
        }else{
        String msg = res.data;
        print("用户数据为3：${res.data}");
        Toast.toast(context,msg);
      }
      });
  }

  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
    if(!isFirst){
      _getUserInfo(context);
      isFirst = true;
    }
    _formData[key4] =  textController[key4].text;
    _formData[key7] = textController[key7].text;
    _formData[key11] = textController[key11].text;
    _formData[key14] = textController[key14].text;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('单位信息'),
          centerTitle: true,
        ),
        body: new StoreBuilder<ReduxState>(
          builder: (context,store){
            return new ListView(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(color: AppColors.backgroundColor),
                  child: new Form(
                      key: _formKey,
                      child: new Column(
                        children: <Widget>[
                          /*new Padding(
                        padding: EdgeInsets.only(top:10),
                      ),*/
                          new Container(
                            padding: new EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: new Column(
                              children: <Widget>[
                                new Text("填写真实有效的信息，审核才会通过哦~")
                              ],
                            ),
                          ),
                          formWidget('单位名称','请输入单位名称',key0),
                          formWidget('公司职位','请输入公司职位',key1),
                          formWidget('单位电话','号码加区号',key2),
                          formWidget('工作年龄(年)','请输入工作年龄',key3),
                          formWidget2('单位地址','请选择省市区',key4),
                          formWidget('详细地址','例：东北大学东三寝室楼6A888',key5),
                          formWidget('月收入(元)','请输入现在工作月收入',key6),
                          formWidget2('现居住地址','请选择省市区',key7),
                          formWidget('详细地址','例：东北大学东三寝室楼6A888',key8),
                          new Container(
                            padding: new EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: new Column(
                              children: <Widget>[
                                new Text("直系亲属联系人")
                              ],
                            ),
                          ),
                          formWidget('姓名','请输入联系人姓名',key9),
                          formWidget('手机号','请输入手机号',key10),
                          formWidget3('关系','请选择关系',key11),
                          new Container(
                            padding: new EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: new Column(
                              children: <Widget>[

                                new Text("其他联系人")
                              ],
                            ),
                          ),
                          formWidget('姓名','请输入联系人姓名',key12),
                          formWidget('手机号','请输入手机号',key13),
                          formWidget3('关系','请选择关系',key14),
                          new Padding(padding: EdgeInsets.all(20.0)),
                          new Container(
                            margin: EdgeInsets.all(10),
                            child: new FlexButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              text: "提交",
                              onPress: () {
                                _formSubmitted(store);
                              },
                            ),
                          ),
                        ],
                      )
                  ),
                )
              ],
            );
          },
        )
    );
  }
}
