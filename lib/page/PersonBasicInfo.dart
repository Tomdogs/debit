import 'dart:io';

import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/net/Address.dart';
import 'package:debit/net/HttpUtil.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonBasicInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new PersonBasicInfoState();
  }
}

class PersonBasicInfoState extends State<PersonBasicInfo>{

  final String idCardPositive = 'assets/images/my_basic_IDCard_positive.png';
  final String idCardOpposite = 'assets/images/my_basic_IDCard_opposite.png';
  final String camera = 'assets/images/my_basic_camera.png';
  static File _image1;
  static File _image2;
  static File _image3;
  bool image_1_flag = false;
  bool image_2_flag = false;
  bool image_3_flag = false;
  int i;
  String userName;
  String userIdcardNumber;

  static final String key0 = 'userName';
  static final String key1 = 'userIdcardNumber';
  static final String key2 = 'userIdCardFrontImg';
  static final String key3 = 'userIdCardBackImg';
  static final String key4 = 'idCardTakeImg';
  static final String keyFile = 'files';

  static String cardFrontImgURL;
  static String cardBackImgURL;
  static String cardTackImgURL;

  /*Map<String,dynamic> _formData = {
    key0: null,
    key1: null,
    key2: null,
    key3: null,
    key4: null,
  };*/
  Map<String,TextEditingController> textController = {
    key0: new TextEditingController(),
    key1: new TextEditingController(),
    key2: new TextEditingController(),
    key3: new TextEditingController(),
    key4: new TextEditingController(),
  };

  FormData formData = new FormData.from({});

  pickImage(int i) {
    this.i = i;
    showModalBottomSheet<void>(context: context, builder: _bottomSheetBuilder);
  }


    Widget _bottomSheetBuilder(BuildContext context) {

    return new Container(
        height: 182.0,
        child: new Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Column(
            children: <Widget>[
              _renderBottomMenuItem(i,"相机", ImageSource.camera),
              new Divider(height: 2.0,),
              _renderBottomMenuItem(i,"图库", ImageSource.gallery)
            ],
          ),
        )
    );
  }

  _renderBottomMenuItem(int i,title, ImageSource source) {
    var item = new Container(
      height: 60.0,
      child: new Center(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              title == '相机' ? new Icon(Icons.camera) : new Icon(Icons.photo),
              new Padding(padding: EdgeInsets.only(left: 20)),
              new Text(title)
            ],
          )
      ),
    );
    return new InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).pop();
        ///如果 i 为空，i=1；否则 i 值不变
        getImage(i??=1,source);
      },
    );
  }
  Future getImage(int i,ImageSource source) async {
    ///ImageSource.camera 相机
    ///ImageSource.gallery 图库
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      switch (i){
        case 1:
          _image1 = image;
          image_1_flag = true;
          print("getImage 1 的图片为${_image1}");
          break;
        case 2:
          _image2 = image;
          image_2_flag = true;
          print("getImage 2 的图片为${_image2}");
          break;
        case 3:
          _image3 = image;
          image_3_flag = true;
          print("getImage 3 的图片为${_image3}");
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async{

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print("路径为：${appDocPath}");


    UserDao.getUserById(context).then((res){
      if(res != null && res.result) {
        Data data = res.data;

        print("用户名1：${data.userName}");
        print("用户名2：${data.userIdcardNumber}");
        print("用户名3：${data.userIdCardFrontImg}");
        print("用户名4：${data.userIdCardBackImg}");
        print("用户名5：${data.idCardTakeImg}");
        print("用户名5：${data.userName == ''}");

        textController[key0].text = data.userName;
        textController[key1].text = data.userIdcardNumber;

        userName = data.userName;
        userIdcardNumber = data.userIdcardNumber;

        if(data.userIdCardFrontImg != '' && data.userIdCardBackImg != '' && data.idCardTakeImg!=''){
          setState(() {
            isFirst1 = true;
            isFirst2 = true;
            isFirst3 = true;

            cardFrontImgURL = Address.host+data.userIdCardFrontImg;
            cardBackImgURL = Address.host+data.userIdCardBackImg;
            cardTackImgURL = Address.host+data.idCardTakeImg;
          });
        }

      }
    });
  }

  bool isFirst1 = true;
  bool isFirst2 = true;
  bool isFirst3 = true;

  Widget getNetWorkImage1(String url,File file,bool isFirst){

    if(url != null && isFirst){
      isFirst1 = false;
//      return new Image.network(url);
      return new CachedNetworkImage(
        placeholder: new CircularProgressIndicator(),
        imageUrl:url,
      );
    }else{
      if(file == null){
        return new Image(image: new AssetImage(idCardOpposite));
      }else{
        return Image.file(file);
      }
    }

  }
  Widget getNetWorkImage2(String url,File file,bool isFirst){

    if(url != null && isFirst){
      isFirst2 = false;
//      return new Image.network(url);
      return new CachedNetworkImage(
        placeholder: new CircularProgressIndicator(),
        imageUrl:url,
      );
    }else{
      if(file == null){
        return new Image(image: new AssetImage(idCardPositive));
      }else{
        return Image.file(file);
      }
    }

  }

  Widget getNetWorkImage3(String url,File file,bool isFirst){

    print("getNetWorkImage1-: $isFirst");
    print("getNetWorkImage1-URL: $url");
    if(url != null && isFirst){
      isFirst3 = false;
//      return new Image.network(url);
      return new CachedNetworkImage(
          placeholder: new CircularProgressIndicator(),
          imageUrl:url,
      );

    }else{
      if(file == null){
        print("getNetWorkImage3: $isFirst");
        return new Image(image: new AssetImage(idCardPositive));
      }else{
        print("getNetWorkImage4: $isFirst");
        return Image.file(file);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('基本信息'),
        centerTitle: true,
      ),
      body: new StoreBuilder<ReduxState>(
        builder: (context,store){

          User user = store.state.userInfo;

          return new Container(
            decoration: new BoxDecoration(color: AppColors.backgroundColor),
            child: new ListView(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
//                  new Padding(padding: new EdgeInsets.all(10.0)),
                      new Text("填写真实有效的信息，审核才会通过哦~")
                    ],
                  ),
                ),
//            new Padding(padding: new EdgeInsets.all(10.0)),
                new Container(
                  margin: EdgeInsets.only(left:10.0,right: 10,top: 10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  ),
                  child:new Column(

                    children: <Widget>[
                      new TextField(
                        controller: textController[key0],
                        decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(10),
//                      icon: Icon(Icons.face),
                          border: OutlineInputBorder(),
                          labelText: '姓名',
                          helperText: '请输入你的真实姓名',
                        ),
                        onChanged: (String value){
                          print("onChanged 填写的姓名---------------：${value}");
//                          _formData[key0] = value;
                          userName = value;
                        },
                        autofocus: false,
                      ),

                    ],
                  ) ,
                ),
                new Container(
                  margin: EdgeInsets.only(left:10.0,right: 10,top: 10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  ),

                  child: new Column(
                    children: <Widget>[
                      new TextField(
                        controller: textController[key1],
                        keyboardType: TextInputType.number ,
                        decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(10),
//                      icon: Icon(Icons.credit_card),
                          border: OutlineInputBorder(),
                          labelText: '身份证号',
                          helperText: '请输入你的真实身份证号',
                        ),
                        onChanged: (String value){
                          print("onChanged 填写的身份证号---------------：${value}");
//                          _formData[key1] = value;
                          userIdcardNumber = value;
                        },
                        autofocus: false,
                      ),
                    ],
                  ),
                ),
                new Container(
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Text("*须本人身份证，且内容清晰可辨"),
                      new Text("*请您确认拍照权限已开启"),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left:10.0,right: 10,top: 10),
                  decoration: new BoxDecoration(
                    border: new Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  ),
                  child: new Stack(

                    alignment: const FractionalOffset(0.5, 0.5),
                    children: <Widget>[
//                      _image1 == null ? new Image(image: new AssetImage(idCardPositive),) : Image.file(_image1),
                      getNetWorkImage1(cardFrontImgURL,_image1,isFirst1),
                      new GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            AppImage.getAssetIcon(camera,60,60),
                            new Padding(padding: EdgeInsets.only(top: 10)),
                            new Text('身份证正面扫描上传',style: new TextStyle(decorationColor: Colors.grey),),

                          ],
                        ),
                        onTap: (){
                          pickImage(1);
                          print("点击了--身份证正面扫描上传");
                        },
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left:10.0,right: 10,top: 10),
                  decoration: new BoxDecoration(
                    border: new Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  ),
                  child: new Stack(
                    alignment: const FractionalOffset(0.5, 0.5),
                    children: <Widget>[
//                      _image2 == null ? new Image(image: new AssetImage(idCardOpposite),) : Image.file(_image2),
                      getNetWorkImage2(cardBackImgURL,_image2,isFirst2),
                      new GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            AppImage.getAssetIcon(camera,60,60),
                            new Padding(padding: EdgeInsets.only(top: 10)),
                            new Text('身份证反面扫描上传',style: new TextStyle(decorationColor: Colors.grey),),
                          ],
                        ),
                        onTap: (){
                          pickImage(2);
                        },
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left:10.0,right: 10,top: 10),
                  decoration: new BoxDecoration(
                    border: new Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  ),
                  child: new Stack(
                    alignment: const FractionalOffset(0.5, 0.5),
                    children: <Widget>[
//                      _image3 == null ? new Image(image: new AssetImage(idCardPositive),) : Image.file(_image3),
//                      _image3 == null ? new Image.network('https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master/static/images/logo.png'):Image.file(_image3) ,
//                      new Image.network('https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master/static/images/logo.png'),
                      getNetWorkImage3(cardTackImgURL,_image3,isFirst3),
                      new GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            AppImage.getAssetIcon(camera,60,60),
                            new Padding(padding: EdgeInsets.only(top: 10)),
                            new Text('手持身份证扫描上传',style: new TextStyle(decorationColor: Colors.grey),),
                          ],
                        ),
                        onTap: (){
                          pickImage(3);
                          print("点击了--手持身份证扫描上传");
                        },
                      ),

                    ],
                  ),
                ),

                new Padding(padding: EdgeInsets.all(20.0)),
                new Container(
                  margin: EdgeInsets.all(10),
                  child: new FlexButton(
//                    visible: user.flagOne == 1?true:false,
                    textColor: Colors.white,
                    color: user.flagThree == 1?Colors.grey:Theme.of(context).primaryColor,
                    text: user.flagThree == 1?"审核通过":"提交",
                    onPress: () {

                      if(user.flagThree == 1){
                        Toast.toast(context, '审核以通过，如需修改信息请联系客服');
                      }else{
                        if(userName ==null || userIdcardNumber == null){
                          Toast.toast(context, "请将信息填写完整！");
                          return;
                        }
                        if(image_1_flag && image_2_flag && image_3_flag){

                          formData.add('id', user.userID);
                          formData.add(key0, userName);
                          formData.add(key1, userIdcardNumber);
                          formData.add(keyFile, [
                            new UploadFileInfo(_image1, "$key1.jpg"),
                            new UploadFileInfo(_image2, "$key2.jpg"),
                            new UploadFileInfo(_image3, "$key3.jpg"),
                          ]);

                          print("personBasicInfor 中user id ：${user.userID}");
                          print("personBasicInfor 中userName ：${userIdcardNumber}");
                          print("personBasicInfor 中user 身份证号 ：${userIdcardNumber}");
                          print("personBasicInfor 中user image1 ：${_image1}");
                          print("personBasicInfor 中user image2 ：${_image2}");
                          print("personBasicInfor 中user image3 ：${_image3}");

                          CommonUtils.showLoadingDialog(context,text:'正在上传...');
                          UserDao.getSubmitUserIdentity(formData,context).then((res){
                            if(res != null && res.result){
                              Toast.toast(context, "信息上传成功！");

                              new Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);//销毁加载的页面
//                              Navigator.pushReplacementNamed(context, '/personInfo');
                                Navigator.pop(context);//销毁当前页
                              });
                              User newUser = new User(userID:user.userID,phoneNumber:user.phoneNumber,userPassword:user.userPassword,
                                  flagOne: 1,flagTwo: user.flagTwo,flagThree: user.flagThree,flagFour: user.flagFour);
                              store.dispatch(new UpdateUserAction(newUser));

                            }else{
                              Navigator.pop(context);
                              Toast.toast(context, "信息上传失败！");
                            }
                          });


                        }else{
                          Toast.toast(context, "请完善图片！");
                        }
                      }

                    },
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