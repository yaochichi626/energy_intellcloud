import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intellcloud/model/login_model.dart';
import 'package:intellcloud/utils/http_util.dart';

class LoginDao {
  static Future<LoginModel> getLoginModel(
      String url, Map params, Map headers) async {
    Response response =
        await HttpUtil.getInstance().doPost(url, params, headers);
    if (response.statusCode == 200) {
      final result = json.decode(response.data.toString());
      if (result != null) {
        return LoginModel.fromJson(result);
      } else {
        throw Exception('数据异常');
      }
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
