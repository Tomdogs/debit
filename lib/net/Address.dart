
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

  ///上传/更新用户资料信息
  static getUpdateUserReferenceInfo(){
    return "${host}/server/userCenter/updateUserDataInfo";
  }


  ///上传/更新用户资料信息
  static getUserReferenceInfo(){
    return "${host}/server/userCenter/queryUserDataInfo";
  }
  ///仓库路径下的内容 get
  static reposDataDir(reposOwner, repos, path, [branch = 'master']) {
    return "${host}repos/$reposOwner/$repos/contents/$path" + ((branch == null) ? "" : ("?ref=" + branch));
  }

  ///README 文件地址 get
  static readmeFile(reposNameFullName, curBranch) {
    return host + "repos/" + reposNameFullName + "/" + "readme" + ((curBranch == null) ? "" : ("?ref=" + curBranch));
  }

  ///我的用户信息 GET
  static getMyUserInfo() {
    return "${host}user";
  }

  ///用户信息 get
  static getUserInfo(userName) {
    return "${host}users/$userName";
  }

  /// get 是否关注
  static doFollow(name) {
    return "${host}user/following/$name";
  }

  ///用户关注 get
  static getUserFollow(userName) {
    return "${host}users/$userName/following";
  }

  ///我的关注者 get
  static getMyFollower() {
    return "${host}user/followers";
  }

  ///用户的关注者 get
  static getUserFollower(userName) {
    return "${host}users/$userName/followers";
  }

  ///create fork post
  static createFork(reposOwner, reposName) {
    return "${host}repos/$reposOwner/$reposName/forks";
  }

  ///branch get
  static getbranches(reposOwner, reposName) {
    return "${host}repos/$reposOwner/$reposName/branches";
  }

  ///fork get
  static getForker(reposOwner, reposName, sort) {
    sort ??= 'newest';
    return "${host}repos/$reposOwner/$reposName/forks?sort=$sort";
  }

  ///readme get
  static getReadme(reposOwner, reposName) {
    return "${host}repos/$reposOwner/$reposName/readme";
  }

  ///用户收到的事件信息 get
  static getEventReceived(userName) {
    return "${host}users/$userName/received_events";
  }

  ///用户相关的事件信息 get
  static getEvent(userName) {
    return "${host}users/$userName/events";
  }

  ///组织成员
  static getMember(orgs) {
    return "${host}orgs/$orgs/members";
  }

  ///获取用户组织
  static getUserOrgs(userName) {
    return "${host}users/$userName/orgs";
  }

  ///通知 get
  static getNotifation(all, participating) {
    if ((all == null && participating == null) || (all == false && participating == false)) {
      return "${host}notifications";
    }
    all ??= false;
    participating ??= false;
    return "${host}notifications?all=$all&participating=$participating";
  }

  ///patch
  static setNotificationAsRead(threadId) {
    return "${host}notifications/threads/$threadId";
  }

  ///put
  static setAllNotificationAsRead() {
    return "${host}notifications";
  }

  ///趋势 get
  static trending(since, languageType) {
    if (languageType != null) {
      return "https://github.com/trending/$languageType?since=$since";
    }
    return "https://github.com/trending?since=$since";
  }

  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }
}
