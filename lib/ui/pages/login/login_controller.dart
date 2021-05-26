import 'dart:developer';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/pages/main/main_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/utils/get_extension.dart';
import 'package:booksea/core/services/request/auth_service.dart';
import 'package:booksea/core/model/user_model.dart';
import 'package:booksea/core/services/api_response.dart';

class LoginController extends GetxController {
    AuthController authController = Get.find<AuthController>();
    MainController mainCtl = Get.find<MainController>();
    ProfileController profileCtl = Get.find<ProfileController>();
    final _account = "".obs;
    final _pwd = "".obs;
    final _loading = false.obs;
    final _passwordVisible = true.obs;

    String get account => _account.value;
    String get pwd => _pwd.value;
    bool get loading => _loading.value;
    bool get passwordVisible => _passwordVisible.value;

    void changeAccount(value) => _account.value = value;
    void changePwd(value) => _pwd.value = value;
    void changeLoading() => _loading.value = !_loading.value;
    void changePwdVisible() => _passwordVisible.value = !_passwordVisible.value;

    handleSignIn() async {
        //加载弹窗
        Get.loading();
        try {
            // 发送登录请求
            ApiResponse<UserModel> loginRes = await AuthService.login(account, pwd);
            if(loginRes.status == Status.COMPLETED) {
                changeLoading();  //改变加载状态
                authController.initUser(loginRes.data);    //初始化用户数据
                Get.dismiss();    //关闭加载弹窗
                Get.offAllNamed(AppPages.MAIN);       //返回之前点击的页面
                authController.handleLog();  //改变登录状态
                mainCtl.changePageIndex(mainCtl.tabIndex); //改变导航页面
            }else{
                changeLoading();
                Get.dismiss();
                Fluttertoast.showToast(
                    msg: loginRes.exception.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 14.0.px
                );
            }
        }  catch(e)  {
            changeLoading();
            Get.dismiss();
            Fluttertoast.showToast(
                msg: "未知错误",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 14.0.px
            ); //错误弹窗
            print(e);
        }
    }

    @override
  void onInit() async{
      super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
}
