import 'package:json_annotation/json_annotation.dart';
part 'UserData.g.dart';

/***
 * {
    "data": {
    "bankCardBankName": "中国银行",
    "bankCardIdcard": "23432s",
    "bankCardNumber": "233453453453453",
    "bankCardUsername": "张",
    "flagFour": 0,
    "flagOne": 0,
    "flagThree": 0,
    "flagTwo": 0,
    "id": "606d3a37fafb46a3a7658168877fb0ab",
    "idCardTakeImg": "/imgupload/606d3a37fafb46a3a7658168877fb0ab/idCardTakeImg/微信图片_20190202083959.jpg",
    "immediateName": "李嘉诚",
    "immediatePhoneNumber": "13020202020",
    "immediateRelation": "兄妹",
    "otherName": "柳传志",
    "otherPhoneNumber": "13520202020",
    "otherRelation": "兄妹",
    "unitAddress": "安徽省/合肥市/瑶海区",
    "unitDetailAdress": "还定",
    "unitDetailLifeAddress": "海定",
    "unitLifeAddress": "安徽省/芜湖市/繁昌县",
    "unitMonthlyIncome": "150000",
    "unitName": "ces",
    "unitPhoneNumber": "12355366",
    "unitPosition": "p9",
    "unitWorkAges": "4",
    "userEmergencyFreeze": 0,
    "userExamineStatus": 1,
    "userIdCardBackImg": "/imgupload/606d3a37fafb46a3a7658168877fb0ab/idCardBackImg/微信图片_20190202084007.jpg",
    "userIdCardFrontImg": "/imgupload/606d3a37fafb46a3a7658168877fb0ab/idCardFrontImg/微信图片_20190202083959.jpg",
    "userIdcardNumber": "",
    "userLoginFlag": 0,
    "userName": "问额",
    "userNetroomPassword": "1232",
    "userNetroomPhonenum": "13011110000",
    "userPassWord": "1",
    "userRegisterTime": {
    "date": 27,
    "day": 0,
    "hours": 21,
    "minutes": 56,
    "month": 0,
    "seconds": 15,
    "time": 1548597375000,
    "timezoneOffset": -480,
    "year": 119
    },
    "userUserName": "打算"
    },
    "code": "0",
    "msg": "添加成功！"
    }
 */
@JsonSerializable()
class UserData{
  String code;
  String msg;
  Data data;

  UserData(this.code, this.msg, this.data);

  factory UserData.fromJson(Map<String,dynamic> json) => _$UserDataFromJson(json);
  Map<String,dynamic> toJson() => _$UserDataToJson(this);

}

@JsonSerializable()
class Data{

  String bankCardBankName;
  String bankCardIdcard;
  String bankCardNumber;
  String bankCardUsername;
  String flagOne;
  String flagTwo;
  String flagThree;
  String flagFour;
  String id;
  String idCardTakeImg;
  String immediateName;
  String immediatePhoneNumber;
  String immediateRelation;
  String otherName;
  String otherPhoneNumber;
  String otherRelation;
  String unitAddress;
  String unitDetailAdress;
  String unitDetailLifeAddress;
  String unitLifeAddress;
  String unitMonthlyIncome;
  String unitName;
  String unitPhoneNumber;
  String unitPosition;
  String unitWorkAges;
  String userEmergencyFreeze;
  String userExamineStatus;
  String userIdCardBackImg;
  String userIdCardFrontImg;
  String userIdcardNumber;
  String userLoginFlag;
  String userName;
  String userNetroomPassword;
  String userNetroomPhonenum;
  String userPassWord;
  String userUserName;
  UserRegisterTime userRegisterTime;

  Data(this.bankCardBankName, this.bankCardIdcard, this.bankCardNumber,
      this.bankCardUsername, this.flagOne, this.flagTwo, this.flagThree,
      this.flagFour, this.id, this.idCardTakeImg, this.immediateName,
      this.immediatePhoneNumber, this.immediateRelation, this.otherName,
      this.otherPhoneNumber, this.otherRelation, this.unitAddress,
      this.unitDetailAdress, this.unitDetailLifeAddress, this.unitLifeAddress,
      this.unitMonthlyIncome, this.unitName, this.unitPhoneNumber,
      this.unitPosition, this.unitWorkAges, this.userEmergencyFreeze,
      this.userExamineStatus, this.userIdCardBackImg, this.userIdCardFrontImg,
      this.userIdcardNumber, this.userLoginFlag, this.userName,
      this.userNetroomPassword, this.userNetroomPhonenum, this.userPassWord,
      this.userUserName, this.userRegisterTime);


  factory Data.fromJson(Map<String,dynamic> json) => _$DataFromJson(json);
  Map<String,dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class UserRegisterTime{
  int date;
  int day;
  int hours;
  int minutes;
  int month;
  int seconds;
  int time;
  int timezoneOffset;
  int year;

  UserRegisterTime(this.date, this.day, this.hours, this.minutes, this.month,
      this.seconds, this.time, this.timezoneOffset, this.year);

  factory UserRegisterTime.fromJson(Map<String,dynamic> json) => _$UserRegisterTimeFromJson(json);
  Map<String,dynamic> toJson() => _$UserRegisterTimeToJson(this);
}