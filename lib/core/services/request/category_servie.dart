import 'package:booksea/core/model/bookitem_model.dart';
import 'package:dio/dio.dart';

import 'package:booksea/core/model/category_model.dart';
import '../http_utils.dart';
import 'package:booksea/core/services/api_response.dart';

class CategoryService {
  //目录信息
  static Future<ApiResponse<List<CategoryModel>>> getCategory({bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/category",
          noCache: true, cacheDisk: false,refresh: refresh);
      //catelist存储数据结果
      List<CategoryModel> catelist = [];
      final res = jsonRes["data"]["category"];
      for(var json in res){
        //数据model化后添加到catelist
        catelist.add(CategoryModel.fromJson(json));
      }
      return ApiResponse.completed(catelist);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }
  // 分类图书搜索
  static Future<ApiResponse<List<BookItemModel>>> getCateSearch(String cateName,
      {int skipNum,bool refresh=false}) async {
    try {
      final jsonRes = await HttpUtils.get("/cateSearch",
          params: {"cateName":cateName, "skipNum": skipNum},
          noCache: true, cacheDisk: false,refresh: refresh);
      List<BookItemModel> catelist = [];
      final res = jsonRes["data"]["category"];
      for(var json in res){
        catelist.add(BookItemModel.fromJson(json));
      }
      return ApiResponse.completed(catelist);
    } on DioError catch(e) {
      return ApiResponse.error(e.error);
    }
  }
}

