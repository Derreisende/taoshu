import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';

import '../http_utils.dart';
import 'package:booksea/core/services/config.dart';
import 'package:booksea/init.dart';
import 'package:booksea/core/model/user_model.dart';
import 'package:booksea/core/services/api_response.dart';

class AuthService {
  // 登录请求方法
  static Future<ApiResponse<UserModel>> login(String account, String pwd) async{
    try {
      final res = await HttpUtils.post("/user/login",
        data: {"account":account,"password":pwd},);
      if(res["errCode"] == '0') {
        // 清空所有缓存
        Global.netCache.cache.clear();
        SpUtil.putString("accessToken", res["token"]);
        // 设置token
        HttpUtils.setToken(res["token"]);
        // 存储token
        Config.accessToken = SpUtil.getString("accessToken");
      }
      final UserModel data = UserModel.fromJson(res["data"]["user"]);
      SpUtil.putObject("userInfo",data);   //用户数据存入本地缓存
      return ApiResponse.completed(data);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //注册
  static Future<ApiResponse<String>> register(String email, String phoneNumber,
      String pwd, String nickname) async{
    try {
      //发送post请求
      final res = await HttpUtils.post("/user/register",
        data: {"email":email,"phoneNumber":phoneNumber,"password":pwd,"nickname":nickname});
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //获取用户信息
  static Future<ApiResponse<UserModel>> getUser({bool refresh=false}) async {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.get("/user/userInfo",
          params: {"user_id":userModel.userId},
          noCache: false, cacheKey: "userInfo", cacheDisk: true,refresh: refresh);
      final UserModel data = UserModel.fromJson(jsonRes["data"]["user"]);
      SpUtil.putObject("userInfo",data);   //用户数据存入本地缓存
      return ApiResponse.completed(data);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 退出登录
  static Future logOut() async {
    try {
      SpUtil.remove("accessToken");
      SpUtil.remove("userInfo");
      HttpUtils.setToken("");
      Config.accessToken = "";
      // 清空所有缓存
      Global.netCache.cache.clear();
     return true;
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }
}

