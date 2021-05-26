import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/auth_service.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  handleRegister(email, phoneNumber, pwd, nickname) async{
    try{
      //发送注册请求
      ApiResponse<String> regis = await AuthService.register(email, phoneNumber, pwd, nickname);
        if(regis.status == Status.COMPLETED){
          //如果成功收到数据
          Fluttertoast.showToast(
              msg: regis.data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 14.0.px
          );
          Get.back();
        }else{
          //如果错误
          Fluttertoast.showToast(
              msg: regis.exception.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 14.0.px
          );
        }
    }catch (e) {
      Fluttertoast.showToast(
          msg: "错误",
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
  void onClose() {

    super.onClose();
  }
}