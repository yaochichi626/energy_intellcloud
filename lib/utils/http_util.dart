import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpUtil {
  final int connectTimeout = 20000;
  final int receiveTimeout = 20000;
  final ResponseType responseType = ResponseType.plain;

  static HttpUtil httpUtil;

  static HttpUtil getInstance() {
    if (httpUtil == null) {
      httpUtil = HttpUtil();
    }
    return httpUtil;
  }

  Future<dynamic> doGet(String url) async {
    Dio dio = Dio();
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    dio.options.responseType = responseType;
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = json.decode(response.data.toString());
      return result;
    }
    return null;
  }

  Future<Response> doPost(String url, Map params, Map headers) async {
    Dio dio = Dio();
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    dio.options.headers = headers;
    dio.options.responseType = responseType;
    dio.options.queryParameters = params;
    try {
      Response response = await dio.post(url,data: params);
      return response;
    } catch (e) {
      return _dealErrorInfo(e);
    }
  }

  _dealErrorInfo(error) {
    print(error.type);
    Response errorResponse;
    if (error.response != null) {
      errorResponse = error.response;
    } else {
      errorResponse = new Response(statusCode: 201);
    }
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      errorResponse.statusMessage = '网络请求超时';
    } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusMessage = '网络连接超时';
    } else if (error.type == DioErrorType.DEFAULT) {
      errorResponse.statusMessage = '服务器连接异常';
    }else if (error.type == DioErrorType.RESPONSE) {
      errorResponse.statusMessage = '用户名或密码错误';
    }else{
      errorResponse.statusMessage = '请求异常';
    }
    return errorResponse;
  }
}
