import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData,MultipartFile;
import 'package:sp_util/sp_util.dart';

import 'package:booksea/core/model/collection_model.dart';
import 'package:booksea/core/model/publish_model.dart';
import 'package:booksea/core/model/follows_model.dart';
import '../http_utils.dart';
import 'package:booksea/core/model/user_model.dart';
import 'package:booksea/core/services/api_response.dart';

class UserService {
  //修改密码
  static Future<ApiResponse<String>> resetPwd({String oldPwd, String newPwd}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.put("/user/resetpwd",
          data: {"user_id": userModel.userId,"oldpwd":oldPwd,"newpwd":newPwd});
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 我发布的
  static Future<ApiResponse<List<PublishModel>>> getPublish({bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.get("/user/mypublish",
          params: {"user_id":userModel.userId},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<PublishModel> pubList = [];
      final jsonRes = res["data"]["mypublish"];
      for(var json in jsonRes){
        pubList.add(PublishModel.fromJson(json));
      }
      return ApiResponse.completed(pubList);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 发布商品数量
  static Future<ApiResponse<int>> getPubNum({bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.get("/user/mypubnum",
          params: {"user_id":userModel.userId},
          noCache: true, cacheDisk: false,refresh: refresh);
      final pubNum = res["data"]["pubNum"];
      return ApiResponse.completed(pubNum);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 删除发布的商品
  static Future<ApiResponse<String>> delPublish(String artNo,{bool refresh = false}) async{
    try {
      final res = await HttpUtils.delete("/user/delPublish",
          data: {"Art_No":artNo});
      final del = res["msg"];
      return ApiResponse.completed(del);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 我的收藏
  static Future<ApiResponse<List<CollectionModel>>> getCollections({bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.get("/user/collections",
          params: {"user_id":userModel.userId},
          noCache: false, cacheDisk: false, cacheKey:"collections", refresh: refresh);
      List<CollectionModel> collections = [];
      final jsonRes = res["data"]["collections"];
      for(var json in jsonRes){
        collections.add(CollectionModel.fromJson(json));
      }
      return ApiResponse.completed(collections);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //商品是否收藏
  static Future<ApiResponse<bool>> getIsCollect(String artNo,{bool refresh=false}) async {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.get("/user/iscollect",
        params: {"user_id":userModel.userId,"Art_No":artNo},
      );
      final bool isCollect = jsonRes["data"]["isCollect"];
      return ApiResponse.completed(isCollect);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 收藏商品
  static Future<ApiResponse<String>> doCollect(String artNo, {bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.post("/user/collect",
          data: {"user_id":userModel.userId, "Art_No": artNo});
      final jsonRes = res["msg"];
      return ApiResponse.completed(jsonRes);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  // 删除收藏
  static Future<ApiResponse<String>> delCollection(String artNo, {bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.delete("/user/collect",
          data: {"user_id":userModel.userId, "Art_No": artNo});
      final jsonRes = res["msg"];
      return ApiResponse.completed(jsonRes);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //发布商品
  static Future<ApiResponse<String>> publishBook({String artNo,String isbn,String customPrice,String freight,
      String appearance,String deliveryLocation,String firstCategory,String secondCategory}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.post("/user/uploadbook",
        data: {"Art_No":artNo,"user_id":userModel.userId,"ISBN":isbn,"customPrice":customPrice,"freight":freight,
          "appearance":appearance,"deliveryLocation":deliveryLocation,
          "firstCategory":firstCategory,"secondCategory":secondCategory},);
      final msg = res["msg"];
      return ApiResponse.completed(msg);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //我的关注
  static Future<ApiResponse<List<FollowsModel>>> getFollows({bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.get("/user/follows",
          params: {"user_id":userModel.userId},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<FollowsModel> myFollows = [];
      final jsonRes = res["data"]["myfollows"];
      for(var json in jsonRes){
        myFollows.add(FollowsModel.fromJson(json));
      }
      return ApiResponse.completed(myFollows);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //我的粉丝
  static Future<ApiResponse<List<FollowsModel>>> getFans({bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.get("/user/fans",
          params: {"user_id":userModel.userId},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<FollowsModel> myFans = [];
      final jsonRes = res["data"]["myfans"];
      for(var json in jsonRes){
        myFans.add(FollowsModel.fromJson(json));
      }
      return ApiResponse.completed(myFans);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

//修改头像
  static Future<ApiResponse<String>> setAvatar({File image,bool refresh = false}) async{
   //获取本地缓存中用户数据
   UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      String path = image.path;
      var filename = path.substring(path.lastIndexOf("/") + 1, path.length);
      FormData formData = FormData.fromMap({
        "user_id":userModel.userId,
        "file": await MultipartFile.fromFile(path, filename:filename),
      });
      final res = await HttpUtils.post("/user/resetavatar",
          data: formData,
      );
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //修改卖家简介
  static Future<ApiResponse<String>> setSummary({String summary,bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.put("/user/resetsummary",
        data: {"user_id":userModel.userId,"summary":summary},
      );
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //修改昵称
  static Future<ApiResponse<String>> setNickName({String nickname,bool refresh = false}) async {
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj(
        "userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.put("/user/resetnickname",
        data: {"user_id": userModel.userId, "nickname": nickname},
      );
      return ApiResponse.completed(res["msg"]);
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

    //修改性别
    static Future<ApiResponse<String>> setSex({String sex,bool refresh = false}) async{
      //获取本地缓存中用户数据
      UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
      try {
        final res = await HttpUtils.put("/user/resetsex",
          data: {"user_id":userModel.userId,"sex":sex},
        );
        return ApiResponse.completed(res["msg"]);
      } on DioError catch(e) {
        return ApiResponse.error(e.error);
      }
  }

  //修改所在地
  static Future<ApiResponse<String>> setAddress({String address,bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.put("/user/resetaddress",
        data: {"user_id":userModel.userId,"address":address},
      );
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //修改个人签名
  static Future<ApiResponse<String>> setSignature({String signature,bool refresh = false}) async{
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final res = await HttpUtils.put("/user/resetsignature",
        data: {"user_id":userModel.userId,"signature":signature},
      );
      return ApiResponse.completed(res["msg"]);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }
}

