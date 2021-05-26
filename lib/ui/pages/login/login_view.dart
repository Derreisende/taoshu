import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/pages/main/main_controller.dart';
import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/pages/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
MainController mainCtl = Get.find<MainController>();
AuthController authCtl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        leading: IconButton(
          icon: Icon(MyIcons.close),
          iconSize: 16.px,
          onPressed: ()=>{
            mainCtl.changeTabIndex(mainCtl.currentIndex),
            if(authCtl.isLog == true){
              Get.back()
            }else{
              if(authCtl.logoutState == true){
                mainCtl.changeTabIndex(0),
                mainCtl.changePageIndex(0),
                Get.offAllNamed(AppPages.MAIN)
              }else{
                Get.back()
               }
            }
          },
        ),
      ),
      body: Obx(()=>WillPopScope(
        onWillPop: () async{
          if(authCtl.logoutState == true){
            Get.offAllNamed(AppPages.MAIN);
            mainCtl.changeTabIndex(0);
            mainCtl.changePageIndex(0);
            authCtl.changeLogoutState(false);
            return true;
          }
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.px,),
            //帐号输入框
            inputWidget(context,
              focus: true,
              hintText: "手机号/邮箱",
              icon: Icon(MyIcons.account,color: Colors.grey,),
              change: (value) => controller.changeAccount(value),
            ),
            //密码输入框
            inputWidget(context,
                hintText: "密码",
                icon: Icon(MyIcons.pwd,color: Colors.grey),
                change: (value) => controller.changePwd(value),
                obscureText: controller.passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    //根据passwordVisible状态显示不同的图标
                    controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    //密码是否可见
                    controller.changePwdVisible();
                  },
            ),
            ),
            SizedBox(height: 10.px,),
            //登录按钮
            FLLoadingButton(
                child: Text('登录',style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w400)),
                color: Colors.lightBlue,
                focusColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                textTheme: ButtonTextTheme.normal,
                disabledColor: Colors.grey[400],
                indicatorColor: Colors.white,
                textColor: Colors.white,
                loading: controller.loading,
                minWidth: 350.px,
                height: 44.px,
                indicatorOnly: true,
                onPressed: controller.account == "" || controller.pwd == ""? null : (){
                  controller.changeLoading();
                  controller.handleSignIn();
                }
            ),
            SizedBox(
              width: 350.px,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: ()=>{
                        Get.toNamed(AppPages.REGISTER)
                      },
                      child: Text("注册新用户",style: TextStyle(color: Colors.blueGrey,fontSize: 10.px),),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),

                  ),
                  TextButton(
                      onPressed: ()=>{

                  },
                      child: Text("忘记密码?",style: TextStyle(color: Colors.blueGrey,fontSize: 10.px),))
                ],
              ),
            )
          ],
        ),
      )) ,
      resizeToAvoidBottomInset: false,
    );
  }
}


// 输入框
Widget inputWidget(BuildContext context,{
  String hintText,
  Widget icon,
  Function change,
  bool obscureText = false,
  bool focus = false,
  Widget suffixIcon
}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10.px),
      alignment: Alignment.center,
      child: TextField(
        autofocus: focus,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: icon,
          hintText: "请输入" + hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),)
        ),
        onChanged: (val) => change(val),
  ),
    );
}

