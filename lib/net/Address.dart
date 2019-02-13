
import 'package:debit/common/config/Config.dart';

///地址数据
class Address {
  static const String host = "http://47.112.6.233:8080/AnPing";
  static const String hostWeb = "https://github.com/";
  static const String downloadUrl = 'https://www.pgyer.com/GSYGithubApp';
  static const String graphicHost = 'https://ghchart.rshah.org/';
  static const String updateUrl = 'https://www.pgyer.com/vj2B';

  ///登录
  static getLogin(){
    return "${host}/server/userManage/userLogin";
  }
  ///注册
  static getRegister(){
    return "${host}/server/userManage/userRegidter";
  }

  ///修改用户资料信息
  static getUpdateUserReferenceInfo(){
    return "${host}/server/userCenter/updateUserDataInfo";
  }


  ///查询用户资料信息
  static getUserReferenceInfo(){
    return "${host}/server/userCenter/queryUserDataInfo";
  }


  ///提交身份信息
  static getSubmitUserIdentity(){
    return "${host}/server/userCenter/submitUserIdentity";
  }

  ///查询用户信息
  static getUserById(){
    return "${host}/server/userManage/getUserById";
  }

  ///用户修改密码
  static getUpdatePassword(){
    return "${host}/server/setCenter/updatePassword";
  }

  ///用户登出
  static getLogout(){
    return "${host}/server/setCenter/logout";
  }

  ///我的借款
  static getTradingBorrowed(){
    return "${host}/server/tradingCenter/getTradingBorrowed";
  }


  ///我的还款
  static getTradingReturn(){
    return "${host}/server/tradingCenter/getTradingReturn";
  }

  ///贷款设置加载
  static getTradingBorrowingQueryBase(){
    return "${host}/server/tradingCenter/tradingBorrowingQueryBase";
  }

  ///提交收款银行卡信息
  static getUserBankCardInfo(){
    return "${host}/server/userCenter/userBankCardInfo";
  }

  ///查询收款银行卡信息
  static getQueryBankCardInfo(){
    return "${host}/server/userCenter/queryBankCardInfo";
  }

  ///手机号验证
  static getUserPhoneNumberInfo(){
    return "${host}/server/userCenter/userPhoneNumberInfo";
  }

  ///查询手机号信息（用于数据回显）
  static getQueryPhoneNumberInfo(){
    return "${host}/server/userCenter/queryPhoneNumberInfo";
  }

  ///用户借款
  static getTradingBorrowingNow(){
    return "${host}/server/tradingCenter/tradingBorrowingNow";
  }

}
