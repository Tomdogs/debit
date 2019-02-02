import 'package:debit/net/HttpErrorEvent.dart';
import 'package:event_bus/event_bus.dart';
///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = new EventBus();

  ///成功
  static const String STATUS_SUCCESS = '0';
  ///失败
  static const String STATUS_FAIL = '1';
  ///系统异常
  static const String STATUS_ERROR = '2';
  ///数据为空
  static const String STATUS_EMPTY = '3';

  static errorHandleFunction(code, message, noTip) {
    if(noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
