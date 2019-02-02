import 'package:debit/common/utils/AppStyle.dart';
import 'package:debit/widgets/LoanRowLayoutWidget.dart';
import 'package:flutter/material.dart';

class PersonDebit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PersonDebitState();
  }

}
/**
 * new LoanRowLayoutWidget('10000','30','200000'),
    new LoanRowLayoutWidget('10100','60','300000'),
    new LoanRowLayoutWidget('10200','120','400000'),
    new LoanRowLayoutWidget('10300','2400','500000'),
 */
class PersonDebitState extends State<PersonDebit>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的借贷"),
        centerTitle: true,
      ),
      body: new Container(
        decoration: BoxDecoration(color: AppColors.backgroundColor),
         child:new ListView.builder(
           itemCount: 50,
           itemBuilder: (context,index){
            return new LoanRowLayoutWidget('10000','30','200000');
           },
        ),
      )
    );
  }

}