import 'dart:convert';
import 'package:booksea/core/model/Commodity_model.dart';
import 'package:booksea/core/model/follows_model.dart';
import 'package:booksea/core/model/seller_model.dart';
import 'package:dio/dio.dart';

import 'package:sp_util/sp_util.dart';
import 'package:booksea/core/model/user_model.dart';
import 'package:booksea/core/model/book_model.dart';
import 'package:booksea/core/model/bookitem_model.dart';
import 'package:booksea/core/model/recommend_item_model.dart';
import 'package:booksea/core/model/booklist_model.dart';
import '../http_utils.dart';
import 'package:booksea/core/services/api_response.dart';

class HomeService {
  //书单信息
  static Future<ApiResponse<List<BookListModel>>> getBookList({bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/bookList",
          noCache: false, cacheKey: "bookList", cacheDisk: false,refresh: refresh);
      List<BookListModel> bookLists = [];
      final books = jsonRes["data"]["bookList"];
      for(var json in books){
        bookLists.add(BookListModel.fromJson(json));
      }
      return ApiResponse.completed(bookLists);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //书单内容
  static Future<ApiResponse<List<BookItemModel>>> getListContent(String listName,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/booklistContent",
          params: {"listName":listName},
          noCache: false, cacheKey: "listContent", cacheDisk: false,refresh: refresh);
      List<BookItemModel> listContent = [];
      final books = jsonRes["data"]["listContent"];
      for(var json in books){
        listContent.add(BookItemModel.fromJson(json));
      }
      return ApiResponse.completed(listContent);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //推荐信息
  static Future<ApiResponse<List<RecommendItemModel>>> getRecommend
      ({bool refresh = false,int skipNum}) async{
    try{
      final jsonRes = await HttpUtils.get("/recommend",
          params: {"skipNum":skipNum},
          noCache: false, cacheKey: "recommend", cacheDisk: false,refresh: refresh);
      List<RecommendItemModel> recommends = [];
      final res = jsonRes["data"]["recommends"];
      for(var json in res){
        //数据model化后加入res列表
        recommends.add(RecommendItemModel.fromJson(json));
      }
      return ApiResponse.completed(recommends);
    }on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //图书信息
  static Future<ApiResponse<BookModel>> getBookInfo(String iSBN,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/bookDetail", params: {"ISBN":iSBN},
          noCache: true, cacheDisk: false,refresh: refresh);
      final BookModel bookInfo = BookModel.fromJson(jsonRes["data"]["bookInfo"]);
      return ApiResponse.completed(bookInfo);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //商品列表
  static Future<ApiResponse<List<RecommendItemModel>>> getCommodityList(String iSBN,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/commodityList",
          params: {"ISBN":iSBN},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<RecommendItemModel> comList = [];
      final res = jsonRes["data"]["commodityList"];
      for(var json in res){
        comList.add(RecommendItemModel.fromJson(json));
      }
      return ApiResponse.completed(comList);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //商品信息
  static Future<ApiResponse<CommodityModel>> getCommodityInfo(String artNo,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/commodity",
          params: {"Art_No":artNo},
          noCache: true, cacheDisk: false,refresh: refresh);
      final CommodityModel commodityInfo = CommodityModel.fromJson(jsonRes["data"]["commodity"]);
      return ApiResponse.completed(commodityInfo);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //搜索
  static Future<ApiResponse<List<BookItemModel>>> getSearchInfo(String searchName,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/Search",
          params: {"searchName":searchName},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<BookItemModel> catelist = [];
      final res = jsonRes["data"]["searchInfo"];
      for(var json in res){
        catelist.add(BookItemModel.fromJson(json));
      }
      return ApiResponse.completed(catelist);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //卖家主页
  static Future<ApiResponse<SellerModel>> getSellerInfo
      (String followId,{bool refresh=false}) async {
    //获取本地缓存中用户数据
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.get("/sellerInfo",
          //user_id参数为当前用户ID，followID参数为关注的用户ID
          params: {"user_id":userModel != null ? userModel.userId : "","followId":followId},
          noCache: true, cacheDisk: false,refresh: refresh);
      final SellerModel commodityInfo = SellerModel.fromJson(jsonRes["data"]["sellerInfo"]);
      return ApiResponse.completed(commodityInfo);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //关注
  static Future<ApiResponse<String>> follow(String userId,{bool refresh=false}) async {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.post("/follow",
          data: {"user_id":userModel.userId, "followId":userId},
          );
      final  msg = jsonRes["msg"];
      return ApiResponse.completed(msg);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }
  //取消关注
  static Future<ApiResponse<String>> unfollow(String userId,{bool refresh=false}) async {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.delete("/follow",
          data: {"user_id":userModel.userId,"followId":userId},
         );
      final  msg = jsonRes["msg"];
      return ApiResponse.completed(msg);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //关注的人
  static Future<ApiResponse<List<FollowsModel>>> getFollows(String userId,{bool refresh=false}) async {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    try {
      final jsonRes = await HttpUtils.get("/user/follows",
          params: {"user_id":userModel.userId},
          noCache: true, cacheDisk: false,refresh: refresh);
      final  msg = jsonRes["data"]["follows"];
      List<FollowsModel> follows = [];
      for(var json in msg){
        follows.add(FollowsModel.fromJson(json));
      }
      return ApiResponse.completed(follows);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

  //根据ISBN搜索图书
  static Future<ApiResponse<BookModel>> getBookByISBN(String isbn,{bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/searchbyisbn",
          params: {"ISBN": isbn},
          noCache: true, cacheDisk: false,refresh: refresh);
      final  BookModel bookInfo = jsonRes["data"]["book"];
      return ApiResponse.completed(bookInfo);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }

}

