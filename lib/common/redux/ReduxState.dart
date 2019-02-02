
import 'package:debit/common/model/User.dart';
import 'package:debit/common/redux/UserReducer.dart';

class ReduxState{

  User userInfo;

  ReduxState({this.userInfo});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state,dynamic action);
///我们自定义 appReducer 用于创建 store

ReduxState appReducer(ReduxState state,action){
 return ReduxState(
   ///通过UserReducer 将 ReduxState 内的 userInfo 和 action关联在一起
     userInfo:UserReducer(state.userInfo,action),
 );
}