
import 'package:debit/common/model/UserData.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserBorrowRepay.g.dart';

/***
 * {
    "data": [{
    "id": "9bc2107daec942338557a6ab09b43a87",
    "orderBorrowDeadlline": "2019-08-30",
    "orderBorrowMoney": "10000",
    "orderBorrowStatus": "1",
    "orderBorrowUse": "123321",
    "orderCreateTime": {
    "date": 30,
    "day": 3,
    "hours": 23,
    "minutes": 41,
    "month": 0,
    "seconds": 6,
    "time": 1548862866000,
    "timezoneOffset": -480,
    "year": 119
    },
    "orderNumber": "I1548862866902",
    "orderPhoneNumber": "13011110000",
    "orderRefundFigure": "10630元",
    "orderRefundStatus": "0",
    "orderRefundTime": "",
    "orderStatus": "2",
    "orderType": "1",
    "orderUsername": "问额",
    "usermanageid": "606d3a37fafb46a3a7658168877fb0ab"
    }],
    "baseInfo": {
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
    "userName": "问额2",
    "userNetroomPassword": "",
    "userNetroomPhonenum": "13011110000",
    "userPassWord": "",
    "userRegisterTime": null,
    "userUserName": ""
    },
    "code": "0"
    }
 */
@JsonSerializable()
class UserBorrowRepay{
  String code;
  Data baseInfo;
  @JsonKey(name: "data")
  List<UserBorrowRepayData> borrowRepayList;

  UserBorrowRepay(this.code, this.baseInfo, this.borrowRepayList);


  factory UserBorrowRepay.fromJson(Map<String,dynamic> json) => _$UserBorrowRepayFromJson(json);
  Map<String,dynamic> toJson() => _$UserBorrowRepayToJson(this);

}


@JsonSerializable()
class UserBorrowRepayData{
  String id;
  String orderBorrowDeadlline;
  String orderBorrowMoney;
  String orderBorrowStatus;
  String orderBorrowUse;
  String orderNumber;
  String orderPhoneNumber;
  String orderRefundFigure;
  String orderRefundStatus;
  String orderRefundTime;
  String orderStatus;
  String orderType;
  String orderUsername;
  String usermanageid;
  UserRegisterTime orderCreateTime;

  UserBorrowRepayData(this.id, this.orderBorrowDeadlline, this.orderBorrowMoney,
      this.orderBorrowStatus, this.orderBorrowUse, this.orderNumber,
      this.orderPhoneNumber, this.orderRefundFigure, this.orderRefundStatus,
      this.orderRefundTime, this.orderStatus, this.orderType,
      this.orderUsername, this.usermanageid, this.orderCreateTime);

  factory UserBorrowRepayData.fromJson(Map<String,dynamic> json) => _$UserBorrowRepayDataFromJson(json);
  Map<String,dynamic> toJson() => _$UserBorrowRepayDataToJson(this);

}