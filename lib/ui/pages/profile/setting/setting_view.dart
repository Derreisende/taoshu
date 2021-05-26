import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/services/request/auth_service.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("设置"),
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
     body: Column(
       children: [
         FLListTile(
           title: Text('账号管理'),
           trailing: Icon(Icons.navigate_next),
           onTap: (){
              Get.toNamed(AppPages.ACCOUNTSET);
           },
           backgroundColor: Colors.white,
         ),
         Divider(height: 1,color: Colors.grey[200],),
         FLListTile(
           title: Text('卖家主页设置'),
           trailing: Icon(Icons.navigate_next),
           onTap: (){
              Get.toNamed(AppPages.SELLERSET);
           },
           backgroundColor: Colors.white,
         ),
         Divider(height: 1,color: Colors.grey[200],),
         SizedBox(height: 10.px,),
         FLListTile(
           title: Text('关于'),
           trailing: Icon(Icons.navigate_next),
           onTap: (){

           },
           backgroundColor: Colors.white,
         ),
         SizedBox(height: 20.px,),
         TextButton(onPressed: (){
           Get.dialog(
             Center(
               child: Container(
                 height: 100.px,
                 width: Get.width/1.5,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10.px))
                 ),
                 child: Column(
                   children: [
                     Expanded(
                       child: Column(
                         children: [
                           SizedBox(height: 5.px,),
                           Text("退出帐号",style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w600),),
                           SizedBox(height: 5.px,),
                           Text("确认退出当前账号",style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w200)),
                         ],
                       ),
                     ),
                     Divider(height: 1,color: Colors.grey[300],),
                     Container(
                       padding: EdgeInsets.symmetric(vertical: 10.px),
                       child: Row(
                         children: [
                           Expanded(
                              child: GestureDetector(
                                child: Center(
                                   child: Text("取消",style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w500),)
                                     ),
                                onTap: (){
                                  Get.back();
                                },
                              )
                           ),
                             Expanded(
                              child:GestureDetector(
                                 child: Center(
                                     child: Text("确定",style: TextStyle(fontSize: 14.px,color: Colors.deepOrangeAccent,fontWeight: FontWeight.w500)
                                     )
                                 ),
                              onTap: (){
                               AuthService.logOut();
                               AuthController authCtl = Get.find();
                               authCtl.handleLog();
                               authCtl.changeLogoutState(true);
                               Get.offAllNamed(AppPages.LOGIN);
                             },
                           ),
                           )
                         ],
                       ),
                     )

                   ],
                 ),
               ),
             ),
               transitionDuration: Duration(milliseconds: 200),
               transitionCurve: Threshold(0.2)
           );
         }, child: Text("退出登录"),
         style: ButtonStyle(
           padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 10.px)),
           foregroundColor: MaterialStateProperty.resolveWith((states) {
             //默认状态使用白色
             return Colors.white;
           },
           ),
           backgroundColor: MaterialStateProperty.resolveWith((states) {
             //设置按下时的背景颜色
             if (states.contains(MaterialState.pressed)) {
               return Colors.deepOrange;
             }
             //默认不使用背景颜色
             return Colors.deepOrange[300];
           }),
           minimumSize: MaterialStateProperty.all(Size(Get.width-20.px,40.px)),
           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.px)))),

         ),
         )
       ],
     ),
   );
 }
}