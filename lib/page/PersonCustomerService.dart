import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///客服
class PersonCustomerService extends StatelessWidget{

  final String url;
  final String title;
//  final OptionControl optionControl = new OptionControl();

  PersonCustomerService(this.url, this.title);

  _renderTitle() {
    if (url == null || url.length == 0) {
      return new Text(title);
    }
//    optionControl.url = url;
    return new Row(children: [
      new Expanded(child: new Container()),
//      GSYCommonOptionWidget(optionControl),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      withZoom: true,  // 允许网页缩放
      withLocalStorage: true, // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
      url: url,
      scrollBar:true,
      withLocalUrl: true,
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
    );
  }
}

