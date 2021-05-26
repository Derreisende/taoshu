import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/category/category_controller.dart';
import 'package:booksea/ui/pages/profile/profile_controller.dart';
import 'package:booksea/ui/utils/permission_helper.dart';
import 'package:booksea/ui/pages/main/main_controller.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/shared/size_fit.dart';
import 'package:booksea/ui/shared/app_theme.dart';
import 'package:booksea/init.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/utils/r.dart';

import 'core/router/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //初始化全局配置后启动程序
  Global.init().then((e) => runApp(MyApp()));
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,  //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //请求授权处理
  bool allow = await PermissionHelper.check(
      PermissionType.storage,
      errMsg: '读取设备上的照片及文件',
      onErr: () {
        SystemNavigator.pop();
      },
      onSuc: () async {}
  );
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    SizeFit.initialize();
    MainController mainCtl = Get.put<MainController>(MainController());
    CartController cartCtl = Get.put<CartController>(CartController());
    CategoryController cateCtl = Get.put<CategoryController>(CategoryController());
    ProfileController profileCtl = Get.put<ProfileController>(ProfileController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "书海",
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      //隐藏键盘
      builder: (context, child) => Scaffold(
          // Global GestureDetector that will dismiss the keyboard
          body: GestureDetector(
            onTap: () {
                  R.hideKeyBoard(context);
            },
            child: child,
          ),
        ),
      defaultTransition: Transition.fade,
      // 配置路由
      initialRoute: AppPages.SPLASH,
      getPages: AppPages.pages,
      routingCallback: AppPages.routingCallBack,
    );
  }
}
