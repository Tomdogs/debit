
class User{
  String phoneNumber;
  String netRoomPassword;
  String userPassword;
  String userID;
  int flagOne;
  int flagTwo;
  int flagThree;
  int flagFour;

  User({
        this.phoneNumber,
        this.userPassword,
        this.netRoomPassword,
        this.userID,
        this.flagOne,
        this.flagTwo,
        this.flagThree,
        this.flagFour
      });

  // 命名构造函数
  User.empty();

}