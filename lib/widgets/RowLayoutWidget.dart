import 'package:flutter/material.dart';

class RowLayoutWidget extends StatefulWidget {
  final Image leftIcon;
  final String topString;
  final String bottomString;
  final bool isShowRightString;
  final IconData rightIcon;
  final String routeName;

  RowLayoutWidget(this.leftIcon, this.topString,this.rightIcon, this.routeName,{this.bottomString, this.isShowRightString = true});

  @override
  RowLayoutWidgetState createState() => new RowLayoutWidgetState();
}

class RowLayoutWidgetState extends State<RowLayoutWidget> {
  bool isClick = false;

  Container buildContainer() {
    return new Container(
//        margin: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: isClick ? Colors.grey : null,
        ),
        height: 50,
        child: new GestureDetector(
          child: new Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                  child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: widget.leftIcon,
                  ),
                  new Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          widget.topString,
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        new Offstage(
                          offstage: widget.bottomString == null,
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 5)),
                              new Text(
                                widget.bottomString == null ?'':widget.bottomString,
                                style: new TextStyle(
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    )
                  ),
                ],
              )),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: new Row(
                      children: <Widget>[
                        new Offstage(
                          offstage: widget.isShowRightString,
                          child: new Text('不完整',style:new TextStyle(color: Colors.blue)),
                        ),
                        new Icon(widget.rightIcon, size: 25),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          /*onTapDown: (TapDownDetails details) {
            print("按下");
            setState(() {
              isClick = true;
            });
          },*/
          onPanDown: (DragDownDetails details) {
            print("onPanDown");
            setState(() {
              isClick = true;
            });
          },
          onTapCancel: () {
            print("onTapCancel");
            setState(() {
              isClick = false;
            });
          },
          onTapUp: (TapUpDetails details) {
            print("松开");
            setState(() {
              isClick = false;
            });
          },
          onTap: () {
            print("点击了吗？");
            Navigator.pushNamed(context, widget.routeName);
//            Navigator.of(context).pushNamed(routeName);
          },

          ///默认情况下透明区域不响应事件，加上这个属性就可以响应透明区域的事件
          behavior: HitTestBehavior.translucent,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildContainer();
  }
}
