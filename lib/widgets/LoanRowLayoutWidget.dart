import 'package:debit/common/config/Config.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoanRowLayoutWidget extends StatefulWidget {

  final String moneyAmount;
  final String period;
  final String repayState;
  final String routeName;


  LoanRowLayoutWidget(this.moneyAmount, this.period, this.repayState,{this.routeName});

  @override
  LoanRowLayoutWidgetState createState() => new LoanRowLayoutWidgetState();
}

class LoanRowLayoutWidgetState extends State<LoanRowLayoutWidget> {
  bool isClick = false;

  Container buildContainer(store) {
    return new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: isClick ? Colors.grey : Colors.blueGrey,
        ),
        height: 50,
        child: new GestureDetector(
          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  new Text('订单编号${widget.moneyAmount}'),
                  AppDivider.thinDivider(),
                  new Text('借款状态${widget.moneyAmount}'),


                ],
              )),
              new Expanded(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('还款金额${widget.moneyAmount}',style:new TextStyle(color: Colors.white,fontSize: 15),),
                    ],
                  )
              ),

            ],
          ),
          onPanDown: (DragDownDetails details) {
            setState(() {
              isClick = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isClick = false;
            });
          },
          onTapUp: (TapUpDetails details) {
            setState(() {
              isClick = false;
            });
          },
          onTap: () {
            if(widget.routeName != null){

              User user = store.state.userInfo;
              print("store 中存储的：${user.phoneNumber}");
              if(user.phoneNumber == null && user.userPassword == null){
                Navigator.pushNamed(context, '/loginAndRegister');
              }else{
                Navigator.pushNamed(context, widget.routeName);
              }

            }
          },

          ///默认情况下透明区域不响应事件，加上这个属性就可以响应透明区域的事件
          behavior: HitTestBehavior.translucent,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<ReduxState>(
        builder: (context, store) {
          return buildContainer(store);
    });
  }
}
