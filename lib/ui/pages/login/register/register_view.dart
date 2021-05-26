import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:common_utils/common_utils.dart';

import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/login/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var _email = "";
    var _phone = "";
    var _pwd = "";
    var _nickName = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.px,right: 15.px),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined,color: Colors.black45,),
                          labelText: "邮箱",
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),)
                        ),
                      validator: (String value){
                        if(RegexUtil.isEmail(value) == false){
                          return "请输入正确的邮箱";
                        }
                        return null;
                      },
                      onSaved: (value){
                          _email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone_android,color: Colors.black45,),
                          labelText: "手机号",
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),)
                      ),
                      validator: (String value){
                          if(RegexUtil.isMobileExact(value) == false){
                              return "请输入正确的手机号";
                            }
                            return null;
                      },
                      onSaved: (value){
                        _phone = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(MyIcons.pwd,color: Colors.black45,),
                          labelText: "密码",
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),)
                      ),
                      validator: (String value){
                        if(value.length<6 || value.length > 16){
                          return "密码长度为6~20位";
                        }
                            return null;
                      },
                      onSaved: (value){
                        _pwd = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(MyIcons.account,color: Colors.black45,),
                          labelText: "昵称(中英文和数字)",
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),)
                      ),
                      validator: (String value){
                        bool isUser = RegexUtil.matches(r"^[ZA-ZZa-z0-9_]+$", value);
                        if (isUser == false) {
                          return '请输入正确的昵称';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _nickName = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
                child: Text("注册",style: TextStyle(fontSize: 16.px),),
                onPressed: (){
                      if(controller.formKey.currentState.validate()){
                        controller.formKey.currentState.save();
                        controller.handleRegister(_email, _phone, _pwd, _nickName);
                      }
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                      //默认状态使用灰色
                      return Colors.white;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //设置按下时的背景颜色
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue;
                    }
                    //默认不使用背景颜色
                    return Colors.lightBlue;
                  }),
                  minimumSize: MaterialStateProperty.all(Size(Get.width-20.px,36.px)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.px)))),
                  )
              ),
            ]
      )
    );
  }
}