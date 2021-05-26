import 'package:booksea/ui/pages/home/booklist/booklist_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/utils/get_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/home_service.dart';

class ListDetailController extends GetxController{
  final listName = Get.arguments;
  final listContents = [].obs;

  ScrollController scrollCtl = new ScrollController();
  //appbar标题
  final _title = "".obs;

  String get title => _title.value;

  void changeTitle(value) => _title.value = value;

  void loadListContent(String listName,{bool refresh}) async{
   try{
     ApiResponse lists = await HomeService.getListContent(listName,refresh: refresh);
     listContents.assignAll(lists.data);
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
    scrollCtl.addListener(() {
      if(scrollCtl.offset < 130.px - Get.statusBarHeight){
        changeTitle("");
      }else{
        changeTitle("文学世界");
      }
    });
    super.onInit();
  }

  @override
  void onReady() async{
    loadListContent(listName);
    super.onReady();
  }

  @override
  void onClose() {
    scrollCtl.dispose();
    super.onClose();
  }
}