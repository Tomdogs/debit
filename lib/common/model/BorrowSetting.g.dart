// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BorrowSetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowSetting _$BorrowSettingFromJson(Map<String, dynamic> json) {
  return BorrowSetting(
      json['dataLoadSet'] == null
          ? null
          : DataLoadSet.fromJson(json['dataLoadSet'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['code'] as String);
}

Map<String, dynamic> _$BorrowSettingToJson(BorrowSetting instance) =>
    <String, dynamic>{
      'dataLoadSet': instance.dataLoadSet,
      'data': instance.data,
      'code': instance.code
    };

DataLoadSet _$DataLoadSetFromJson(Map<String, dynamic> json) {
  return DataLoadSet(
      json['id'] as String,
      json['loadAutoRefuseDays'] as String,
      json['loadCheckExpenses'] as String,
      json['loadEveryRmonthReturn'] as String,
      json['loadFirstHint'] as String,
      json['loadFirstSelectDays'] as String,
      json['loadIsAutoRefuse'] as String,
      json['loadMax'] as String,
      json['loadMin'] as String,
      json['loadRefuseWaitDays'] as String,
      json['loadSelectDays'] as String,
      json['loadServicesExpenses'] as String,
      json['status'] as String);
}

Map<String, dynamic> _$DataLoadSetToJson(DataLoadSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loadAutoRefuseDays': instance.loadAutoRefuseDays,
      'loadCheckExpenses': instance.loadCheckExpenses,
      'loadEveryRmonthReturn': instance.loadEveryRmonthReturn,
      'loadFirstHint': instance.loadFirstHint,
      'loadFirstSelectDays': instance.loadFirstSelectDays,
      'loadIsAutoRefuse': instance.loadIsAutoRefuse,
      'loadMax': instance.loadMax,
      'loadMin': instance.loadMin,
      'loadRefuseWaitDays': instance.loadRefuseWaitDays,
      'loadSelectDays': instance.loadSelectDays,
      'loadServicesExpenses': instance.loadServicesExpenses,
      'status': instance.status
    };
