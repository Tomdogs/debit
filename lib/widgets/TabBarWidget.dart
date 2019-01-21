import 'package:debit/common/utils/CommonUtils.dart';
import 'package:debit/test/JiBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'dart:async';

class TabBarWidget extends StatefulWidget {
  final int type;
  final List<dynamic> tabItems;
  final List<Widget> tabViews;
  final Color backgroundColor;
  final Color indicatorColor;
  final Widget title;
  final Widget drawer;
  final Widget floatingActionButton;
  final TarWidgetControl tarWidgetControl;
  final PageController topPageControl;

  TabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
  }) : super(key: key);

  _TabBarState createState() => new _TabBarState(type, tabItems, tabViews,
      backgroundColor, title, drawer, floatingActionButton, topPageControl);
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type;

  final List<dynamic> _tabItems;

  final List<Widget> _tabViews;

  final Color _backgroundColor;

  final Widget _title;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final PageController _pageController;

  _TabBarState(
      this._type,
      this._tabItems,
      this._tabViews,
      this._backgroundColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._pageController)
      : super();

  int _tabIndex = 0;

  _onPageChange(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  /**
   * new SafeArea(
      top: true,
      )
   */
  @override
  Widget build(BuildContext context) {

    ///底部TAbBar模式
    return new Container(
//      constraints: new BoxConstraints(minHeight: CommonUtils.sStaticBarHeight),
//      padding: EdgeInsets.only(top: CommonUtils.sStaticBarHeight),
      child: new Scaffold(
        ///设置侧边滑出 drawer，不需要可以不设置
        drawer: _drawer,

        ///设置悬浮按键，不需要可以不设置
        floatingActionButton: _floatingActionButton,
        backgroundColor: Colors.red,

        ///标题栏
/*
      appBar: new AppBar(
        backgroundColor: _backgroundColor,
        title: _title,
        centerTitle: true,
       ),
*/


        ///页面主体，PageView，用于承载Tab对应的页面
        body: new PageView(
          ///必须有的控制器，与tabBar的控制器同步
          controller: _pageController,

          ///每一个 tab 对应的页面主体，是一个List<Widget>
          children: _tabViews,
          onPageChanged: (index) {
            ///页面触摸作用滑动回调，用于同步tab选中状态
            print("onPageChanged当前为$index");
            _onPageChange(index);
          },
        ),

        ///系统，底部导航栏，也就是tab栏
        bottomNavigationBar: new BottomNavigationBar(
            items: _tabItems,
            fixedColor: _backgroundColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            onTap: (index) {
              print("onTap当前为$index");
              _pageController.jumpToPage(index);
            }),

        /* ///自定义，底部导航栏，也就是tab栏
      bottomNavigationBar: new JiBottomBar(
          items: _tabItems,
          currentIndex: _tabIndex,
          textFocusColor: Colors.deepOrange,
          backgroundColor: Colors.grey,
          onTap: (index) {
            print("onTap当前为$index");
            _pageController.jumpToPage(index);
          }),*/
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
