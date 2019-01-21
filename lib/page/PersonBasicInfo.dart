import 'dart:io';

import 'package:debit/common/config/Config.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  File _image1;
  File _image2;
  File _image3;
  int i;



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
          break;
        case 2:
          _image2 = image;
          break;
        case 3:
          _image3 = image;
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('基本信息'),
        centerTitle: true,
      ),
      body: new Container(
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
                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(10),
//                      icon: Icon(Icons.face),
                      border: OutlineInputBorder(),
                      labelText: '姓名',
                      helperText: '请输入你的真实姓名',
                    ),
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
                    keyboardType: TextInputType.number ,
                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(10),
//                      icon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                      labelText: '身份证号',
                      helperText: '请输入你的真实身份证号',
                    ),
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

                    _image1 == null ? new Image(image: new AssetImage(idCardPositive),) : Image.file(_image1),

                    new GestureDetector(
                      child: new Column(
                        children: <Widget>[
                          AppImage.getAssetIcon(camera,60,60),
                          new Padding(padding: EdgeInsets.only(top: 10)),
                          new Text('身份证正面扫描上传',style: new TextStyle(decorationColor: Colors.grey),),

                        ],
                      ),
                      onTap: (){
//                        getImage(1);
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
                  _image2 == null ? new Image(image: new AssetImage(idCardOpposite),) : Image.file(_image2),
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
                  _image3 == null ? new Image(image: new AssetImage(idCardPositive),) : Image.file(_image3),
                  new GestureDetector(
                    child: new Column(
                      children: <Widget>[
                        AppImage.getAssetIcon(camera,60,60),
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Text('手持身份证扫描上传',style: new TextStyle(decorationColor: Colors.grey),),
                      ],
                    ),
                    onTap: (){
//                      getImage(3);
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
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                text: "提交",
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

}