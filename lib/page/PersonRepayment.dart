import 'package:flutter/material.dart';

class PersonRepayment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PersonRepaymentState();
  }

}

class PersonRepaymentState extends State<PersonRepayment>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的还款"),
        centerTitle: true,
      ),
      body: new Text("我的还款"),
    );
  }

}