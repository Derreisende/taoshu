import 'package:flui/flui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/main/main_controller.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/pages/main/initialize_items.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';

class MainPage extends StatelessWidget {
  MainController mainCtl = Get.find<MainController>();
  AuthController authController = Get.find<AuthController>();
  CartController cartCtl = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    DateTime _lastPressedAt; // 上次点击时间
    return Obx(()=>Scaffold(
        body: WillPopScope(
          onWillPop: () async{
            if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)){
              _lastPressedAt = DateTime.now();
              Fluttertoast.showToast(
                  msg: "再按一次推出",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 12.0.px
              );
              return false;
            }
            return true;
          },
          child: IndexedStack(
            index: mainCtl.currentIndex,
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5.px,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: mainCtl.currentIndex,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.black45,
          onTap: (index) {
            if(index == 2 || index == 3){
              if(!authController.isLog){
                Get.toNamed("/login");
                mainCtl.changeTabIndex(index);
              }else{
                mainCtl.changeTabIndex(index);
                mainCtl.changePageIndex(index);
              }
            }else{
              mainCtl.changeTabIndex(index);
              mainCtl.changePageIndex(index);
            }
          },
          items: [
            BottomNavigationBarItem(
                title: Text("首页"),
                icon: Icon(MyIcons.home_outlined),
                activeIcon: Icon(MyIcons.home_filled)
            ),
            BottomNavigationBarItem(
                title: Text("分类"),
                icon: Icon(MyIcons.category_outlined),
                activeIcon: Icon(MyIcons.category_filled)
            ),
            BottomNavigationBarItem(
                title: Text("购物车"),
                icon: FLBadge(child: Icon(MyIcons.shopping_cart_outlined),
                  hidden: authController.showBadge.value,
                  text: cartCtl.cartList.length.toString(),
                  textStyle: TextStyle(color: Colors.white,fontSize: 8.px),
                ),
                activeIcon: FLBadge(child: Icon(MyIcons.shopping_cart_filled),
                  hidden: authController.showBadge.value,
                  text: cartCtl.cartList.length.toString(),
                  textStyle: TextStyle(color: Colors.white,fontSize: 8.px),
                )
            ),
            BottomNavigationBarItem(
                title: Text("我的"),
                icon: Icon(MyIcons.user_outlined),
                activeIcon: Icon(MyIcons.user_filled)
            )
          ],
        )
    ));
  }
}





