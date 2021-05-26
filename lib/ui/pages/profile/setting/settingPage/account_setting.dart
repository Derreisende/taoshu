import 'package:booksea/core/router/app_pages.dart';
import 'package:flui/flui.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/extension/num_extension.dart';

class AccountSetController extends GetxController {

}

class AccountSetView extends GetView<AccountSetController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帐号管理"),
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
            backgroundColor: Colors.white,
            leading: Icon(MyIcons.account,size: 20.px),
            title: Text("个人资料"),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
                Get.toNamed(AppPages.EDITUSERINFO);
            },
          ),
          Divider(height: 1,color: Colors.grey[200],),
          FLListTile(
            backgroundColor: Colors.white,
            leading: Icon(MyIcons.pwd,size: 18.px),
            title: Text("修改登录密码"),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
                Get.toNamed(AppPages.RESETPWD);
            }
          ),
          Divider(height: 1,color: Colors.grey[200],),
        ],
      ),
    );
  }
}