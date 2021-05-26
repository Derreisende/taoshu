import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/model/bookitem_model.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:booksea/core/services/api_response.dart';

class SearchController extends GetxController{
  //接收传入参数
  final searchName = Get.arguments;

  final _search = "".obs;

  final searchBooks = <BookItemModel>[].obs;

  String get search => _search.value;

  void changSearch(value){
    _search.value = value;
  }

  void handleSearch(String searchName) async{
      try{
        ApiResponse searchList = await HomeService.getSearchInfo(searchName);
        searchBooks.assignAll(searchList.data);
        if(searchList.status == Status.ERROR){
          Fluttertoast.showToast(
              msg: searchList.exception.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 14.0.px
          );
        }
      }catch(e) {
        print(e);
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
  void onReady() {
    print(searchName);
    if(searchName != ""){
      handleSearch(searchName);
    }
    super.onReady();
  }
}