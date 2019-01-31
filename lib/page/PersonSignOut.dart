import 'package:flutter/material.dart';

class PersonSignOut extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PersonSignOutState();
  }
  
}

class PersonSignOutState extends State<PersonSignOut>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("退出登录"),
        centerTitle: true,
      ),
      body: new Text("退出登录"),
    );
  }
  
}