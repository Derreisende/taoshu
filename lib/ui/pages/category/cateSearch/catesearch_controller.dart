import 'package:booksea/core/model/bookitem_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/category_servie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CateSearchController extends GetxController{
  final _cateName = Get.arguments;

  RefreshController refreshCtl;
  final _loadState = false.obs;
  final searchList = <BookItemModel>[].obs;

  bool get loadState => _loadState.value;
  String get cateName => _cateName;

  void loadBooks(String cateName,{int skipNum,bool refresh}) async{
    try{
      ApiResponse cate = await CategoryService.getCateSearch(cateName,skipNum: skipNum);
      searchList.addAll(cate.data);
      _loadState.value = true;
      refreshCtl.loadComplete();
      if(cate.status == Status.ERROR){
        Fluttertoast.showToast(
            msg: cate.exception.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 14.0.px
        );
        refreshCtl.loadFailed();
      }
      if(cate.data.length == 0){
        refreshCtl.loadNoData();
      }
    }catch(e) {
      Fluttertoast.showToast(
          msg: "网络错误",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
    }
  }

  @override
  void onInit() {
    refreshCtl = new RefreshController();
    super.onInit();
  }
  @override
  void onReady() {
    loadBooks(_cateName);
    super.onReady();
  }
}