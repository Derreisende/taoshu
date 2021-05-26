import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/widgets/myDialog.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/pages/profile/profile_controller.dart';

class MyPublishController extends GetxController {
  ProfileController proCtl = Get.find<ProfileController>();
  final _loadState = false.obs;

  bool get loadState => _loadState.value;

  void setLoadState(value) => _loadState.value = value;

  final myPublish = [].obs;

  //加载我发布的商品
  void loadMyPublish({bool refresh}) async{
    try{
      ApiResponse lists = await UserService.getPublish(refresh: refresh);
      myPublish.assignAll(lists.data);
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

  void handleDelPublish(String artNo) async{
    try{
      Get.dialog(
        myDialog(
          content:Text("确定要下架这个商品吗？",style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w600),),
          onCancel: (){
            Get.back();
          },
          onConfirm: () async{
            ApiResponse delPub = await UserService.delPublish(artNo);
            Fluttertoast.showToast(
                msg: delPub.data,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 14.0.px
            );
            Get.back();
            loadMyPublish(refresh: true);
          }
        )
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
    loadMyPublish(refresh: true);
    super.onReady();
  }
}