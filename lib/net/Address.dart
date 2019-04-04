
import 'package:debit/common/config/Config.dart';

///地址数据
class Address {
  static const String host = "暂时没有后台服务器";
  static const String web_url = 'http://c105.pop800.com/web800/c.do?n=428632&type=1&url=http%3A%2F%2Ft5k7m4x2.gotoip3.com%2Findex.php%3Fm%3DHelp%26a%3Dindex&l=cn&at=0';

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

  ///短信接口
  static getSms(){
    return "${host}/server/userManage/getSms";
  }

  ///提交审核
  static getUpdateUserExamineState(){
    return "${host}/server/userManage/updateUserExamineState";
  }

  ///跑马灯
  static getSevenDaysDatas(){
    return "${host}/server/orderState/getSevenDaysDatasForWeb";
  }
}
