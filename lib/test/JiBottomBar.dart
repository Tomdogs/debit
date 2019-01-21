import 'package:flutter/material.dart';

class JiBottomBar extends StatefulWidget {
  final List<JiBottomBarItem> items;
  final int currentIndex;
  final Color backgroundColor;
  final Color textFocusColor;
  final ValueChanged<int> onTap;

  JiBottomBar({
    @required this.items,
    this.currentIndex = 0,
    this.backgroundColor,
    this.textFocusColor,
    this.onTap,
  });

  @override
  _JiBottomBarState createState() {
    return new _JiBottomBarState();
  }
}

class _JiBottomBarState extends State<JiBottomBar>{
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(_createItem(i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _createItem(int i) {
    JiBottomBarItem item = widget.items[i];
    bool selected = i == widget.currentIndex;
    print("$i 是否选中：$selected");
    return Expanded(
        flex: 1,
        child: Container(
          color: widget.backgroundColor,
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: InkResponse(
            onTap: (){
              if(widget.onTap != null){
                widget.onTap(i);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                selected ? item.activeIcon : item.icon,
                /// 如果在传入title 已经设置了颜色或字体大小，这个这里就不生效了
                DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 15.0,
                      color:selected ?  widget.textFocusColor : Colors.black38,
                    ),
                    child: item.title),
              ],
            ),
          ),
        ));
  }
}

class JiBottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;

  JiBottomBarItem({@required this.icon, this.title, this.activeIcon})
      : assert(icon != null);
}
