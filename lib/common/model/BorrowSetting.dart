import 'package:debit/common/model/UserData.dart';
import 'package:json_annotation/json_annotation.dart';
part 'BorrowSetting.g.dart';

/**
 * {
    "dataLoadSet": {
    "id": "f498c146f7b24467bb0a529a9f3e9b39",
    "loadAutoRefuseDays": "3",
    "loadCheckExpenses": "0",
    "loadEveryRmonthReturn": "15",
    "loadFirstHint": "10000",
    "loadFirstSelectDays": "3",
    "loadIsAutoRefuse": "1",
    "loadMax": "500000",
    "loadMin": "10000",
    "loadRefuseWaitDays": "30",
    "loadSelectDays": "3,6,9,12,24,36",
    "loadServicesExpenses": "0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07",
    "status": "1"
    },
    "data": {
    "bankCardBankName": "中国银行",
    "bankCardIdcard": "",
    "bankCardNumber": "233453453453453",
    "bankCardUsername": "",
    "flagFour": 0,
    "flagOne": 0,
    "flagThree": 0,
    "flagTwo": 0,
    "id": "",
    "idCardTakeImg": "",
    "immediateName": "",
    "immediatePhoneNumber": "",
    "immediateRelation": "",
    "otherName": "",
    "otherPhoneNumber": "",
    "otherRelation": "",
    "unitAddress": "",
    "unitDetailAdress": "",
    "unitDetailLifeAddress": "",
    "unitLifeAddress": "",
    "unitMonthlyIncome": "",
    "unitName": "",
    "unitPhoneNumber": "",
    "unitPosition": "",
    "unitWorkAges": "",
    "userEmergencyFreeze": 0,
    "userExamineStatus": 0,
    "userIdCardBackImg": "",
    "userIdCardFrontImg": "",
    "userIdcardNumber": "",
    "userLoginFlag": 0,
    "userName": "问额1",
    "userNetroomPassword": "",
    "userNetroomPhonenum": "1301111000066",
    "userPassWord": "",
    "userRegisterTime": null,
    "userUserName": ""
    },
    "code": "0"
    }
 */

@JsonSerializable()
class BorrowSetting{
  DataLoadSet dataLoadSet;
  Data data;
  String code;

  BorrowSetting(this.dataLoadSet, this.data, this.code);

  factory BorrowSetting.fromJson(Map<String,dynamic> json) => _$BorrowSettingFromJson(json);
  Map<String,dynamic> toJson() => _$BorrowSettingToJson(this);


}

@JsonSerializable()
class DataLoadSet{
  String id;
  String loadAutoRefuseDays;
  String loadCheckExpenses;
  String loadEveryRmonthReturn;
  String loadFirstHint;
  String loadFirstSelectDays;
  String loadIsAutoRefuse;
  String loadMax;
  String loadMin;
  String loadRefuseWaitDays;
  String loadSelectDays;
  String loadServicesExpenses;
  String status;

  DataLoadSet(this.id, this.loadAutoRefuseDays, this.loadCheckExpenses,
      this.loadEveryRmonthReturn, this.loadFirstHint, this.loadFirstSelectDays,
      this.loadIsAutoRefuse, this.loadMax, this.loadMin,
      this.loadRefuseWaitDays, this.loadSelectDays, this.loadServicesExpenses,
      this.status);



  factory DataLoadSet.fromJson(Map<String,dynamic> json) => _$DataLoadSetFromJson(json);
  Map<String,dynamic> toJson() => _$DataLoadSetToJson(this);
}