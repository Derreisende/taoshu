import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
//import 'package:qrscan/qrscan.dart' as scanner;

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/utils/get_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
    final name = "书海".obs;
    ScrollController scrollCtl;
    RefreshController refreshController;

    final bookList = [].obs;
    final bls = [].obs;
    final recommends = [].obs;
    //扫描的ISBN
    final _scanIsbn = "".obs;

    String get scanIsbn => _scanIsbn.value;

    void setScanIsbn(value) => _scanIsbn.value = value;

    void loadBookList({bool refresh}) async{
      try{
        ApiResponse lists = await HomeService.getBookList(refresh: refresh);
        bookList.assignAll(lists.data);
        bls.assignAll(List.from(bookList.take(4)));
        Get.dismiss();
      }catch(e) {
        Get.dismiss();
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

     void loadRecommends({int skipNum}) async {
      try{
        ApiResponse lists = await HomeService.getRecommend(skipNum: skipNum);
        recommends.addAll(lists.data);
        refreshController.loadComplete();
        if(lists.status == Status.ERROR){
          Fluttertoast.showToast(
              msg: lists.exception.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 14.0.px
          );
          refreshController.loadFailed();
        }

        if(lists.data.length == 0){
          refreshController.loadNoData();
        }
      }catch(e) {
        Get.dismiss();
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

    void onRefresh() async {
      ApiResponse lists = await HomeService.getBookList(refresh: true);
      ApiResponse lists2 = await HomeService.getRecommend(refresh: true);
      bookList.assignAll(lists.data);
      recommends.assignAll(lists2.data);
      bls.assignAll(List.from(bookList.take(4)));
      if(lists.status == Status.ERROR){
        refreshController.refreshFailed();
      }
      refreshController.refreshCompleted();
    }

  //扫描图书ISBN条码
  // Future scan() async {
  //   try {
  //     String barcode = await scanner.scan();
  //     setScanIsbn(barcode);
  //     Get.toNamed(AppPages.SEARCH,arguments: scanIsbn);
  //   } on PlatformException catch (e) {
  //     if (e.code == scanner.CameraAccessDenied) {
  //       setScanIsbn('用户未授权');
  //     } else {
  //       setScanIsbn('未知错误: $e');
  //     }
  //   } on FormatException {
  //     setScanIsbn('null (User returned using the "back"-button before scanning anything. Result)');
  //   } catch (e) {
  //     setScanIsbn('Unknown error: $e');
  //   }
  // }


    @override
  void onInit() async{
    scrollCtl = new ScrollController();
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onReady() async{
    Get.loading();
    loadBookList();
    loadRecommends();
    super.onReady();
  }
}
