import 'package:booksea/ui/utils/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/utils/app_config.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/pages/home/home_content.dart';
import 'package:booksea/ui/pages/home/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeCtl = Get.put<HomeController>(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextButton(
              child: Row(
                children: [
                  Icon(MyIcons.search,color: Colors.black45,),
                  Text("请输入书名/ISBN搜索",style: TextStyle(fontSize: 10.px)),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  //默认状态使用灰色
                  return Colors.black45;
                },
                ),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //默认不使用背景颜色
                  return Colors.transparent;
                }),
                minimumSize: MaterialStateProperty.all(Size(Get.width-20.px,24.px)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blueAccent,width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.px)))),
              ),
            onPressed: (){
                Get.toNamed(AppPages.SEARCH);
            },
            ),
        ),
        toolbarHeight: AppConfig.toolbarHeight + 10.px,
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              //扫一扫按钮
              child: IconButton(
                icon: Icon(MyIcons.scan),
                iconSize: 20.px,
                onPressed: () async {
                  //请求授权处理
                  bool allow = await PermissionHelper.check(
                      PermissionType.camera,  //相机使用权限
                      errMsg: '请授予相机权限',
                      onErr: () {
                        //返回
                        Get.back();
                      },
                      onSuc: () async {
                        //跳转到扫一扫页面
                        Get.toNamed(AppPages.QRSCAN, arguments: "searchBook");
                      }
                  );
                }
             ),
            ),
            Expanded(child: Text("扫一扫",style: TextStyle(fontSize: 8.px,color: Colors.black),))
          ],
        ),
        //  actionsIconTheme: IconThemeData(color: Colors.black45),
      ),
      body: HomeContent(),
    );
  }
}
