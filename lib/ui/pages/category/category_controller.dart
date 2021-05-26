import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/category_servie.dart';

class CategoryController extends GetxController with SingleGetTickerProviderMixin{
  TabController tabCtl;
  final category = [].obs;
  final _tabIndex = 0.obs;
  final secondCategory = {}.obs;

  int get tabIndex => _tabIndex.value;

  void changeTabIdx(value){
    _tabIndex.value = value;
  }

  void loadCategory({bool refresh}) async{
    try{
      ApiResponse cate = await CategoryService.getCategory();
      category.assignAll(cate.data);
      tabCtl = new TabController(length: category.length, vsync: this);
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
    super.onInit();
  }
  @override
  void onReady() async{
    loadCategory();
    super.onReady();
  }
}