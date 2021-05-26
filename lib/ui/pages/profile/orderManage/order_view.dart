import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/ui/pages/profile/orderManage/order_controller.dart';

import 'order_detail_view.dart';

class OrderView extends GetView<OrderController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: controller.tabCtl,
            children:  <Widget>[ // 每个空间对应的页面
              OrderDetailView(),
              OrderDetailView(),
              OrderDetailView(),
              OrderDetailView(),
              OrderDetailView(),
              OrderDetailView(),
            ],
          ),
          TabBar(
            controller: controller.tabCtl,// 设置控制器
            labelColor: Colors.lightBlue, //选中的颜色
            labelStyle: TextStyle(fontSize: 16), //选中的样式
            unselectedLabelColor: Colors.black, //未选中的颜色
            unselectedLabelStyle: TextStyle(fontSize: 14), //未选中的样式
            indicatorColor: Colors.lightBlue, //下划线颜色
            isScrollable: true, //是否可滑动，设置不可滑动，则是tab的宽度等长
            //tab标签
            tabs: buildTabItems(), // 设置标题
          )
        ],
      )
    );
  }
}

List<Tab> buildTabItems(){
  return <Tab>[
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("全部"),
    ),
    ),
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("待付款"),
    )),
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("待发货"),
    )),
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("已发货"),
    )),
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("待评价"),
    )),
    Tab(child: Container(
      alignment: Alignment.center,
      width: Get.width/5,
      child: Text("退款/售后"),
    )),
  ];
}
