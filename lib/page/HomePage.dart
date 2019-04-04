import 'package:debit/widgets/MyMarquee.dart';
import 'package:flutter/material.dart';
import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/DaoResult.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/BorrowSetting.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:debit/widgets/seekbar/seekbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_redux/flutter_redux.dart';

///主页面
class HomePage extends StatefulWidget {
  static final String sName = "home";
  @override
  _MainHomePage createState() => _MainHomePage();
}

class _MainHomePage extends State<HomePage> with SingleTickerProviderStateMixin {

  final GlobalKey<_MainHomePage> _globalkey = new GlobalKey<_MainHomePage>();

  var rateArray = [];
  var daysArray = [];
  var colorArray = [redColor];
  @override
  void initState() {
    super.initState();

    UserDao.getTradingBorrowingQueryBase(context).then((res){
      DataLoadSet dataLoadSet = res.data;

      rateArray = dataLoadSet.loadServicesExpenses.split(',');
      daysArray = dataLoadSet.loadSelectDays.split(',');

      colorArray.length = daysArray.length;

      print("当前利率长度:${rateArray.length}");
      print("当前利率:${rateArray.toString()}");
      print("当前天数长度:${daysArray.length}");
      print("当前天数:${daysArray.toString()}");

      setState(() {
        loadMin = double.parse(dataLoadSet.loadMin);
        loadMax = double.parse(dataLoadSet.loadMax);
        rate = double.parse(rateArray[0])*0.01;
        days = double.parse(daysArray[0])*30;

        print("贷款设置加载最小金额： ${loadMin}");
        print("贷款设置加载最大金额： ${loadMax}");

      });
    });

    interest = money*rate*days;
    countMoney = money + interest;


  }

  double money = 10000.0;
  int _radioValue = 0;
  double days = 90;
  double rate = 0.0007;
  double interest = 0;
  double countMoney = 0;
  static Color redColor = Colors.red;
  double loadMin = 10000.0;
  double loadMax = 200000.0;

  List<String> listMsg;

  final TapGestureRecognizer platform_recognizer = new TapGestureRecognizer();
  final TapGestureRecognizer entrust_recognizer = new TapGestureRecognizer();
  bool isCheck = true;

  void _handlerRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      for(int i=0;i<daysArray.length;i++){
        if(i == value && rateArray[i] != null){
          rate = double.parse(rateArray[i])*0.01;
          colorArray[i] = redColor;
          days = double.parse(daysArray[i])*30;
          interest = money*rate*days;
          countMoney = money+interest;
        }else{
          colorArray[i] = null;
        }
      }
    });
  }

  Widget _getListHorizontalRadio(int i,String month) {
    return new Row(
      children: <Widget>[
        new Radio(
            value: i,
            groupValue: _radioValue,
            onChanged: _handlerRadioValueChange,
        ),
        new Text(month,style: new TextStyle(color: colorArray[i]),)
      ],
    );

  }


  Map<String,dynamic> _formData;

  verificationInfo(user) async{
    await UserDao.getUserById(context).then((res){
      if(res != null && res.result){
        Data data = res.data;
        if(data.flagOne == 1 && data.flagTwo == 1 && data.flagThree == 1 && data.flagFour == 1){

          _formData = {
            "usermanageid":user.userID,
            "orderBorrowMoney":money.floor(),
            "orderBorrowUse":"APP借款",
            "orderRefundFigure": countMoney.floor(),
            "orderType":1//订单类型 1 借款订单 2 还款订单
          };
          return new DataResult(null, true);
        }else{
          Toast.toast(context, "请将资料填写完整！");
          Navigator.pushNamed(context, '/personInfo');
          return new DataResult(null, false);
        }
      }else{
        Toast.toast(context, "请求失败！");
        return new DataResult(null, false);
      }
    });
  }
  borrowNow(formData)async{
    await UserDao.getTradingBorrowingNow(formData,context).then((res){
      if(res != null && res.result){

        Toast.toast(context, res.data);
        new Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, '/personDebit');
        });
      }else{
        Toast.toast(context, res.data);
      }

    });
  }

  /*getMarqueeDatas(store)async{
    UserDao.getSevenDaysDatas(context).then((res){
      var msg;
      if( res != null && res.result){
        msg = res.data;

        listMsg = msg;
        print("跑马灯的数据：$listMsg");
        List<MarqueeMsg> list = new List();
        for(int i=0;i<listMsg.length;i++){
          list.add(new MarqueeMsg(listMsg[i]));
        }
        store.dispatch(new RefreshMarqueeAction(list));
        print("跑马灯的数据：更新了數據");
      }else{
        var msg = res.data;
        Toast.toast(context, msg);
      }

    });
  }*/

  @override
  Widget build(BuildContext context) {

    platform_recognizer.onTap = (){
      showDialog(
          context: context,
        builder: (context) => new AlertDialog(
          content: new  ListView(
            children: <Widget>[
              new Text(Config.PLATFORM_AGREEMENT),
            ],
          )
        )
      );
    };

    entrust_recognizer.onTap = (){
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
              content: new  ListView(
                children: <Widget>[
                  new Text(Config.ENTRUST_AGREEMENT),
                ],
              )
          )
      );
    };

    return new StoreBuilder<ReduxState>(
      builder: (context,store){

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
//                      padding: EdgeInsets.only(top: CommonUtils.sStaticBarHeight),
                      child: new Column(
                        ///上方和下方均匀分配空闲的垂直空间
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: EdgeInsets.only(top: 10),
                            child: new Text(
                              "申请金额(元)",
                              style:
                              new TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),

                          new Text('${money ?? 10000}',
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 40)),
//                            new Padding(padding: EdgeInsets.only(top: 10)),
                          new SeekBar(
                            min: loadMin,
                            max: loadMax,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.red,
                            progresseight: 20,
                            value: 1000, //默认进度值

                            indicatorRadius: 15, //中间指示器圆圈的半径,初始位置有点奇怪
                            indicatorColor: Colors.orange, //中间指示器圆圈的颜色

                            sectionCount: 190, //进度条分为几段

                            hideBubble: false,
                            bubbleRadius: 14,
                            bubbleColor: Colors.orange,
                            bubbleTextColor: Colors.white,
                            bubbleTextSize: 14,
                            bubbleMargin: 4,
                            afterDragShowSectionText: true,

                            onValueChanged: (v) {
                              setState(() {
                                money = v.value;
                                interest = money*rate*days;
                                countMoney = money+interest;
                                print('当前的真实值：${v.value}');
                              });
                            },
                          ),
                        ],
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
                            child: new ListView.builder(
                              itemCount: daysArray.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return _getListHorizontalRadio(index,"${daysArray[index]}个月");
                              },
                            )
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
                                        child: new Text('${countMoney.floor()}元',style: new TextStyle(fontSize: 15),),
                                      )
                                    ),
                                    new Expanded(
                                        flex:2,
                                        child:  new Container(
//                                            alignment: Alignment.centerRight,//保留几位小数
                                            child: new Text('(含日利率${(rate*100).toStringAsFixed(2)}% ￥${interest.floor()}元)',style: new TextStyle(fontSize: 10),)
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
                                            recognizer:platform_recognizer,
                                          ),
                                          new TextSpan(
                                            text: '《委托授权协议》',
                                            style: new TextStyle(color: Colors.red),
                                            recognizer:entrust_recognizer,
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
                                      if(!isCheck){
                                        Toast.toast(context, "请勾选同意协议！");
                                        return;
                                      }

                                      User user = store.state.userInfo;
                                      if(user.phoneNumber == null && user.userPassword == null){
                                        Navigator.pushNamed(context, '/login');
                                      }else{

                                        UserDao.getUserById(context).then((res){
                                          if(res != null && res.result){
                                            Data data = res.data;
                                            User newUser = new User(userID:user.userID,phoneNumber:user.phoneNumber,userPassword:user.userPassword,
                                                flagOne: data.flagOne,flagTwo: data.flagTwo,flagThree: data.flagThree,flagFour: data.flagFour);
                                            store.dispatch(new UpdateUserAction(newUser));
                                            if(data.flagOne == 1 && data.flagTwo == 1 && data.flagThree == 1 && data.flagFour == 1){

                                              _formData = {
                                                "usermanageid":user.userID,
                                                "orderBorrowMoney":money.floor(),
                                                "orderBorrowUse":"APP借款",
                                                "orderRefundFigure": countMoney.floor(),
                                                "orderType":1//订单类型 1 借款订单 2 还款订单
                                              };

                                              borrowNow(_formData);
                                            }else{
                                              Toast.toast(context, "请将资料填写完整！");
                                              Navigator.pushNamed(context, '/personInfo');
                                            }
                                          }
                                        });

                                      }
                                    }
                                ),
                              )
                          ),
                          /*new Expanded(
                              flex: 2,
                              child: new Container(
                                decoration:new BoxDecoration(
                                  color: AppColors.backgroundColor ,
                                ),
                                child: FlutterMarquee(
                                    texts: ["暂无数据！","暂无数据！2",].toList(),
                                    textColor: Colors.blue,
                                    onChange: (i) {
                                      print("$i");
                                    },
                                    duration: 4,
                                    autoStart: true,
                                ),
                              )
                          ),*/
                          new Expanded(
                              flex: 2,
                              child: new Container(
                                decoration:new BoxDecoration(
                                  color: AppColors.backgroundColor ,
                                ),
                                child: new MyMarquee(
//                                    child:new Text("2019-02-23:185****4444 成功借款35000元"),
//                                    paddingLeft:200.0,
                                    duration:new Duration(seconds: 3),
                                    stepOffset:100.0
                                )
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
