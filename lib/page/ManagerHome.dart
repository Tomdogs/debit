
import 'package:debit/page/HomePage.dart';
import 'package:debit/page/MinePage.dart';
import 'package:debit/test/JiBottomBar.dart';
import 'package:debit/widgets/TabBarWidget.dart';
import 'package:flutter/material.dart';

class ManagerHome extends StatefulWidget {

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {

  final PageController topPageControl = new PageController();
  final List<String> tab = ['首页', '我的'];
  final List<IconData> listIcon = [Icons.home, Icons.person];

  final List<String> homeIcon = ['assets/images/ic_nav_tweet_normal.png','assets/images/ic_nav_tweet_actived.png'];
  final List<String> mineIcon = ['assets/images/ic_nav_my_normal.png','assets/images/ic_nav_my_pressed.png'];


  Image _getAssetIcon(String path) {
    return Image.asset(path, width: 24.0, height: 24.0);
  }
  Image _getBarIcon(int index, bool isActive) {
    if (index == 0) {
      return _getAssetIcon(
          isActive ? homeIcon[1] : homeIcon[0]);
    }else if (index == 1) {
      return _getAssetIcon(
          isActive ?  mineIcon[1]: mineIcon[0]);
    }
  }

  ///系统默认的导航栏
  _renderTab() {
    List<BottomNavigationBarItem> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(new BottomNavigationBarItem(
          icon: _getBarIcon(i,false),
          title: new Text(tab[i]),///这里如果设置颜色和大小，将会覆盖在BottomNavigationBar设置的颜色和大小
          activeIcon:_getBarIcon(i,true),
          backgroundColor: Colors.grey ///只有在type: BottomNavigationBarType.shifting 时生效
      ));
    }
    return list;
  }

  ///自定义底部导航栏
  _renderCustomTab() {
    List<JiBottomBarItem> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(new JiBottomBarItem(
        icon: _getBarIcon(i,false),
        title: new Text(tab[i]),
        activeIcon:_getBarIcon(i,true),
      ));
    }
    return list;
  }


  _renderPage() {
    return [new HomePage(), new MinePage()];//new PersonCustomerService2(),
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarWidget(
      tabItems: _renderTab(),//系统，底部导航栏
//      tabItems: _renderCustomTab(),//自定义，底部导航栏
      tabViews: _renderPage(),//中间显示的内容页面
      topPageControl: topPageControl,
      backgroundColor: Theme.of(context).primaryColor,//主题色
      title: new Text("PPMap"),
    );
  }
}
