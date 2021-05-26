import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart ';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:booksea/core/model/Commodity_model.dart';

class CommodityController extends GetxController {
  AuthController authCtl = Get.find();
  String _artNo = Get.arguments;

 final _commodity = CommodityModel().obs;
 final _isCollect = false.obs;
 final _currentUserId = false.obs;

 bool get isCollect => _isCollect.value;
 void setIsCollect(value) => _isCollect.value = value;
 bool get currentUserId => _currentUserId.value;
 void setCurrentUserId(value) => _currentUserId.value = value;

 CommodityModel get commodity => _commodity.value;

 void loadCommodityInfo(String artNo,{bool refresh}) async{
   try{
     if(authCtl.isLog == true){
       ApiResponse collection = await UserService.getIsCollect(artNo);
       setIsCollect(collection.data);
     }
     ApiResponse cdy = await HomeService.getCommodityInfo(artNo);
     _commodity(cdy.data);
     if(authCtl.isLog == true){
       if(authCtl.user.userId == commodity.userId){
         setCurrentUserId(true);
       }
     }
     if(cdy.status == Status.ERROR){
       Fluttertoast.showToast(
           msg: cdy.exception.toString(),
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

 void handleCollect(String artNo) async {
   if(authCtl.isLog == true){
     String msg;
     try{
       if(isCollect == false){
         ApiResponse collect = await UserService.doCollect(artNo);
         setIsCollect(!isCollect);
         msg = collect.data.toString();
       }else{
         ApiResponse delCollect = await UserService.delCollection(artNo);
         setIsCollect(!isCollect);
         msg = delCollect.data.toString();
       }
       authCtl.setUser();
       Fluttertoast.showToast(
           msg: msg,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.black87,
           textColor: Colors.white,
           fontSize: 14.0.px
       );
     }catch(e){
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
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async{
   loadCommodityInfo(_artNo);
    super.onReady();
  }
}