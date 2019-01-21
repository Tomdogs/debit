import 'dart:convert';

import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/DaoResult.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/net/Address.dart';
import 'package:debit/net/Api.dart';
import 'package:dio/dio.dart';

class UserDao {
  static login(userName, password)  {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }
    LocalStorage.save(Config.USER_NAME_KEY, userName);
    LocalStorage.save(Config.USER_BASIC_CODE, base64Str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": "luo 用户ID",
      "client_secret":  "luo 用户ID"
    };
//    HttpManager.clearAuthorization();

//    var res = await HttpManager.netFetch(Address.getAuthorization(), json.encode(requestParams), null, new Options(method: "post"));
//    var resultData = null;

    /*if (res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
      var resultData = await getUserInfo(null);
      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
      store.dispatch(new UpdateUserAction(resultData.data));
    }*/

//    return new DataResult(resultData, res.result);
    return false;
  }
}