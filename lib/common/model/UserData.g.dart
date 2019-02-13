// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
      json['code'] as String,
      json['msg'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['bankCardBankName'] as String,
      json['bankCardIdcard'] as String,
      json['bankCardNumber'] as String,
      json['bankCardUsername'] as String,
      json['flagOne'] as int,
      json['flagTwo'] as int,
      json['flagThree'] as int,
      json['flagFour'] as int,
      json['id'] as String,
      json['idCardTakeImg'] as String,
      json['immediateName'] as String,
      json['immediatePhoneNumber'] as String,
      json['immediateRelation'] as String,
      json['otherName'] as String,
      json['otherPhoneNumber'] as String,
      json['otherRelation'] as String,
      json['unitAddress'] as String,
      json['unitDetailAdress'] as String,
      json['unitDetailLifeAddress'] as String,
      json['unitLifeAddress'] as String,
      json['unitMonthlyIncome'] as String,
      json['unitName'] as String,
      json['unitPhoneNumber'] as String,
      json['unitPosition'] as String,
      json['unitWorkAges'] as String,
      json['userEmergencyFreeze'] as int,
      json['userExamineStatus'] as int,
      json['userIdCardBackImg'] as String,
      json['userIdCardFrontImg'] as String,
      json['userIdcardNumber'] as String,
      json['userLoginFlag'] as int,
      json['userName'] as String,
      json['userNetroomPassword'] as String,
      json['userNetroomPhonenum'] as String,
      json['userPassWord'] as String,
      json['userUserName'] as String,
      json['userRegisterTime'] == null
          ? null
          : UserRegisterTime.fromJson(
              json['userRegisterTime'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'bankCardBankName': instance.bankCardBankName,
      'bankCardIdcard': instance.bankCardIdcard,
      'bankCardNumber': instance.bankCardNumber,
      'bankCardUsername': instance.bankCardUsername,
      'flagOne': instance.flagOne,
      'flagTwo': instance.flagTwo,
      'flagThree': instance.flagThree,
      'flagFour': instance.flagFour,
      'id': instance.id,
      'idCardTakeImg': instance.idCardTakeImg,
      'immediateName': instance.immediateName,
      'immediatePhoneNumber': instance.immediatePhoneNumber,
      'immediateRelation': instance.immediateRelation,
      'otherName': instance.otherName,
      'otherPhoneNumber': instance.otherPhoneNumber,
      'otherRelation': instance.otherRelation,
      'unitAddress': instance.unitAddress,
      'unitDetailAdress': instance.unitDetailAdress,
      'unitDetailLifeAddress': instance.unitDetailLifeAddress,
      'unitLifeAddress': instance.unitLifeAddress,
      'unitMonthlyIncome': instance.unitMonthlyIncome,
      'unitName': instance.unitName,
      'unitPhoneNumber': instance.unitPhoneNumber,
      'unitPosition': instance.unitPosition,
      'unitWorkAges': instance.unitWorkAges,
      'userEmergencyFreeze': instance.userEmergencyFreeze,
      'userExamineStatus': instance.userExamineStatus,
      'userIdCardBackImg': instance.userIdCardBackImg,
      'userIdCardFrontImg': instance.userIdCardFrontImg,
      'userIdcardNumber': instance.userIdcardNumber,
      'userLoginFlag': instance.userLoginFlag,
      'userName': instance.userName,
      'userNetroomPassword': instance.userNetroomPassword,
      'userNetroomPhonenum': instance.userNetroomPhonenum,
      'userPassWord': instance.userPassWord,
      'userUserName': instance.userUserName,
      'userRegisterTime': instance.userRegisterTime
    };

UserRegisterTime _$UserRegisterTimeFromJson(Map<String, dynamic> json) {
  return UserRegisterTime(
      json['date'] as int,
      json['day'] as int,
      json['hours'] as int,
      json['minutes'] as int,
      json['month'] as int,
      json['seconds'] as int,
      json['time'] as int,
      json['timezoneOffset'] as int,
      json['year'] as int);
}

Map<String, dynamic> _$UserRegisterTimeToJson(UserRegisterTime instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day': instance.day,
      'hours': instance.hours,
      'minutes': instance.minutes,
      'month': instance.month,
      'seconds': instance.seconds,
      'time': instance.time,
      'timezoneOffset': instance.timezoneOffset,
      'year': instance.year
    };
