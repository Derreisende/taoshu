import 'dart:io';
import 'package:get/get.dart' hide FormData;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:booksea/ui/widgets/Picker.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';

import '../../profile_controller.dart';


class UserInfoView extends GetView<UserInfoController>{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑个人资料"),
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
      body: Obx(()=>controller.authCtl.user.avatar == null ? Center(child: CircularProgressIndicator(),) :
      Column(
        children: [
          buildListTile(
              title: "头像",
              trailing:  ClipOval(
                  child: Image.network(R.sourceUrl+controller.authCtl.user.avatar,
                    fit: BoxFit.cover,
                    width: 60.px,
                    height: 60.px,
                  ),
              ),
              onTap: (){
                Get.bottomSheet(
                  Container(
                      height: 93.px,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () async{
                                controller.getImageFromCamera();
                                Get.back();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 46.px,
                                  padding: EdgeInsets.symmetric(vertical: 10.px),
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Text("相机拍摄",style: TextStyle(fontSize: 14.px)))
                          ),
                          Divider(height: 1.px,color: Colors.black38,),
                          GestureDetector(
                              onTap: (){
                                controller._getImageFromGallery();
                                Get.back();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 46.px,
                                  width: double.infinity,
                                  color:Colors.white,
                                  child: Text("从相册选择", style: TextStyle(fontSize: 14.px),)))
                        ],
                      )
                  ),
                  backgroundColor: Color(0xffe9e9e9), // 底部bottomSheet的背景色
                  elevation: 10.0,
                );
              }
          ),
          Divider(height: 1,color: Colors.grey[200],),
          buildListTile(
              title: "昵称",
              trailing: Text(controller.authCtl.user.nickname,style: TextStyle(fontSize: 12.px,color: Colors.black54),),
              onTap: (){
                Get.defaultDialog(
                  title: "昵称",
                  content: TextField(
                    maxLength: 10,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))
                    ),
                    onChanged: (value){
                      controller.setNickname(value);
                    },
                  ),
                  confirm: buildConfirmBtn(onPressed: (){
                    controller.resetNickName(controller.nickname);
                    Get.back();
                  }),
                  cancel: buildCancelBtn(onPressed: (){
                    Get.back();
                  }),
                );
              }
          ),
          Divider(height: 1,color: Colors.grey[200],),
          buildListTile(
              title: "性别",
              trailing: Text(controller.authCtl.user.sex,style: TextStyle(fontSize: 12.px,color: Colors.black54),),
              onTap: (){
                var pickAppearance = ["男","女","保密"];
                PickHelper.openSimpleDataPicker(context, list: pickAppearance, value: "保密", onConfirm: (index,value){
                  controller.resetSex(value);
                });
              }
          ),
          Divider(height: 1,color: Colors.grey[200],),
          buildListTile(
              title: "所在地",
              trailing: Text(controller.authCtl.user.address,style: TextStyle(fontSize: 12.px,color: Colors.black54),),
              onTap: (){
                PickHelper.openCityPicker(context, onConfirm: (data, index){
                  String province = data[0].substring(0,data[0].length-1);
                  String city = data[1].substring(0,data[1].length-1);
                  controller.resetAddress(province + city);
                });
              }
          ),
          Divider(height: 1,color: Colors.grey[200],),
          buildListTile(
              title: "个人签名",
              trailing: Container(
                alignment: Alignment.centerRight,
                width: Get.width / 1.6,
                child: Text(
                    controller.authCtl.user.signature,
                    style: TextStyle(fontSize: 12.px,color: Colors.black54),
                    maxLines: 1,
                ),
              ),
              onTap: (){
                Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.px),
                    height: Get.height / 3.6,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: buildCancelBtn(onPressed: (){
                                Get.back();
                              }),
                            ),
                            Container(
                              child: buildConfirmBtn(onPressed: (){
                                controller.setSignature(controller.signature);
                                controller.resetSignature(controller.signature);
                                Get.back();
                              }),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextField(
                            controller: controller.textCtl,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            maxLength: 100,
                            style: TextStyle(fontSize: 14.px),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
                                counterStyle: TextStyle(fontSize: 12.px,color: Colors.grey),
                            ),
                            onChanged: (value){
                              controller.setSignature(value);
                            },
                          ),
                      //    color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white
                );
              }
          ),
          Divider(height: 1,color: Colors.grey[200],),
        ],
      ), )
    );
  }
  Widget buildListTile({String title,Widget trailing,Function onTap}){
   return GestureDetector(
     onTap: onTap,
     child: Container(
       padding: EdgeInsets.symmetric(vertical: 16),
       color: Colors.white,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text("    "+title,style: TextStyle(fontSize: 14.px),),
           Row(
             children: [
               trailing,
               SizedBox(width: 5,),
               Icon(Icons.navigate_next,color: Colors.black38,),
               SizedBox(width: 10,),
             ],
           )
         ],
       ),
     ),
   );
  }

  Widget buildConfirmBtn({Function onPressed}){
   return TextButton(
     child: Text("确定",style: TextStyle(fontSize: 13.px),),
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
         minimumSize: MaterialStateProperty.all(Size(40.px,20.px)),
         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.px)))
     ),
     onPressed: onPressed,
   );
  }

 Widget buildCancelBtn({Function onPressed}){
   return TextButton(
     child: Text("取消",style: TextStyle(fontSize: 13.px),),
     style: ButtonStyle(
         padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 5.px)),
         foregroundColor: MaterialStateProperty.resolveWith((states) {
           //默认状态
           return Colors.white;
         },
         ),
         backgroundColor: MaterialStateProperty.resolveWith((states) {
           //默认不使用背景颜色
           return Colors.grey[400];
         }),
         overlayColor: MaterialStateProperty.all(Colors.transparent),
         minimumSize: MaterialStateProperty.all(Size(40.px,20.px)),
         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.px)))
     ),
     onPressed: onPressed,
   );
 }
}

class UserInfoController extends GetxController {
  AuthController authCtl = Get.find<AuthController>();
  ProfileController profileCtl = Get.find<ProfileController>();
  TextEditingController textCtl;

  final _signature = "".obs;
  final _nickname = "".obs;
  File _image;

  File get image => _image;
  String get signature => _signature.value;
  String get nickname => _nickname.value;

  void setSignature(value) => _signature.value = value;
  void setNickname(value) => _nickname.value = value;

  //拍照
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    _image = image;
    uploadAvatar(image);
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _image = image;

    uploadAvatar(image);
  }

  void uploadAvatar(File imageFile) async{
    try{
      ApiResponse upAvatar = await UserService.setAvatar(image:imageFile);
      Fluttertoast.showToast(
          msg: upAvatar.data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
      authCtl.setUser();
      Future.delayed(Duration(milliseconds: 1000),(){
        profileCtl.setProfileInfo();
      });
    }catch(e){
      print(e);
    }
  }
  //修改昵称
  void resetNickName(String nickname) async{
    try{
      ApiResponse update = await UserService.setNickName(nickname: nickname);
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
      Future.delayed(Duration(milliseconds: 1000),(){
        profileCtl.setProfileInfo();
      });
    }catch(e){
      print(e);
    }
  }
  //修改性别
  void resetSex(String sex) async{
    try{
      ApiResponse update = await UserService.setSex(sex: sex);
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
    }catch(e){
      print(e);
    }
  }
  //所在地
  void resetAddress(String address) async{
    try{
      ApiResponse update = await UserService.setAddress(address: address);
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
    }catch(e){
      print(e);
    }
  }
  //个人签名
  void resetSignature(String signature) async{
    try{
      ApiResponse update = await UserService.setSignature(signature: signature);
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
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() {
    textCtl = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    setSignature(authCtl.user.signature);
    textCtl.text = signature;
    super.onReady();
  }

  @override
  void onClose() {
    textCtl.dispose();
    super.onClose();
  }
}