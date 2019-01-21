import 'package:debit/page/HomePage.dart';
import 'package:debit/page/MinePage.dart';
import 'package:flutter/material.dart';

class JiContainerPage extends StatefulWidget {
  @override
  _JiContainerPageState createState() {
    return new _JiContainerPageState();
  }
}

class _JiContainerPageState extends State<JiContainerPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = new PageController(initialPage: 0);
  int _tabIndex = 0;

  _onPageChange(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  Image _getBarIcon(int index, bool isActive) {
    if (index == 0) {
      return _getAssetIcon(
          isActive ? "assets/images/hearts.png" : "assets/images/heart.png");
    } else if (index == 1) {
      return _getAssetIcon(
          isActive ?  'assets/images/googleg_standard.png': 'assets/images/googleg_disabled.png');
    }
  }

  Image _getAssetIcon(String path) {
    return Image.asset(path, width: 24.0, height: 24.0);
  }

  Text _getBarText(int index) {
    if (index == 0) {
      return Text("首页",style: TextStyle(color: Colors.black87));
    } else {
      return Text("我的",style: TextStyle(color: Colors.black87));
    }
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 当BottomNavigationBar的type: BottomNavigationBarType.fixed，
     * 背景色由ThemeData.canvasColor决定
     */
    return new MaterialApp(
      theme: ThemeData(
          canvasColor: Color(0xffEEEFF2)
      ),
      home: new Scaffold(
          body: PageView.builder(
            onPageChanged: _onPageChange,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return new HomePage();
              } else if (index == 1) {
                return new MinePage();
              }
            },
            itemCount: 2,
          ),
          bottomNavigationBar: new BottomNavigationBar(
            fixedColor: Colors.black87,
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: _getBarIcon(0, false),
                title: _getBarText(0),
                activeIcon: _getBarIcon(0, true),
              ),
              new BottomNavigationBarItem(
                icon: _getBarIcon(1, false),
                title: _getBarText(1),
                activeIcon: _getBarIcon(1, true),
              )
            ],
            currentIndex: _tabIndex,
            onTap: (index) {
              _pageController.jumpToPage(index);
//            _pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.ease);
              _onPageChange(index);
            },
          )),
    );
  }
}
