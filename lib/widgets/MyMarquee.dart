import 'dart:async';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/MarqueeMessage.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:flutter/material.dart';
class MyMarquee extends  StatefulWidget{

  Widget child;  // 轮播的内容
  Duration duration;  // 轮播时间
  double stepOffset;  // 偏移量
  double paddingLeft;  // 内容左右之间的间距
  double paddingTop; // 内容上下之间的间距

  MyMarquee({this.child, this.paddingLeft, this.duration, this.stepOffset,this.paddingTop});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyMarqueeState();
  }

}



class MyMarqueeState extends State<MyMarquee>{
  ScrollController _controller;  // 执行动画的controller
  Timer _timer;  // 定时器timer
  double widgetHeight;//控件的高
  double _offset = 20;  // 执行动画的偏移量


  @override
  void initState() {
    super.initState();

    getMarqueeDatas();

    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration, (timer) {

      double newOffset = _controller.offset + widget.stepOffset;

      if (newOffset != _offset) {
        print('_controller：${newOffset}');
        _offset = newOffset;
        _controller.animateTo(
            _offset,
            duration: widget.duration, curve: Curves.linear);  // 线性曲线动画

      }else{
        _controller.jumpTo(0);
      }

    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  getBody() {
    if (listMsg == null || listMsg.length ==0) {
      return new Center(
        child: new Text("暂无数据"),
      );

    } else {
      return getListView();
    }
  }
  ListView getListView(){
    
    return ListView.builder(
      scrollDirection: Axis.vertical,  // 横向滚动
      controller: _controller,  // 滚动的controller
      itemCount: listMsg.length,
      itemBuilder: (context, index) {
        print("myMarquee builder:${listMsg.length}");
        return new Container(
            margin: new EdgeInsets.only(bottom: widgetHeight),
            alignment: Alignment.center,
            child: new Center(
              child: new Row(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text('${listMsg[index].orderCreateTime}:'),
                  new Text('${listMsg[index].orderPhoneNumber}',style: TextStyle(color: Colors.red),),
                  new Text(' 成功借款 '),
                  new Text('${listMsg[index].orderBorrowMoney}',style: TextStyle(color: Colors.red),),
                  new Text('元'),
                ],
              )
            )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  getBody();
  }

  List<Msg> listMsg;
  
  getMarqueeDatas()async{
    UserDao.getSevenDaysDatas(context).then((res){
      var msg;
      if( res != null && res.result){
        msg = res.data;

        setState(() {
          listMsg = msg;
          widgetHeight = context.size.height;
          print("myMarquee 跑马灯的数据：$listMsg");
        });

      }else{
        var msg = res.data;
        Toast.toast(context, msg);
      }

    });
  }

}