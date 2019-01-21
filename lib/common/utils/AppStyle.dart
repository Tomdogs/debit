import 'package:flutter/material.dart';

///颜色
class AppColors{
  static const backgroundColor = Color.fromARGB(100, 205, 201, 201);
}

///字体
class AppFont{
  static Text getText(String text,double fontSize,Color color){
    return new Text(
      text,
      style: new TextStyle(fontSize: fontSize,color: color),
    );
  }
}

///图片
class AppImage{
  static Image getAssetIcon(String path,double width,double height) {
    return Image.asset(path, width: width, height: height,fit: BoxFit.cover);
  }

  static Image getAssetIconFrom(String path) {
    return Image.asset(path, width: 25, height: 25,fit: BoxFit.cover);
  }
}

///分割线
class AppDivider{
  static Divider thinDivider(){
    final Divider divider = new Divider(
      height: 2,
    );
    return divider;
  }
}

class AppIcons{
  static const String DEFAULT_USER_ICON = 'assets/images/avatar_default_login.png';

}