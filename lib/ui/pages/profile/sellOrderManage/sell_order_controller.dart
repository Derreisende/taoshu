import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellOrderController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabCtl;// tab控制器
  String tabIndex = Get.arguments;

  @override
  void onInit() {
    tabCtl = TabController(initialIndex: 0,length: 5,vsync: this);
    if(tabIndex != null){
      tabCtl.animateTo(int.parse(tabIndex));
    }
    super.onInit();
  }
  @override
  void onClose() {
    tabCtl.dispose();
    super.onClose();
  }
}