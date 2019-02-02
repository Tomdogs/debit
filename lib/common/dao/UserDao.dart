import 'dart:convert';
import 'dart:io';
import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/DaoResult.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/net/Address.dart';
import 'package:debit/net/Api.dart';
import 'package:debit/net/Code.dart';
import 'package:debit/net/HttpUtil.dart';
import 'package:debit/net/ResultData.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

class UserDao {
  static login(phoneNumber,userPassword, store)  async {

    Map requestParams = {
      "user_netroom_phonenum": phoneNumber,
      "user_password": userPassword,
    };


    String type = phoneNumber + ":" + userPassword;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }
//    var res = await HttpManager.netFetch(Address.getLogin(), requestParams, null, new Options(method: "post"));
    var res = await HttpManager.netFetch(Address.getLogin(), requestParams, null, null);

    if(res !=null && res.result){
      var jsonData = res.data;
      Map<String,dynamic> map = await json.decode(jsonData);
      String code = map['code'];
      String msg = map['msg'];
      String userId = map['userId'];
      if(code == Code.STATUS_SUCCESS){
        User user = new User(phoneNumber,userPassword,userID:userId);
        await LocalStorage.save(Config.USER_PHONE_KEY, phoneNumber);
        await LocalStorage.save(Config.PW_KEY, userPassword);
        await LocalStorage.save(Config.USER_INFO, user.toString());
        await LocalStorage.save(Config.USER_ID_KEY, userId);
        store.dispatch(new UpdateUserAction(user));
        return new DataResult(msg, true);
      }
      return new DataResult(msg, false);

    }
    return new DataResult(null, false);
  }


  static register(phoneNumber,netRoomPassword,userPassword,store) async{
    Map requestParams = {
      "user_netroom_phonenum": phoneNumber,
      "user_netroom_password": netRoomPassword,
      "user_password": userPassword,
    };
    var res = await HttpManager.netFetch(Address.getRegister(), requestParams, null, null);
//    var res = await HttpUtil.getInstance().post(Address.getRegister(), data: requestParams);
    if (res != null && res.result) {

      var jsonData = res.data;
      Map<String,dynamic> map = await json.decode(jsonData);
      String code = map['code'];
      var msg = map['msg'];
      String userId = map['userId'];

      if(code == Code.STATUS_SUCCESS){
        await LocalStorage.save(Config.USER_PHONE_KEY, phoneNumber);
        await LocalStorage.save(Config.NET_ROOM_PW_KEY, netRoomPassword);
        await LocalStorage.save(Config.PW_KEY, userPassword);
        await LocalStorage.save(Config.USER_ID_KEY, userId);

        User user = new User(phoneNumber, userPassword,netRoomPassword: netRoomPassword,userID: userId);
        await LocalStorage.save(Config.USER_INFO, user.toString());

        store.dispatch(new UpdateUserAction(user));
        return new DataResult(msg, true);
      }else{
        return new DataResult(msg, false);
      }

    }
    return new DataResult(null, res.result);
  }

  ///初始化用户信息
  static initUserInfo(Store store) async {
    var res = await getUserInfoLocal();
    if (res.result) {
      store.dispatch(UpdateUserAction(res.data));
    }

    return new DataResult(res.data, (res.result));
  }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (Config.DEBUG) {
      print('获取本地用户：$userText');
    }
    if (userText != null) {
      var phone = await LocalStorage.get(Config.USER_PHONE_KEY);
      var netRoomPassword = await LocalStorage.get(Config.NET_ROOM_PW_KEY);
      var userPassword = await LocalStorage.get(Config.PW_KEY);
      var userId = await LocalStorage.get(Config.USER_ID_KEY);
      User user = new User(phone, userPassword,netRoomPassword: netRoomPassword,userID: userId);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getUserID() async{
    var userId = await LocalStorage.get(Config.USER_ID_KEY);
    print("打印当前的userID：$userId");
    return userId;
  }

  ///上传/更新用户资料信息
  static updateUserDataInfo(requestParams) async{
        var res = await HttpManager.netFetch(Address.getUpdateUserReferenceInfo(), requestParams, null, new Options(method: "post"));
        if(res != null && res.result){
          print("上传/更新用户资料信息：${res.data.toString()}");
          var data = res.data.toString();
          Map map = json.decode(data);
          String code = map['code'];
          String msg = map['msg'];
          print("上传/更新用户资料信息成功：${msg}");
          if(code == Code.STATUS_SUCCESS){
            print("上传/更新用户资料信息成功：${code}");
            return new DataResult(msg,true);
          }else{
            return new DataResult(msg,false);
          }

        }
  }


  ///查询用户资料信息
  static getUserDataInfo() async{

//    var res = await HttpManager.netFetch(Address.getUserReferenceInfo(), {'userId':await getUserID()}, null, new Options(method: "post"));
    var res = await HttpUtil.getInstance().post(Address.getUserReferenceInfo(), data: {'userId':await getUserID()});

    /*if(res != null && res.result){
      print("查询用户资料信息1：${res.data.toString()}");
      var data = res.data.toString();
      print("查询用户资料信息2：${data}");
      Map map = json.decode(data);
      String code = map['code'];
      String msg = map['msg'];
      print("查询用户资料信息2：${msg}");
      if(code == Code.STATUS_SUCCESS){
        print("查询用户资料信息3：${code}");
        return new DataResult(msg,true);
      }else{
        return new DataResult(msg,false);
      }

    }*/
/*    if(res != null){
      print("查询用户资料信息2：${res}");
    }*/
  }

}

