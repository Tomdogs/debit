
import 'dart:io';
import 'package:debit/common/config/Config.dart';
import 'package:debit/net/Code.dart';
import 'package:debit/net/ResultData.dart';
import 'package:debit/widgets/Toast.dart';
import 'package:dio/dio.dart';
import 'dart:collection';
import 'package:connectivity/connectivity.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///I replaced `import 'package:sky_engine/_http/http.dart';` as `import 'dart:io';` in some library.
///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(url, params, Map<String, String> header, Options option, BuildContext context,{isJson =false,noTip = false}) async {

    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.toast(context, "请连接网络！");
//      return new ResultData(Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip), false, Code.NETWORK_ERROR);
      return new ResultData("请连接网络~！", false, Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
      if(!isJson){
        option.contentType=ContentType.parse("application/x-www-form-urlencoded");
      }
//      option.contentType=ContentType.parse("multipart/form-data");
    } else{
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.connectTimeout = 15000;

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }

      return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }

    if (Config.DEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }

    }


    try {
      if (option.contentType != null && option.contentType.primaryType == "text") {
        print('返回参数3: ' + option.contentType.toString());
        return new ResultData(response.data, true, Code.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('返回参数4: ' + response.statusCode.toString());
        return new ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      print('返回参数5: ');
      return new ResultData(response.data, false, response.statusCode, headers: response.headers);
    }
    print('返回参数6: ');
    return new ResultData(Code.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode);
  }

}
