import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/UserDao.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/redux/ReduxState.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RowLayoutWidget extends StatefulWidget {
  final Image leftIcon;
  final String topString;
  final String bottomString;
  final bool isShowRightString;
  final IconData rightIcon;
  final String routeName;
  final int code;

  RowLayoutWidget(this.leftIcon, this.topString,this.rightIcon, {this.routeName,this.bottomString, this.isShowRightString = true,this.code = 0});

  @override
  RowLayoutWidgetState createState() => new RowLayoutWidgetState();
}

class RowLayoutWidgetState extends State<RowLayoutWidget> {
  bool isClick = false;

  Future<bool> _dialogSingOut(BuildContext context,store) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('退出登录'),
          content: new Text('确定退出登录吗？'),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.of(context).pop(false), child: new Text('取消')),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  removeUserData(store);
                },
                child: new Text('确定'))
          ],
        ));
  }
  ///删除用户信息，退出登录
  removeUserData(store) async{
    await LocalStorage.remove(Config.USER_INFO);
    await LocalStorage.remove(Config.USER_PHONE_KEY);
    await LocalStorage.remove(Config.NET_ROOM_PW_KEY);
    await LocalStorage.remove(Config.PW_KEY);
    await LocalStorage.remove(Config.USER_ID_KEY);

    store.dispatch(new UpdateUserAction(new User(phoneNumber:null,userPassword:null,netRoomPassword:null,userID: null,flagOne: 0,flagTwo: 0,flagThree: 0,flagFour: 0)));


  }

  Container buildContainer(store) {
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
                          child: widget.code == 1?new Text('完整',style:new TextStyle(color: Colors.blue)):new Text('不完整',style:new TextStyle(color: Colors.red)),
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
              UserDao.getUserById(context).then((res){
                if(res != null && res.result) {
                  Data data = res.data;
                  User newUser = new User(userID: user.userID,
                      phoneNumber: user.phoneNumber,
                      userPassword: user.userPassword,
                      flagOne: data.flagOne,
                      flagTwo: data.flagTwo,
                      flagThree: data.flagThree,
                      flagFour: data.flagFour);
                  store.dispatch(new UpdateUserAction(newUser));
                }
              });


              print("store 中存储的：${user.phoneNumber}");
              if(user.phoneNumber == null && user.userPassword == null){
                Navigator.pushNamed(context, '/loginAndRegister');
              }else{
                Navigator.pushNamed(context, widget.routeName);
              }

            }else{
              User user = store.state.userInfo;
              if(user.phoneNumber == null && user.userPassword == null){
                Navigator.pushNamed(context, '/loginAndRegister');
                return;
              }
              _dialogSingOut(context,store);
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
