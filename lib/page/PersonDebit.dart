import 'package:flutter/material.dart';

class PersonDebit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PersonDebitState();
  }

}

class PersonDebitState extends State<PersonDebit>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的借贷"),
        centerTitle: true,
      ),
      body: new Text("我的借贷"),
    );
  }

}