import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';

class CollectionController extends GetxController{
  AuthController authCtl = Get.find<AuthController>();
  final _loadState = false.obs;

  final collections = [].obs;

  bool get loadState => _loadState.value;
  void setLoadState(value) => _loadState.value = value;

  //加载我的关注数据
  void loadCollections({bool refresh}) async{
    try{
      ApiResponse lists = await UserService.getCollections(refresh: refresh);
      collections.assignAll(lists.data);
      setLoadState(true);
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

  void handleDelCollection(String artNo) async{
    try{
      ApiResponse del = await UserService.delCollection(artNo);
      loadCollections(refresh: true);
      authCtl.setUser();
      Fluttertoast.showToast(
          msg: del.data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
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
  void onReady() {
    loadCollections(refresh: true);
    super.onReady();
  }
}