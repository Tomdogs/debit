// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserBorrowRepay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBorrowRepay _$UserBorrowRepayFromJson(Map<String, dynamic> json) {
  return UserBorrowRepay(
      json['code'] as String,
      json['baseInfo'] == null
          ? null
          : Data.fromJson(json['baseInfo'] as Map<String, dynamic>),
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : UserBorrowRepayData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$UserBorrowRepayToJson(UserBorrowRepay instance) =>
    <String, dynamic>{
      'code': instance.code,
      'baseInfo': instance.baseInfo,
      'data': instance.borrowRepayList
    };

UserBorrowRepayData _$UserBorrowRepayDataFromJson(Map<String, dynamic> json) {
  return UserBorrowRepayData(
      json['id'] as String,
      json['orderBorrowDeadlline'] as String,
      json['orderBorrowMoney'] as String,
      json['orderBorrowStatus'] as String,
      json['orderBorrowUse'] as String,
      json['orderNumber'] as String,
      json['orderPhoneNumber'] as String,
      json['orderRefundFigure'] as String,
      json['orderRefundStatus'] as String,
      json['orderRefundTime'] as String,
      json['orderStatus'] as String,
      json['orderType'] as String,
      json['orderUsername'] as String,
      json['usermanageid'] as String,
      json['orderCreateTime'] == null
          ? null
          : UserRegisterTime.fromJson(
              json['orderCreateTime'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserBorrowRepayDataToJson(
        UserBorrowRepayData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderBorrowDeadlline': instance.orderBorrowDeadlline,
      'orderBorrowMoney': instance.orderBorrowMoney,
      'orderBorrowStatus': instance.orderBorrowStatus,
      'orderBorrowUse': instance.orderBorrowUse,
      'orderNumber': instance.orderNumber,
      'orderPhoneNumber': instance.orderPhoneNumber,
      'orderRefundFigure': instance.orderRefundFigure,
      'orderRefundStatus': instance.orderRefundStatus,
      'orderRefundTime': instance.orderRefundTime,
      'orderStatus': instance.orderStatus,
      'orderType': instance.orderType,
      'orderUsername': instance.orderUsername,
      'usermanageid': instance.usermanageid,
      'orderCreateTime': instance.orderCreateTime
    };
