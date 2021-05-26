import 'package:flutter/material.dart';

class R {
  //静态资源前缀地址
  static String sourceUrl = "http://www.jaysite.top";

  // 本地图片
  static final String assetsImagesSplash = 'assets/images/appIcon/launch_image.png';
  static final String assetsImageProfile = "assets/images/profile_bg/海滩3.png";

  // 一些全局方法
  static void hideKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}