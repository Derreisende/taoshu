import 'package:booksea/core/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/home_service.dart';

class BookController extends GetxController{
  final _title = "".obs;
  final _bookInfo = BookModel().obs;
  final commoList = [].obs;

  String _isbn = Get.arguments;

  String get title => _title.value;
  get bookInfo => _bookInfo.value;

  void changeTitle(value) => _title.value = value;

  //加载图书信息和在售商品信息
  void loadBookInfo(String isbn,{bool refresh}) async{
    try{
      ApiResponse book = await HomeService.getBookInfo(isbn);
      changeTitle(book.data.title);
      _bookInfo.value = book.data;
      ApiResponse comlist = await HomeService.getCommodityList(isbn);
      commoList.assignAll(comlist.data);
      if(book.status == Status.ERROR){
        Fluttertoast.showToast(
            msg: book.exception.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 14.0.px
        );
      }
      if(comlist.status == Status.ERROR){
        Fluttertoast.showToast(
            msg: comlist.exception.toString(),
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
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    loadBookInfo(_isbn);
    super.onReady();
  }
}