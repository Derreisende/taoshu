import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/model/seller_model.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/ui/widgets/myDialog.dart';

class SellerController extends GetxController{
  AuthController authCtl = Get.find();
  String _userId = Get.arguments;
  ScrollController scrollCtl;

  final _sellerInfo = SellerModel().obs;
  final _isMe = false.obs;

  bool get isMe => _isMe.value;
  void setIsMe(value) => _isMe.value = value;

  SellerModel get sellerInfo => _sellerInfo.value;

  @override
  void onInit() {
    scrollCtl = new ScrollController();
    super.onInit();
  }

  //加载卖家信息
  void loadSellerInfo(String userId,{bool refresh}) async{
    try{
      ApiResponse seller = await HomeService.getSellerInfo(userId);
      _sellerInfo.value = seller.data;

      if(seller.status == Status.ERROR){
        Fluttertoast.showToast(
            msg: seller.exception.toString(),
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

  //关注
  void handleFollow(String userId,{bool refresh}) async{
    if(authCtl.isLog == true){
      String msg;
      try{
        if(sellerInfo.isFollow == true){
          Get.dialog(
              myDialog(
                content: Text("是否取消关注",style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w600),),
                onCancel: (){
                  Get.back();
                },
                onConfirm: () async {
                  ApiResponse res = await HomeService.unfollow(userId);
                  msg = res.data;
                  Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 14.0.px
                  );
                  sellerInfo.isFollow = false;
                  _sellerInfo.refresh();
                  authCtl.setUser();
                  Get.back();
                }
              ),
            transitionDuration: Duration(milliseconds: 200),
            transitionCurve: Threshold(0.2)
          );
        }else{
          ApiResponse res = await HomeService.follow(userId);
          msg = res.data;
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 14.0.px
          );
          sellerInfo.isFollow = true;
          _sellerInfo.refresh();
          authCtl.setUser();
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
    }else{
      Get.toNamed(AppPages.LOGIN);
    }
  }

  @override
  void onReady() {
    if(authCtl.isLog && _userId == authCtl.user.userId){
        setIsMe(true);
    }
    loadSellerInfo(_userId);
    super.onReady();
  }
}