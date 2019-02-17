import 'dart:convert';
import 'package:debit/common/config/Config.dart';
import 'package:debit/common/dao/DaoResult.dart';
import 'package:debit/common/model/BorrowSetting.dart';
import 'package:debit/common/model/User.dart';
import 'package:debit/common/model/UserData.dart';
import 'package:debit/common/model/UserBorrowRepay.dart';
import 'package:debit/common/redux/UserReducer.dart';
import 'package:debit/common/utils/LocalStorage.dart';
import 'package:debit/net/Address.dart';
import 'package:debit/net/Api.dart';
import 'package:debit/net/Code.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

class UserDao {
  static login(phoneNumber, userPassword, store,context) async {
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
    var res = await HttpManager.netFetch(
        Address.getLogin(), requestParams, null, null,context);

    if (res != null && res.result) {
      var jsonData = res.data;
      Map<String, dynamic> map = await json.decode(jsonData);
      String code = map['code'];
      String msg = map['msg'];
      String userId = map['userId'];
      if (code == Code.STATUS_SUCCESS) {
        User user = new User(phoneNumber:phoneNumber,userPassword:userPassword, userID: userId);
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

  static register(phoneNumber, netRoomPassword, userPassword, store,context) async {
    Map requestParams = {
      "user_netroom_phonenum": phoneNumber,
      "user_netroom_password": netRoomPassword,
      "user_password": userPassword,
    };
    var res = await HttpManager.netFetch(Address.getRegister(), requestParams, null, null,context);
//    var res = await HttpUtil.getInstance().post(Address.getRegister(), data: requestParams);
    if (res != null && res.result) {
      var jsonData = res.data;
      Map<String, dynamic> map = await json.decode(jsonData);
      String code = map['code'];
      var msg = map['msg'];
      String userId = map['userId'];

      if (code == Code.STATUS_SUCCESS && userId != null) {

        print('注册成功后返回的是：$userId');


        await LocalStorage.save(Config.USER_PHONE_KEY, phoneNumber);
        await LocalStorage.save(Config.NET_ROOM_PW_KEY, netRoomPassword);
        await LocalStorage.save(Config.PW_KEY, userPassword);
        await LocalStorage.save(Config.USER_ID_KEY, userId);

        User user = new User(phoneNumber:phoneNumber,userPassword:userPassword,
            netRoomPassword: netRoomPassword, userID: userId);
        await LocalStorage.save(Config.USER_INFO, user.toString());

        store.dispatch(new UpdateUserAction(user));
        return new DataResult(msg, true);
      } else {
        return new DataResult(msg, false);
      }
    }
    return new DataResult("网络出现问题", res.result);
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
      User user = new User(phoneNumber:phone, userPassword:userPassword,
          netRoomPassword: netRoomPassword, userID: userId);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getUserID() async {
    var userId = await LocalStorage.get(Config.USER_ID_KEY);
    print("打印当前的userID：$userId");
    return userId;
  }

  ///修改用户资料信息
  static updateUserDataInfo(requestParams,context) async {
    var res = await HttpManager.netFetch(Address.getUpdateUserReferenceInfo(),
        requestParams, null, new Options(method: "post"),context,isJson: true);
    if (res != null && res.result) {
      print("上传/更新用户资料信息：${res.data.toString()}");
      var data = res.data.toString();
      Map map = json.decode(data);
      String code = map['code'];
      String msg = map['msg'];
      print("上传/更新用户资料信息成功：${msg}");
      if (code == Code.STATUS_SUCCESS) {
        print("上传/更新用户资料信息成功：${code}");
        return new DataResult(msg, true);
      } else {
        return new DataResult(msg, false);
      }
    }
  }

  ///查询用户资料信息
  static getUserDataInfo(context) async {
    var res = await HttpManager.netFetch(Address.getUserReferenceInfo(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context);

    if (res != null && res.result) {
      print("查询用户资料信息luo1：${res.data.toString()}");

      Map userDataMap = json.decode(res.data.toString());
      var userData = new UserData.fromJson(userDataMap);

      if (userData.code == Code.STATUS_SUCCESS) {
        Data data = userData.data;
        print("查询用户资料信息2：${ data.bankCardBankName}");
        print("查询用户资料信息3：${ data.bankCardIdcard}");
        return new DataResult(data, true);
      } else {
        return new DataResult(null, false);
      }

    }

  }



  ///提交身份信息
  static getSubmitUserIdentity(formData,context) async {
    var res = await HttpManager.netFetch(Address.getSubmitUserIdentity(),
        formData, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("提交身份信息1：${res.data.toString()}");

      var data = res.data.toString();
      Map map = json.decode(data);
      String code = map['code'];
      String msg = map['msg'];

      if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(msg, false);
      }
    }

  }

  ///查询用户信息
  static getUserById(context) async {
    var res = await HttpManager.netFetch(Address.getUserById(),
        {'id': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("查询用户信息1：${res.data.toString()}");

      Map userDataMap = json.decode(res.data.toString());
      var userData = new UserData.fromJson(userDataMap);

      if (userData.code == Code.STATUS_SUCCESS) {
        Data data = userData.data;
        print("查询用户信息2：${ data.flagOne}");
        print("查询用户信息3：${ data.flagTwo}");
        print("查询用户信息4：${ data.flagThree}");
        print("查询用户信息5：${ data.flagFour}");
        return new DataResult(data, true);
      } else {
        return new DataResult(null, false);
      }

    }

  }

  ///提交收款银行卡信息
  static getUserBankCardInfo(formData,context) async {
    var res = await HttpManager.netFetch(Address.getUserBankCardInfo(),
        formData, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("提交收款银行卡信息：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String code = infoMap['code'];
      var msg = infoMap['msg'];

       if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(null, false);
      }
    }

  }

  ///查询收款银行卡信息
  static getQueryBankCardInfo(context) async {
    var res = await HttpManager.netFetch(Address.getQueryBankCardInfo(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("查询收款银行卡信息1：${res.data.toString()}");

      Map userDataMap = json.decode(res.data.toString());
      var userData = new UserData.fromJson(userDataMap);

      if (userData.code == Code.STATUS_SUCCESS) {

        return new DataResult(userData.data, true);
      } else {
        return new DataResult(userData.msg, false);
      }
    }

  }



  ///手机号验证
  static getUserPhoneNumberInfo(formData,context) async {
    var res = await HttpManager.netFetch(Address.getUserPhoneNumberInfo(),
        formData, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("手机号验证：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String code = infoMap['code'];
      var msg = infoMap['msg'];

      if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(null, false);
      }
    }

  }


  ///查询手机号信息（用于数据回显）
  static getQueryPhoneNumberInfo(context) async {
    var res = await HttpManager.netFetch(Address.getQueryPhoneNumberInfo(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("查询手机号信息1：${res.data.toString()}");

      Map userDataMap = json.decode(res.data.toString());
      var userData = new UserData.fromJson(userDataMap);

      if (userData.code == Code.STATUS_SUCCESS) {

        return new DataResult(userData.data, true);
      } else {
        return new DataResult(userData.msg, false);
      }
    }

  }


  ///我的借款
  static getTradingBorrowed(context) async {
    var res = await HttpManager.netFetch(Address.getTradingBorrowed(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("我的借款1：${res.data.toString()}");

      Map userBorrowRepayMap = json.decode(res.data.toString());
      var userBorrowRepay = new UserBorrowRepay.fromJson(userBorrowRepayMap);

      if (userBorrowRepay.code == Code.STATUS_SUCCESS) {

        return new DataResult(userBorrowRepay.borrowRepayList, true);
      } else {
        return new DataResult("查询我的借款错误", false);
      }
    }

  }


  ///我的还款
  static getTradingReturn(context) async {
    var res = await HttpManager.netFetch(Address.getTradingReturn(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("我的还款1：${res.data.toString()}");

      Map userBorrowRepayMap = json.decode(res.data.toString());
      var userBorrowRepay = new UserBorrowRepay.fromJson(userBorrowRepayMap);

      if (userBorrowRepay.code == Code.STATUS_SUCCESS) {

        return new DataResult(userBorrowRepay.borrowRepayList, true);
      } else {
        return new DataResult("查询我的还款错误", false);
      }
    }

  }

  ///用户修改密码
  static getUpdatePassword(formData,context) async {
    var res = await HttpManager.netFetch(Address.getUpdatePassword(),
        formData, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("用户修改密码：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String code = infoMap['code'];
      var msg = infoMap['msg'];

      if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(null, false);
      }
    }

  }


  ///贷款设置加载
  static getTradingBorrowingQueryBase(context) async {
    var res = await HttpManager.netFetch(Address.getTradingBorrowingQueryBase(),
        {'userId': await getUserID()}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("贷款设置加载1：${res.data.toString()}");

      Map borrowSettingMap = json.decode(res.data.toString());
      var borrowSetting = new BorrowSetting.fromJson(borrowSettingMap);

      if (borrowSetting.code == Code.STATUS_SUCCESS) {

        return new DataResult(borrowSetting.dataLoadSet, true);
      } else {
        return new DataResult("贷款设置加载错误", false);
      }
    }

  }

  ///用户借款
  static getTradingBorrowingNow(formData,context) async {
    var res = await HttpManager.netFetch(Address.getTradingBorrowingNow(),
        formData, null, new Options(method: "post"),context,isJson: true);

    if (res != null && res.result) {
      print("用户借款：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String code = infoMap['code'];
      var msg = infoMap['msg'];

      if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(msg, false);
      }
    }

  }

  ///短信接口
  static getSms(String phoneNum,context) async {
    var res = await HttpManager.netFetch(Address.getSms(),
        {'user_netroom_phonenum': phoneNum}, null, new Options(method: "post"),context,isJson: false);

    if (res != null && res.result) {
      print("短信接口：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String status = infoMap['code'];
      int code = infoMap['messageCode'];
      var msg = infoMap['msg'];

      if (status == Code.STATUS_SUCCESS) {
        return new DataResult(code, true);
      } else {
        print("短信接口2：${msg}");
        return new DataResult(msg, false);
      }
    }

  }

  ///提交审核
  static getUpdateUserExamineState(formData,context) async {
    var res = await HttpManager.netFetch(Address.getUpdateUserExamineState(),
        formData, null, new Options(method: "post"),context,isJson: true);

    //0 待提交 1 审核中 2 审核不通过 3 审核成功
    if (res != null && res.result) {
      print("提交审核：${res.data.toString()}");

      Map infoMap = json.decode(res.data.toString());
      String code = infoMap['code'];
      var msg = infoMap['msg'];

      if (code == Code.STATUS_SUCCESS) {
        return new DataResult(msg, true);
      } else {
        return new DataResult(msg, false);
      }
    }

  }
}
