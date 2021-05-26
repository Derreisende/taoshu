import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/profile/widgets/appbar.dart';

class ProfileController extends GetxController {
  AuthController authCtl = Get.find<AuthController>();
  AppBarWidget appBar;
  ScrollController scrollController;
  double maxOffset = 80.0.px;

  //用户头像
  final _avatarPath = "".obs;
  //用户名
  final _userName = "用户".obs;
  //我发布的
  final _myPublish = "0".obs;
  //ISBN码
  final _isbn = "".obs;

  String get avatarPath => _avatarPath.value;
  String get userName => _userName.value;
  String get myPublish => _myPublish.value;
  String get isbn => _isbn.value;

  void changeIsbn(value){
    _isbn.value = value;
  }
  void setAvatar(value) {
  _avatarPath.value = R.sourceUrl+value;
  }
  void setUserName(value) => _userName.value = value;
  void setMyPublish(value) => _myPublish.value = value;

  scrollViewDidScrolled(double offSet) {
    ///appbar 透明度
    double appBarOpacity = offSet / maxOffset;
    double halfPace = maxOffset / 2.0;

    if (appBarOpacity < 0) {
      appBarOpacity = 0.0;
    } else if (appBarOpacity > 1) {
      appBarOpacity = 1.0;
    }

    ///更新透明度
    if (appBar != null && appBar.updateAppBarOpacity != null) {
      appBar.updateAppBarOpacity(appBarOpacity);
    }
  }

  void onRefresh() async {
    authCtl.setUser();
    setProfileInfo();
  }

  void setProfileInfo(){
    setAvatar(authCtl.user.avatar);
    setUserName(authCtl.user.nickname);
    loadPubNum();
  }

  //加载发布商品数量
  void loadPubNum({bool refresh}) async{
    try{
      ApiResponse pubNum = await UserService.getPubNum(refresh: refresh);
      setMyPublish(pubNum.data.toString());
    }catch(e) {
      Fluttertoast.showToast(
          msg: "未知错误",
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
  void onInit() async{
    appBar = AppBarWidget();
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onReady() {
    if(authCtl.isLog == true){
      setProfileInfo();
    }
    ever(authCtl.isLogged,(_)=>{
      if(authCtl.isLog == true){
        setProfileInfo()
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}