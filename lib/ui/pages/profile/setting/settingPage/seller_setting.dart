import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';

class SellerSetView extends GetView<SellerSetController>{
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
      body:Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.px),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("卖家简介",style: TextStyle(fontSize: 16.px),),
            ),
            Divider(height: 1,color: Colors.grey[300],),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 5.px),
              child: TextField(
                controller: controller.textCtl,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                maxLength: 100,
                style: TextStyle(fontSize: 14.px),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
                ),
                onChanged: (value){
                  controller.setSummary(value);
                },
              ),
            ),
            SizedBox(height: 5.px,),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10.px),
              child: TextButton(
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
                onPressed: (){
                  controller.resetSummary(controller.summary);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SellerSetController extends GetxController {
   AuthController authCtl = Get.find<AuthController>();
   TextEditingController textCtl;

   final _summary = "".obs;

   String get summary => _summary.value;
   void setSummary(value) => _summary.value = value;

   //更改卖家简介
   void resetSummary(String summary) async{
     try{
       ApiResponse update = await UserService.setSummary(summary: summary);
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
    textCtl = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    textCtl.text = authCtl.user.summary;
    super.onReady();
  }

  @override
  void onClose() {
    textCtl.dispose();
    super.onClose();
  }
}