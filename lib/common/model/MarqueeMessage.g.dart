// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MarqueeMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarqueeMessage _$MarqueeMessageFromJson(Map<String, dynamic> json) {
  return MarqueeMessage(
      (json['msg'] as List)
          ?.map(
              (e) => e == null ? null : Msg.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'] as String);
}

Map<String, dynamic> _$MarqueeMessageToJson(MarqueeMessage instance) =>
    <String, dynamic>{'msg': instance.msg, 'code': instance.code};

Msg _$MsgFromJson(Map<String, dynamic> json) {
  return Msg(json['orderBorrowMoney'] as String,
      json['orderCreateTime'] as String, json['orderPhoneNumber'] as String);
}

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'orderBorrowMoney': instance.orderBorrowMoney,
      'orderCreateTime': instance.orderCreateTime,
      'orderPhoneNumber': instance.orderPhoneNumber
    };
