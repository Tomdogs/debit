import 'package:json_annotation/json_annotation.dart';
part 'MarqueeMessage.g.dart';
@JsonSerializable()
class MarqueeMessage{

  List<Msg> msg;
  String code;


  MarqueeMessage(this.msg, this.code);

  factory MarqueeMessage.fromJson(Map<String,dynamic> json) => _$MarqueeMessageFromJson(json);
  Map<String,dynamic> toJson() => _$MarqueeMessageToJson(this);
}


@JsonSerializable()
class Msg{

  String orderBorrowMoney;
  String orderCreateTime;
  String orderPhoneNumber;

  Msg(this.orderBorrowMoney, this.orderCreateTime, this.orderPhoneNumber);

  factory Msg.fromJson(Map<String,dynamic> json) => _$MsgFromJson(json);
  Map<String,dynamic> toJson() => _$MsgToJson(this);
}