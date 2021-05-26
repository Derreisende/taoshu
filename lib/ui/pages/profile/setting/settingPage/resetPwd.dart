import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';

class ResetPwdView extends GetView<ResetPwdController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改登录密码"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey[200])),
      ),
      body: Obx(()=>Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 3.px),
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Text("原登录密码",style: TextStyle(fontSize: 15.px),),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      style: TextStyle(fontSize: 14.px),
                      decoration: InputDecoration(
                        hintText: "原登录密码",
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      ),
                      onChanged: (value){
                        controller.setOriPwd(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1,color: Colors.grey[300],),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 3.px),
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Text("设置新密码",style: TextStyle(fontSize: 15.px),),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      obscureText: controller.obscure,
                      style: TextStyle(fontSize: 14.px),
                      decoration: InputDecoration(
                        hintText: "6-20个字符",
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            //根据passwordVisible状态显示不同的图标
                            controller.obscure == false ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: (){
                            //密码是否可见
                            controller.changeObscure();
                            print(controller.obscure);
                          },
                        ),
                      ),
                      onChanged: (value){
                        controller.setNewPwd(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.px,),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10.px),
              child: TextButton(
                child: Text("提交",style: TextStyle(fontSize: 14.px),),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 5.px)),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      //默认状态
                      return Colors.white;
                    },
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      //默认不使用背景颜色
                      return Colors.redAccent;
                    }),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    minimumSize: MaterialStateProperty.all(Size(Get.width-40.px,40.px)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.px)))
                ),
                onPressed: (){
                  controller.resetPwd(oldPwd: controller.originalPwd, newPwd: controller.newPwd);

                },
              ),
            )
          ],
        ),
      ),)
    );
  }
}

class ResetPwdController extends GetxController {
  AuthController authCtl = Get.find<AuthController>();

  final _originalPwd = "".obs;
  final _newPwd = "".obs;
  final _obscure = true.obs;

  String get originalPwd => _originalPwd.value;
  void setOriPwd(value) => _originalPwd.value = value;
  String get newPwd => _newPwd.value;
  void setNewPwd(value) => _newPwd.value = value;
  bool get obscure => _obscure.value;
  void changeObscure() => _obscure.value = !_obscure.value;

  //更改卖家简介
  void resetPwd({String oldPwd,String newPwd}) async{
    try{
      ApiResponse update = await UserService.resetPwd(oldPwd: oldPwd,newPwd: newPwd);
      Fluttertoast.showToast(
          msg: update.data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
      authCtl.setUser();
    }catch(e) {
      Fluttertoast.showToast(
          msg: "修改失败",
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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}