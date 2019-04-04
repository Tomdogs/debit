import 'dart:async';

import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/UserBorrowRepay.dart';
import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/LoanRowLayoutWidget.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PersonRepayment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PersonRepaymentState();
  }

}

List<UserBorrowRepayData> listData;
int dataLength;


class PersonRepaymentState extends State<PersonRepayment>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTradingBorrowInfo();
  }

  bool havaData = true;
  void _getTradingBorrowInfo() async{

    UserDao.getTradingReturn(context).then((res){
      if(res.result){
        setState(() {
          listData= res.data;
          dataLength = listData.length;
        });

      }else{
        Toast.toast(context,"网络有误");
      }
    });
  }

  showLoadingDialog() {
    if (listData == null || listData.length == 0) {
      havaData = false;
      return true;
    }
    return false;
  }


  getBody() {
    if (showLoadingDialog()) {
      if(!havaData){
        return new Center(child:new Text("暂无还款数据"));
      }
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getProgressDialog() {

    return new Center(child:new CircularProgressIndicator());
  }
  ListView getListView() => new ListView.builder(
    itemCount: dataLength,
    itemBuilder: (context,index){
      print("我的还款 订单号1：${listData[index].orderStatus}");
      print("我的还款 订单号2：${listData[index].orderBorrowDeadlline}");
      print("我的还款 订单号3：${listData[index].orderRefundFigure}");
      return new LoanRowLayoutWidget(
        orderNumber:listData[index].orderNumber,
        orderBorrowMoney:listData[index].orderBorrowMoney,
        orderBorrowDeadlline:listData[index].orderBorrowDeadlline,
        orderBorrowStatus:listData[index].orderBorrowStatus,
        orderRefundFigure:listData[index].orderRefundFigure,
        orderStatus:listData[index].orderStatus,
      );
    },
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的还款"),
        centerTitle: true,
      ),
      body: new Container(
        decoration: BoxDecoration(color: AppColors.backgroundColor),
        child: getBody()
      )
    );
  }

}