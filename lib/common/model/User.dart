
class User{
  String phoneNumber;
  String netRoomPassword;
  String userPassword;
  String userID;

  User(this.phoneNumber,this.userPassword,{this.netRoomPassword,this.userID});

  // 命名构造函数
  User.empty();

}