import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:booksea/core/model/follows_model.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';

class FollowsController extends GetxController {
  AuthController authCtl = Get.find<AuthController>();
  final args = Get.arguments;

  final follows = <FollowsModel>[].obs;
  final _title = "我的关注".obs;
  final _loadingState = false.obs;

  String get title => _title.value;
  void setTitle(value) => _title.value = value;

  bool get loadingState => _loadingState.value;
  void setLoadingState(value) => _loadingState.value = value;

  //加载我的关注数据
  void loadFollows({bool refresh}) async{
    try{
      ApiResponse lists = await UserService.getFollows(refresh: refresh);
      follows.assignAll(lists.data);
      setLoadingState(true);
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
  //加载我的粉丝数据
  void loadFans({bool refresh}) async{
    try{
      ApiResponse lists = await UserService.getFans(refresh: refresh);
      follows.assignAll(lists.data);
      setLoadingState(true);
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
  void handleFollow(String userId,int index,{bool refresh}) async{
    List<FollowsModel> follows2 = [];
    follows2.addAll(follows);
    String msg;
    try{
      if(follows[index].isFollow == true){
          Get.bottomSheet(
            Container(
              height: 100.px,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async{
                      follows2[index].isFollow = !follows2[index].isFollow;
                      follows.assignAll(follows2);
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
                      Get.back();
                      authCtl.setUser();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 46.px,
                        padding: EdgeInsets.symmetric(vertical: 10.px),
                        width: double.infinity,
                        color: Colors.white,
                        child: Text("取消关注",style: TextStyle(fontSize: 14.px)))
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 46.px,
                        width: double.infinity,
                        color:Colors.white,
                        child: Text("取消", style: TextStyle(fontSize: 14.px),)))
                ],
              )
            ),
            backgroundColor: Color(0xffe9e9e9), // 底部bottomSheet的背景色
            elevation: 10.0,
          );
      }else{
        follows2[index].isFollow = !follows2[index].isFollow;
        follows.assignAll(follows2);
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
        authCtl.setUser();
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
  void onInit() {
    if(args == 'myfans'){
     setTitle("我的粉丝");
    }
    super.onInit();
  }

  @override
  void onReady() {
    if(args == "myfollows"){
      loadFollows();
    }else if(args == "myfans"){
      loadFans();
    }

    super.onReady();
  }
}