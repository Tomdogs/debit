import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/widgets/FlexButton.dart';
import 'package:debit/widgets/ImagePickerWidget.dart';
import 'package:debit/widgets/city_picker.dart';
import 'package:debit/widgets/marquee/index.dart';
import 'package:debit/widgets/seekbar/progress_value.dart';
import 'package:debit/widgets/seekbar/section_text_model.dart';
import 'package:debit/widgets/seekbar/seekbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///主页面
class HomePage extends StatefulWidget {
  static final String sName = "home";
  @override
  _MainHomePage createState() => _MainHomePage();
}

class _MainHomePage extends State<HomePage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  double money = 10000;
  int _radioValue = 0;
  double days = 3;
  double rate = 0.0005;
  double interest = 0;
  double countMoney = 0;
  static Color redColor = Colors.red;


  Map<int,Color> _color ={
    0:redColor,
    1:null,
    2:null,
    3:null,
    4:null,
    5:null,
  };
  final TapGestureRecognizer recognizer = new TapGestureRecognizer();
  bool isCheck = true;

  void _handlerRadioValueChange(int value) {

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _color[0] = redColor;
          _color[1]=_color[2]=_color[3]=_color[4]=_color[5]= null;
          days = 3;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;
        case 1:
          _color[1] = redColor;
          _color[0]=_color[2]=_color[3]=_color[4]=_color[5]= null;
          days = 6;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;
        case 2:
          _color[2] = redColor;
          _color[1]=_color[0]=_color[3]=_color[4]=_color[5]= null;
          days = 9;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;
        case 3:
          _color[3] = redColor;
          _color[1]=_color[2]=_color[0]=_color[4]=_color[5]= null;
          days = 12;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;
        case 4:
          _color[4] = redColor;
          _color[1]=_color[2]=_color[3]=_color[0]=_color[5]= null;
          days = 24;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;
        case 5:
          _color[5] = redColor;
          _color[1]=_color[2]=_color[3]=_color[4]=_color[0]= null;
          days = 36;
          interest = money*rate*days*30;
          countMoney = money+interest;
          print("选择的是$_radioValue");
          break;

      }
    });
  }

  Widget _getListHorizontalRadio(int i,String month) {
    return new Row(
      children: <Widget>[
        new Radio(
            value: i,
            groupValue: _radioValue,
            onChanged: _handlerRadioValueChange
        ),
        new Text(month,style: new TextStyle(color: _color[i]),)

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    recognizer.onTap = (){
      print("点击了用户协议书");
    };
    interest = money*rate*days*30;
    countMoney = money + interest;

    return new StoreConnector<ReduxState,User>(
      converter: (store) => store.state.userInfo,
      builder: (context,user){
        return new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(color: AppColors.backgroundColor),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    flex: 2,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
//                  height: 200.0,
                      padding: EdgeInsets.only(top: CommonUtils.sStaticBarHeight),
                      child: new Center(
                        child: new Column(
                          ///上方和下方均匀分配空闲的垂直空间
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              "申请金额(元)",
                              style:
                              new TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            new Text('${money ?? 10000}',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 40)),
                            new Padding(padding: EdgeInsets.only(top: 10)),
                            new SeekBar(
                              min: 10000,
                              max: 150000,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.red,
                              progresseight: 20,
                              value: 10000, //默认进度值

                              indicatorRadius: 15, //中间指示器圆圈的半径,初始位置有点奇怪
                              indicatorColor: Colors.orange, //中间指示器圆圈的颜色

                              sectionCount: 14, //进度条分为几段

                              hideBubble: false,
                              bubbleRadius: 14,
                              bubbleColor: Colors.purple,
                              bubbleTextColor: Colors.white,
                              bubbleTextSize: 14,
                              bubbleMargin: 4,
                              afterDragShowSectionText: true,

                              onValueChanged: (v) {
                                setState(() {
                                  money = v.value;
                                  interest = money*rate*days*30;
                                  countMoney = money+interest;
                                  print('当前的真实值：${v.value}');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                      flex:3,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        ///上方和下方均匀分配空闲的垂直空间
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: <Widget>[
                          new Expanded(
                            flex: 1,
                            child: new Container(
                              alignment:Alignment.centerLeft,
                              /*decoration:new BoxDecoration(
                                color: Colors.black45
                              ),*/
                              child: new Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: new Text('借款期限',style: new TextStyle(fontSize: 15),),
                              ),
                            ),
                          ),

                          new Expanded(
                            flex: 2,
                            child: new ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                _getListHorizontalRadio(0,"3个月"),
                                _getListHorizontalRadio(1,"6个月"),
                                _getListHorizontalRadio(2,"9个月"),
                                _getListHorizontalRadio(3,"12个月"),
                                _getListHorizontalRadio(4,"24个月"),
                                _getListHorizontalRadio(5,"36个月"),
                              ],
                            ),
                          ),

                          new Expanded(
                            flex: 2,
                            child: new Container(
                              alignment:Alignment.centerLeft,
                              decoration:new BoxDecoration(
                                color: AppColors.backgroundColor ,
                              ),
                              child: new Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      flex:1,
                                      child: new Container(
//                                        alignment: Alignment.centerLeft,
                                        child: new Text('到期还款',style: new TextStyle(fontSize: 15),),
                                      ),
                                    ),
                                    new Expanded(
                                      flex:1,
                                      child:  new Container(
                                        alignment: Alignment.centerRight,
                                        child: new Text('${countMoney.toString()}元',style: new TextStyle(fontSize: 15),),
                                      )
                                    ),
                                    new Expanded(
                                        flex:2,
                                        child:  new Container(
//                                            alignment: Alignment.centerRight,
                                            child: new Text('(含日利率$rate% ￥$interest元)',style: new TextStyle(fontSize: 10),)
                                        )
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 1,
                            child: new Row(
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
                                        style: new TextStyle(color: Colors.blue,fontSize: 12),
                                        children: <TextSpan>[
                                          new TextSpan(
                                            text: '《平台服务协议》',
                                            style: new TextStyle(color: Colors.red),
                                            recognizer:recognizer,
                                          ),
                                          new TextSpan(
                                            text: '《委托授权协议》',
                                            style: new TextStyle(color: Colors.red),
                                            recognizer:recognizer,
                                          )
                                        ]
                                    )
                                ),

                              ],
                            ),
                          ),
                          new Expanded(
                              flex: 2,
                              child: new Container(
                                padding: EdgeInsets.all(10),
                                child: new RaisedButton(
                                    textColor: Colors.white,
                                    color: Theme.of(context).primaryColor,
                                    child: new Flex(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      direction: Axis.horizontal,
                                      children: <Widget>[new Text('立即借款', style: new TextStyle(fontSize: 20), maxLines: 1, overflow:TextOverflow.ellipsis)],
                                    ),
                                    onPressed: () {
                                      if(user.phoneNumber == null && user.userPassword == null){
                                        Navigator.pushNamed(context, '/loginAndRegister');
                                      }
                                    }
                                ),
                              )
                          ),
                          new Expanded(
                              flex: 2,
                              child: new Container(
                                decoration:new BoxDecoration(
                                  color: AppColors.backgroundColor ,
                                ),
                                child: FlutterMarquee(
                                    texts: ["2019-01-19:185****2365 成功借款 50000元！",
                                    "2019-01-19:185****7060 成功借款 10000元！",
                                    "2019-01-19:185****5968 成功借款 30000元！",
                                    "2019-01-19:185****2547 成功借款 150000元！"].toList(),
                                    onChange: (i) {
                                      print(i);
                                    },
                                    duration: 4
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                  new Expanded(
                      flex: 1,
                      child: new Container(
                        padding: EdgeInsets.only(right: 2,left: 2,bottom: 2),
                        child: new ConstrainedBox(
                          constraints: new BoxConstraints.expand(),
                          child: new Image.asset('assets/images/other.png',fit: BoxFit.cover,),
                        ),
                      )
                  ),
                ],
              )),
        );
      },
    );
  }
}
