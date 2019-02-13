import 'package:debit/common/config/Config.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoanRowLayoutWidget extends StatefulWidget {

  final String orderNumber;
  final String orderBorrowMoney;
  final String orderBorrowDeadlline;
  final String bankCardBankName;
  final String bankCardNumber;
  final String orderRefundFigure;
  final String orderBorrowStatus;
  final String orderStatus;


  LoanRowLayoutWidget({this.orderNumber, this.orderBorrowMoney,
    this.orderBorrowDeadlline, this.bankCardBankName, this.bankCardNumber,
    this.orderRefundFigure, this.orderBorrowStatus, this.orderStatus});

  @override
  LoanRowLayoutWidgetState createState() => new LoanRowLayoutWidgetState();
}

class LoanRowLayoutWidgetState extends State<LoanRowLayoutWidget> {
  bool isClick = false;

  String _getOrderBorrowStatus(orderBorrowStatus){
    String borrowStatus ='';
    switch(orderBorrowStatus){
      case '1':
        borrowStatus = '正在审核';
        break;
      case '2':
        borrowStatus = '审核通过';
        break;
      case '3':
        borrowStatus = '审核不通过';
        break;
      case '4':
        borrowStatus = '冻结';
        break;
    }

    return borrowStatus;
  }

  Container buildContainer(store) {
    return new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: isClick ? Colors.grey : Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
        ),
//        height: 50,
        child: new GestureDetector(
          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new Padding(
                      padding: EdgeInsets.all(8),
                      child:new Text('订单编号 ${widget.orderNumber}',style:new TextStyle(color: Colors.blue,fontSize: 15)),
                      ),

                  new Padding(
                    padding: EdgeInsets.all(8),
                    child:new Text('借款金额 ${widget.orderBorrowMoney}'),
                  ),
                  AppDivider.thinDivider(),


                  new Padding(
                    padding: EdgeInsets.all(8),
                    child:new Text('借款期限 ${widget.orderBorrowDeadlline}'),
                  ),

                  AppDivider.thinDivider(),


                  new Padding(
                    padding: EdgeInsets.all(8),
                    child: new Text('借款状态 ${_getOrderBorrowStatus(widget.orderBorrowStatus)}'),
                  ),

                  /*AppDivider.thinDivider(),
                  new Text('到帐银行 ${widget.bankCardBankName}'),
                  AppDivider.thinDivider(),
                  new Text('收款账号 ${widget.bankCardNumber}'),*/

                  AppDivider.thinDivider(),

                  new Padding(
                    padding: EdgeInsets.all(8),
                    child: new Text('收款状态 ${widget.orderStatus == 1 ? '以收款':'未收款'}'),
                  ),


                ],
              )),
              new Expanded(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('到期还款 ${widget.orderRefundFigure}',style:new TextStyle(color: Colors.red,fontSize: 15),),
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
            /*if(widget.routeName != null){

              User user = store.state.userInfo;
              print("store 中存储的：${user.phoneNumber}");
              if(user.phoneNumber == null && user.userPassword == null){
                Navigator.pushNamed(context, '/loginAndRegister');
              }else{
                Navigator.pushNamed(context, widget.routeName);
              }

            }*/
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
